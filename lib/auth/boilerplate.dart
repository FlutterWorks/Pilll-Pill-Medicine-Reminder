import 'package:firebase_auth/firebase_auth.dart';
import 'package:pilll/error_log.dart';
import 'package:pilll/service/user.dart';
import 'package:pilll/auth/apple.dart';
import 'package:pilll/auth/google.dart';

Future<SigninWithAppleState> callLinkWithApple(UserService service) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw AssertionError("Required Firebase user");
  }
  try {
    final credential = await linkWithApple(user);
    if (credential == null) {
      return Future.value(SigninWithAppleState.cancel);
    }
    final email = credential.user?.email;
    assert(email != null);

    service.linkApple(email ?? "");

    return Future.value(SigninWithAppleState.determined);
  } on FirebaseAuthException catch (error) {
    errorLogger.recordError(error, StackTrace.current);
    print(
        "FirebaseAuthException $error, code: ${error.code}, stack: ${StackTrace.current.toString()}");
    if (error.code == "provider-already-linked")
      throw FormatException(
          "すでにAppleアカウントが他のPilllのアカウントに紐付いているため連携ができません。詳細: ${error.message}");
    rethrow;
  } catch (error) {
    print("$error, ${StackTrace.current.toString()}");
    rethrow;
  }
}

Future<SigninWithGoogleState> callLinkWithGoogle(UserService service) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw AssertionError("Required Firebase user");
  }
  try {
    final credential = await linkWithGoogle(user);
    if (credential == null) {
      return Future.value(SigninWithGoogleState.cancel);
    }
    final email = credential.user?.email;
    assert(email != null);

    service.linkGoogle(email ?? "");

    return Future.value(SigninWithGoogleState.determined);
  } on FirebaseAuthException catch (error) {
    errorLogger.recordError(error, StackTrace.current);
    print(
        "FirebaseAuthException $error, code: ${error.code}, stack: ${StackTrace.current.toString()}");
    if (error.code == "provider-already-linked")
      throw FormatException(
          "すでにGoogleアカウントが他のPilllのアカウントに紐付いているため連携ができません。詳細: ${error.message}");
    rethrow;
  } catch (error) {
    print("$error, ${StackTrace.current.toString()}");
    rethrow;
  }
}
