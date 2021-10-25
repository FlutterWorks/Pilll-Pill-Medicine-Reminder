import 'dart:async';

import 'package:pilll/database/batch.dart';
import 'package:pilll/domain/settings/today_pill_number/setting_today_pill_number_state.dart';
import 'package:pilll/domain/settings/today_pill_number/setting_today_pill_number_store_parameter.dart';
import 'package:pilll/entity/pill_sheet.dart';
import 'package:pilll/entity/pill_sheet_group.dart';
import 'package:pilll/entity/pill_sheet_type.dart';
import 'package:pilll/service/pill_sheet.dart';
import 'package:pilll/service/pill_sheet_group.dart';
import 'package:pilll/service/pill_sheet_modified_history.dart';
import 'package:pilll/util/datetime/day.dart';
import 'package:riverpod/riverpod.dart';

final settingTodayPillNumberStoreProvider =
    StateNotifierProvider.autoDispose.family(
  (ref, SettingTodayPillNumberStoreParameter parameter) =>
      SettingTodayPillNumberStateStore(
    parameter,
    ref.watch(batchFactoryProvider),
    ref.watch(pillSheetServiceProvider),
    ref.watch(pillSheetGroupServiceProvider),
    ref.watch(pillSheetModifiedHistoryServiceProvider),
  ),
);

class SettingTodayPillNumberStateStore
    extends StateNotifier<SettingTodayPillNumberState> {
  final BatchFactory _batchFactory;
  final PillSheetService _pillSheetService;
  final PillSheetGroupService _pillSheetGroupService;
  final PillSheetModifiedHistoryService _pillSheetModifiedHistoryService;

  SettingTodayPillNumberStateStore(
    SettingTodayPillNumberStoreParameter _parameter,
    this._batchFactory,
    this._pillSheetService,
    this._pillSheetGroupService,
    this._pillSheetModifiedHistoryService,
  ) : super(
          SettingTodayPillNumberState(
            selectedPillSheetPageIndex: _parameter.activedPillSheet.groupIndex,
            selectedPillMarkNumberIntoPillSheet: _pillNumberIntoPillSheet(
              activedPillSheet: _parameter.activedPillSheet,
              pillSheetGroup: _parameter.pillSheetGroup,
            ),
          ),
        );

  markSelected({
    required int pageIndex,
    required int pillNumberIntoPillSheet,
  }) {
    state = state.copyWith(
      selectedPillMarkNumberIntoPillSheet: pillNumberIntoPillSheet,
      selectedPillSheetPageIndex: pageIndex,
    );
  }

  Future<void> modifiyTodayPillNumber({
    required PillSheetGroup pillSheetGroup,
    required PillSheet activedPillSheet,
  }) async {
    final batch = _batchFactory.batch();

    final pillSheetTypes =
        pillSheetGroup.pillSheets.map((e) => e.pillSheetType).toList();
    final nextSerializedPillNumber =
        summarizedPillSheetTypeTotalCountToPageIndex(
              pillSheetTypes: pillSheetTypes,
              pageIndex: state.selectedPillSheetPageIndex,
            ) +
            state.selectedPillMarkNumberIntoPillSheet;
    final firstPilSheetBeginDate =
        today().subtract(Duration(days: nextSerializedPillNumber));

    final List<PillSheet> updatedPillSheets = [];
    pillSheetGroup.pillSheets.asMap().keys.forEach((index) {
      final pillSheet = pillSheetGroup.pillSheets[index];

      final DateTime beginDate;
      if (index == 0) {
        beginDate = firstPilSheetBeginDate;
      } else {
        final passedTotalCount = summarizedPillSheetTypeTotalCountToPageIndex(
            pillSheetTypes: pillSheetTypes, pageIndex: index);
        beginDate =
            firstPilSheetBeginDate.add(Duration(days: passedTotalCount));
      }

      final DateTime? lastTakenDate;
      if (state.selectedPillSheetPageIndex == index) {
        lastTakenDate = beginDate
            .add(Duration(days: state.selectedPillMarkNumberIntoPillSheet - 2));
      } else if (state.selectedPillSheetPageIndex > index) {
        lastTakenDate = beginDate
            .add(Duration(days: pillSheet.pillSheetType.totalCount - 1));
      } else {
        // state.selectedPillMarkNumberIntoPillSheet < index
        lastTakenDate = null;
      }

      final updatedPillSheet = pillSheet.copyWith(
          beginingDate: beginDate,
          lastTakenDate: lastTakenDate,
          restDurations: []);
      updatedPillSheets.add(updatedPillSheet);
    });

    _pillSheetService.update(batch, updatedPillSheets);

    final history = PillSheetModifiedHistoryServiceActionFactory
        .createChangedPillNumberAction(
      pillSheetGroupID: pillSheetGroup.id,
      before: activedPillSheet,
      after: updatedPillSheets[state.selectedPillSheetPageIndex],
    );
    _pillSheetModifiedHistoryService.add(batch, history);

    _pillSheetGroupService.update(
        batch, pillSheetGroup.copyWith(pillSheets: updatedPillSheets));

    await batch.commit();
  }
}

int _pillNumberIntoPillSheet({
  required PillSheet activedPillSheet,
  required PillSheetGroup pillSheetGroup,
}) {
  final pillSheetTypes =
      pillSheetGroup.pillSheets.map((e) => e.pillSheetType).toList();
  final _passedTotalCount = summarizedPillSheetTypeTotalCountToPageIndex(
      pillSheetTypes: pillSheetTypes, pageIndex: activedPillSheet.groupIndex);
  if (_passedTotalCount >= activedPillSheet.todayPillNumber) {
    return activedPillSheet.todayPillNumber;
  }
  return activedPillSheet.todayPillNumber - _passedTotalCount;
}
