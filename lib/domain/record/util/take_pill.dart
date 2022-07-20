import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pilll/database/batch.dart';
import 'package:pilll/entity/pill_sheet.codegen.dart';
import 'package:pilll/entity/pill_sheet_group.codegen.dart';
import 'package:pilll/database/pill_sheet.dart';
import 'package:pilll/database/pill_sheet_group.dart';
import 'package:pilll/database/pill_sheet_modified_history.dart';
import 'package:pilll/error_log.dart';
import 'package:pilll/util/datetime/date_compare.dart';

class TakePill {
  final BatchFactory batchFactory;
  final PillSheetDatastore pillSheetDatastore;
  final PillSheetModifiedHistoryDatastore pillSheetModifiedHistoryDatastore;
  final PillSheetGroupDatastore pillSheetGroupDatastore;

  TakePill({
    required this.batchFactory,
    required this.pillSheetDatastore,
    required this.pillSheetModifiedHistoryDatastore,
    required this.pillSheetGroupDatastore,
  });

  Future<PillSheetGroup?> call({
    required DateTime takenDate,
    required PillSheetGroup pillSheetGroup,
    required PillSheet activedPillSheet,
    required bool isQuickRecord,
  }) async {
    if (activedPillSheet.todayPillIsAlreadyTaken) {
      return null;
    }

    final updatedPillSheets = pillSheetGroup.pillSheets.map((pillSheet) {
      if (pillSheet.groupIndex > activedPillSheet.groupIndex) {
        return pillSheet;
      }
      if (pillSheet.isEnded) {
        return pillSheet;
      }

      // takenDateよりも予測するピルシートの最終服用日よりも小さい場合は、そのピルシートの最終日で予測する最終服用日を記録する
      if (takenDate.isAfter(pillSheet.estimatedEndTakenDate)) {
        return pillSheet.copyWith(lastTakenDate: pillSheet.estimatedEndTakenDate);
      }

      // takenDateがピルシートの開始日に満たない場合は、記録の対象になっていないので早期リターン
      // 一つ前のピルシートのピルをタップした時など
      if (takenDate.isBefore(pillSheet.beginingDate)) {
        return pillSheet;
      }

      return pillSheet.copyWith(lastTakenDate: takenDate);
    }).toList();
    debugPrint("$updatedPillSheets");

    final updatedPillSheetGroup = pillSheetGroup.copyWith(pillSheets: updatedPillSheets);
    final updatedIndexses = pillSheetGroup.pillSheets.asMap().keys.where((index) {
      final updatedPillSheet = updatedPillSheetGroup.pillSheets[index];
      if (pillSheetGroup.pillSheets[index] == updatedPillSheet) {
        return false;
      }

      return true;
    }).toList();

    debugPrint("updatedIndexses: $updatedIndexses");
    if (updatedIndexses.isEmpty) {
      // NOTE: avoid error for unit test
      if (Firebase.apps.isNotEmpty) {
        errorLogger.recordError(const FormatException("unexpected updatedIndexes is empty"), StackTrace.current);
      }
      return null;
    }

    final batch = batchFactory.batch();
    pillSheetDatastore.update(
      batch,
      updatedPillSheets,
    );
    pillSheetGroupDatastore.updateWithBatch(batch, updatedPillSheetGroup);

    final before = pillSheetGroup.pillSheets[updatedIndexses.first];
    final after = updatedPillSheetGroup.pillSheets[updatedIndexses.last];
    debugPrint("before: $before, after: $after");
    final history = PillSheetModifiedHistoryServiceActionFactory.createTakenPillAction(
      pillSheetGroupID: pillSheetGroup.id,
      before: before,
      after: after,
      isQuickRecord: isQuickRecord,
    );
    pillSheetModifiedHistoryDatastore.add(batch, history);

    await batch.commit();

    return updatedPillSheetGroup;
  }
}
