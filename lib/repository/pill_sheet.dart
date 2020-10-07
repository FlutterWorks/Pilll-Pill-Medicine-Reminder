import 'package:Pilll/model/pill_sheet.dart';
import 'package:Pilll/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PillSheetRepositoryInterface {
  Future<PillSheetModel> current(String userID);
  Future<void> create(String userID, PillSheetModel model);
}

class PillSheetRepository extends PillSheetRepositoryInterface {
  String _path(String userID) {
    return "${User.path}/$userID/pill_sheets";
  }

  @override
  Future<PillSheetModel> current(String userID) {
    return FirebaseFirestore.instance
        .collection(_path(userID))
        .orderBy("createdAt")
        .limitToLast(1)
        .get()
        .then((event) {
      var document = event.docs.last;
      if (!document.exists) return null;

      var data = document.data();
      data["id"] = document.id;
      var pillSheetModel = PillSheetModel.fromJson(data);

      if (pillSheetModel.deletedAt != null) return null;
      return pillSheetModel;
    });
  }

  @override
  Future<void> create(String userID, PillSheetModel model) {
    if (model.createdAt != null) throw PillSheetAlreadyExists();
    if (model.deletedAt != null) throw PillSheetAlreadyDeleted();
    model.createdAt = DateTime.now();

    return FirebaseFirestore.instance
        .collection(_path(userID))
        .add(model.toJson().remove("id"));
  }

  // Future<void> deleteCurrentPillSheet() {
  //   return FirebaseFirestore.instance.collection(User.path).doc(documentID).set(
  //     {
  //       UserFirestoreFieldKeys.currentPillSheet: null,
  //     },
  //     SetOptions(merge: true),
  //   ).then((_) => this.currentPillSheet = null);
  // }
}

class PillSheetAlreadyExists implements Exception {
  toString() {
    return "pill sheet already exists";
  }
}

class PillSheetAlreadyDeleted implements Exception {
  toString() {
    return "pill sheet already deleted";
  }
}

final PillSheetRepositoryInterface pillSheetRepository = PillSheetRepository();
