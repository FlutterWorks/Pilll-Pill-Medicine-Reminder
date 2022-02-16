import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:pilll/analytics.dart';
import 'package:pilll/auth/apple.dart';
import 'package:pilll/auth/google.dart';
import 'package:pilll/database/batch.dart';
import 'package:pilll/database/database.dart';
import 'package:pilll/domain/initial_setting/initial_setting_state.dart';
import 'package:pilll/entity/link_account_type.dart';
import 'package:pilll/entity/pill_sheet_group.dart';
import 'package:pilll/entity/pill_sheet_type.dart';
import 'package:pilll/entity/setting.dart';
import 'package:pilll/service/auth.dart';
import 'package:pilll/service/pill_sheet.dart';
import 'package:pilll/service/pill_sheet_group.dart';
import 'package:pilll/service/pill_sheet_modified_history.dart';
import 'package:pilll/service/setting.dart';
import 'package:pilll/service/user.dart';
import 'package:pilll/util/datetime/day.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod/riverpod.dart';

final initialSettingStoreProvider = StateNotifierProvider.autoDispose<
    InitialSettingStateStore, InitialSettingState>(
  (ref) => InitialSettingStateStore(
    ref.watch(batchFactoryProvider),
    ref.watch(settingServiceProvider),
    ref.watch(pillSheetServiceProvider),
    ref.watch(pillSheetModifiedHistoryServiceProvider),
    ref.watch(pillSheetGroupServiceProvider),
    ref.watch(authServiceProvider),
  ),
);

final initialSettingStateProvider =
    StateProvider.autoDispose((ref) => ref.watch(initialSettingStoreProvider));

class InitialSettingStateStore extends StateNotifier<InitialSettingState> {
  final BatchFactory _batchFactory;
  final SettingService _settingService;
  final PillSheetService _pillSheetService;
  final PillSheetModifiedHistoryService _pillSheetModifiedHistoryService;
  final PillSheetGroupService _pillSheetGroupService;
  final AuthService _authService;

  InitialSettingStateStore(
    this._batchFactory,
    this._settingService,
    this._pillSheetService,
    this._pillSheetModifiedHistoryService,
    this._pillSheetGroupService,
    this._authService,
  ) : super(InitialSettingState());

  StreamSubscription? _authServiceCanceller;
  fetch() {
    _authServiceCanceller = _authService.stream().listen((user) async {
      print("watch sign state user: $user");

      final userIsNotAnonymous = !user.isAnonymous;
      if (userIsNotAnonymous) {
        final userService = UserService(DatabaseConnection(user.uid));
        final dbUser = await userService.prepare(user.uid);
        userService.saveUserLaunchInfo();

        unawaited(FirebaseCrashlytics.instance.setUserIdentifier(user.uid));
        unawaited(firebaseAnalytics.setUserId(id: user.uid));
        await Purchases.logIn(user.uid);

        state = state.copyWith(userIsNotAnonymous: userIsNotAnonymous);
        state = state.copyWith(settingIsExist: dbUser.setting != null);
        if (isLinkedApple()) {
          state = state.copyWith(accountType: LinkAccountType.apple);
        } else if (isLinkedGoogle()) {
          state = state.copyWith(accountType: LinkAccountType.google);
        }
      }

      _authServiceCanceller?.cancel();
    });
  }

  void selectedPillSheetType(PillSheetType pillSheetType) {
    state = state.copyWith(pillSheetTypes: [pillSheetType]);
    final todayPillNumber = state.todayPillNumber;
    if (todayPillNumber != null &&
        todayPillNumber.pillNumberIntoPillSheet >
            state.pillSheetTypes.first.totalCount) {
      state = state.copyWith(
        todayPillNumber: InitialSettingTodayPillNumber(
          pillNumberIntoPillSheet: state.pillSheetTypes.first.totalCount,
          pageIndex: todayPillNumber.pageIndex,
        ),
      );
    }
  }

  void addPillSheetType(PillSheetType pillSheetType) {
    state = state.copyWith(
        pillSheetTypes: [...state.pillSheetTypes]..add(pillSheetType));
  }

