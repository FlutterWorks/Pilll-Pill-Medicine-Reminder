import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pilll/database/database.dart';
import 'package:pilll/entity/pill_sheet_modified_history.codegen.dart';

final pillSheetModifiedHistoriesWithLimitProvider = StreamProvider.family((ref, int limit) {
  return ref
      .watch(databaseProvider)
      .pillSheetModifiedHistoriesReference()
      .orderBy(PillSheetModifiedHistoryFirestoreKeys.estimatedEventCausingDate, descending: true)
      .limit(limit)
      .snapshots()
      .map((reference) => reference.docs)
      .map((docs) => docs.map((doc) => doc.data()).toList());
});

final batchSetPillSheetModifiedHistoryProvider = Provider((ref) => BatchSetPillSheetModifiedHistory(ref.watch(databaseProvider)));

class BatchSetPillSheetModifiedHistory {
  final DatabaseConnection databaseConnection;
  BatchSetPillSheetModifiedHistory(this.databaseConnection);

  void call(WriteBatch batch, PillSheetModifiedHistory history) async {
    batch.set(databaseConnection.pillSheetModifiedHistoryReference(pillSheetModifiedHistoryID: null), history, SetOptions(merge: true));
  }
}
