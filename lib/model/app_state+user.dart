import 'package:Pilll/model/app_state.dart';
import 'package:Pilll/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

extension UserInterface on AppState {
  static Future<User> fetchOrCreateUser() {
    return UserInterface._fetch().catchError((error) {
      if (error is UserNotFound) {
        return UserInterface._create().then((_) => UserInterface._fetch());
      }
      throw FormatException(
          "cause exception when failed fetch and create user for $error");
    });
  }

  static Future<void> _create() {
    assert(AppState.shared._user == null,
        "user already exists on process. maybe you will call fetch before create");
    if (AppState.shared._user != null) throw UserAlreadyExists();
    return FirebaseFirestore.instance
        .collection(User.path)
        .doc(auth.FirebaseAuth.instance.currentUser.uid)
        .set(
      {
        UserFirestoreFieldKeys.anonymouseUserID:
            auth.FirebaseAuth.instance.currentUser.uid,
      },
    );
  }

  static Future<User> _fetch() {
    if (AppState.shared._user != null) {
      return Future.value(AppState.shared._user);
    }

    return FirebaseFirestore.instance
        .collection(User.path)
        .doc(auth.FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((document) {
      if (!document.exists) {
        throw UserNotFound();
      }
      var user = User.map(document.data());
      assert(AppState.shared._user == null,
          "you should early return cached user. e.g) this function top level");
      AppState.shared._user = user;
      return user;
    });
  }
}
