import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:pilll/analytics.dart';
import 'package:pilll/auth/apple.dart';
import 'package:pilll/auth/google.dart';
import 'package:pilll/database/batch.dart';
import 'package:pilll/database/database.dart';
import 'package:pilll/domain/initial_setting/initial_setting_state.codegen.dart';
import 'package:pilll/entity/link_account_type.dart';
import 'package:pilll/entity/pill_sheet_group.codegen.dart';
import 'package:pilll/entity/pill_sheet_type.dart';
import 'package:pilll/entity/setting.codegen.dart';
import 'package:pilll/provider/pill_sheet.dart';
import 'package:pilll/provider/pill_sheet_group.dart';
import 'package:pilll/provider/pill_sheet_modified_history.dart';
import 'package:pilll/provider/setting.dart';
import 'package:pilll/service/auth.dart';
import 'package:pilll/database/pill_sheet.dart';
import 'package:pilll/database/pill_sheet_group.dart';
import 'package:pilll/database/pill_sheet_modified_history.dart';
import 'package:pilll/database/setting.dart';
import 'package:pilll/database/user.dart';
import 'package:pilll/util/datetime/day.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod/riverpod.dart';

final initialSettingStoreProvider = StateNotifierProvider.autoDispose<InitialSettingStateStore, InitialSettingState>(
  (ref) => InitialSettingStateStore(
    ref.watch(userDatastoreProvider),
    ref.watch(batchFactoryProvider),
    ref.watch(batchSetSettingProvider),
    ref.watch(batchSetPillSheetsProvider),
    ref.watch(batchSetPillSheetModifiedHistoryProvider),
    ref.watch(batchSetPillSheetGroupProvider),
    ref.watch(authStateStreamProvider),
    now(),
  ),
);

final initialSettingStateProvider = StateProvider.autoDispose((ref) => ref.watch(initialSettingStoreProvider));

class InitialSettingStateStore extends StateNotifier<InitialSettingState> {
  final UserDatastore userDatastore;
  final BatchFactory batchFactory;
  final BatchSetSetting batchSetSetting;
  final BatchSetPillSheets batchSetPillSheets;
  final BatchSetPillSheetModifiedHistory batchSetPillSheetModifiedHistory;
  final BatchSetPillSheetGroup batchSetPillSheetGroup;
  final Stream<User> authStateStream;

  InitialSettingStateStore(
    this.userDatastore,
    this.batchFactory,
    this.batchSetSetting,
    this.batchSetPillSheets,
    this.batchSetPillSheetModifiedHistory,
    this.batchSetPillSheetGroup,
    this.authStateStream,
    DateTime _now,
  ) : super(
          InitialSettingState(reminderTimes: [
            ReminderTime(hour: _now.hour, minute: 0),
            ReminderTime(hour: _now.hour + 1, minute: 0),
          ]),
        );

  StreamSubscription? _authServiceCanceller;
  void fetch() {
    _authServiceCanceller = authStateStream.listen((user) async {
      debugPrint("watch sign state user: $user");

      final userIsNotAnonymous = !user.isAnonymous;
      if (userIsNotAnonymous) {
        final userDatastore = UserDatastore(DatabaseConnection(user.uid));
        final dbUser = await userDatastore.fetchOrCreate(user.uid);
        userDatastore.saveUserLaunchInfo(dbUser);

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

  void selectedFirstPillSheetType(PillSheetType pillSheetType) {
    state = state.copyWith(pillSheetTypes: [
      pillSheetType,
      pillSheetType,
      pillSheetType,
    ]);
  }

  void addPillSheetType(PillSheetType pillSheetType) {
    state = state.copyWith(pillSheetTypes: [...state.pillSheetTypes, pillSheetType]);
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

  Future<void> register() async {
    if (state.pillSheetTypes.isEmpty) {
      throw AssertionError("Must not be null for pillSheet when register initial settings");
    }

    final batch = _batchFactory.batch();

    final todayPillNumber = state.todayPillNumber;
    if (todayPillNumber != null) {
      final createdPillSheets = _pillSheetDatastore.register(
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
      final createdPillSheetGroup = _pillSheetGroupDatastore.register(
        batch,
        PillSheetGroup(
          pillSheetIDs: pillSheetIDs,
          pillSheets: createdPillSheets,
          createdAt: now(),
        ),
      );

      final history = PillSheetModifiedHistoryServiceActionFactory.createCreatedPillSheetAction(
        pillSheetIDs: pillSheetIDs,
        pillSheetGroupID: createdPillSheetGroup.id,
      );
      _pillSheetModifiedHistoryDatastore.add(batch, history);
    }

    final setting = await state.buildSetting();
    _settingDatastore.updateWithBatch(batch, setting);

    await batch.commit();

    await _userDatastore.endInitialSetting(setting);
  }

  void showHUD() {
    state = state.copyWith(isLoading: true);
  }

  void hideHUD() {
    state = state.copyWith(isLoading: false);
  }
}