  void changePillSheetType(int index, PillSheetType pillSheetType) {
    final copied = [...state.pillSheetTypes];
    copied[index] = pillSheetType;
    state = state.copyWith(pillSheetTypes: copied);
  }

  void removePillSheetType(index) {
    final copied = [...state.pillSheetTypes];
    copied.removeAt(index);
    state = state.copyWith(pillSheetTypes: copied);
  }

  void setReminderTime({
    required int index,
    required int hour,
    required int minute,
  }) {
    final copied = [...state.reminderTimes];
    if (index >= copied.length) {
      copied.add(ReminderTime(hour: hour, minute: minute));
    } else {
      copied[index] = ReminderTime(hour: hour, minute: minute);
    }
    state = state.copyWith(reminderTimes: copied);
  }

  void setTodayPillNumber({
    required int pageIndex,
    required int pillNumberIntoPillSheet,
  }) {
    state = state.copyWith(
      todayPillNumber: InitialSettingTodayPillNumber(
        pageIndex: pageIndex,
        pillNumberIntoPillSheet: pillNumberIntoPillSheet,
      ),
    );
  }

  void unsetTodayPillNumber() {
    state = state.copyWith(todayPillNumber: null);
  }

  void setFromMenstruation({
    required int pageIndex,
    required int fromMenstruation,
  }) {
    final offset = summarizedPillSheetTypeTotalCountToPageIndex(
        pillSheetTypes: state.pillSheetTypes, pageIndex: pageIndex);
    state = state.copyWith(fromMenstruation: fromMenstruation + offset);
  }

  void pickFromMenstruation({
    required int serializedPillNumberIntoGroup,
  }) {
    state = state.copyWith(fromMenstruation: serializedPillNumberIntoGroup);
  }

  void setDurationMenstruation({
    required int durationMenstruation,
  }) {
    state = state.copyWith(durationMenstruation: durationMenstruation);
  }

  int? retrieveMenstruationSelectedPillNumber(int pageIndex) {
    final _passedTotalCount = summarizedPillSheetTypeTotalCountToPageIndex(
        pillSheetTypes: state.pillSheetTypes, pageIndex: pageIndex);
    if (_passedTotalCount >= state.fromMenstruation) {
      return state.fromMenstruation;
    }
    final diff = state.fromMenstruation - _passedTotalCount;
    if (diff > state.pillSheetTypes[pageIndex].totalCount) {
      return null;
    }
    return diff;
  }

  Future<void> register() async {
    if (state.pillSheetTypes.isEmpty) {
      throw AssertionError(
          "Must not be null for pillSheet when register initial settings");
    }

    final batch = _batchFactory.batch();

    final todayPillNumber = state.todayPillNumber;
    if (todayPillNumber != null) {
      final createdPillSheets = _pillSheetService.register(
        batch,
        state.pillSheetTypes.asMap().keys.map((pageIndex) {
          return InitialSettingState.buildPillSheet(
            pageIndex: pageIndex,
            todayPillNumber: todayPillNumber,
            pillSheetTypes: state.pillSheetTypes,
          );
        }).toList(),
      );

      final pillSheetIDs = createdPillSheets.map((e) => e.id!).toList();
      final createdPillSheetGroup = _pillSheetGroupService.register(
        batch,
        PillSheetGroup(
          pillSheetIDs: pillSheetIDs,
          pillSheets: createdPillSheets,
          createdAt: now(),
        ),
      );

      final history = PillSheetModifiedHistoryServiceActionFactory
          .createCreatedPillSheetAction(
        pillSheetIDs: pillSheetIDs,
        pillSheetGroupID: createdPillSheetGroup.id,
      );
      _pillSheetModifiedHistoryService.add(batch, history);
    }

    _settingService.updateWithBatch(batch, state.buildSetting());

    await batch.commit();
  }

  showHUD() {
    state = state.copyWith(isLoading: true);
  }

  hideHUD() {
    state = state.copyWith(isLoading: false);
  }
}
