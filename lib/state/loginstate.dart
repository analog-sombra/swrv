// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:swrv/services/apirequest.dart';
import 'package:swrv/state/userstate.dart';
import 'package:swrv/utils/alerts.dart';

//apple login start here
/// Generates a cryptographically secure random nonce, to be included in a
/// credential request.
String generateNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

/// Returns the sha256 hash of [input] in hex notation.
String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

Future<UserCredential> signInWithApple() async {
  // To prevent replay attacks with the credential returned from Apple, we
  // include a nonce in the credential request. When signing in with
  // Firebase, the nonce in the id token returned by Apple, is expected to
  // match the sha256 hash of `rawNonce`.
  final rawNonce = generateNonce();
  final nonce = sha256ofString(rawNonce);

  // Request credential for the currently signed in Apple account.
  final appleCredential = await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
    nonce: nonce,
  );

  // Create an `OAuthCredential` from the credential returned by Apple.
  final oauthCredential = OAuthProvider("apple.com").credential(
    idToken: appleCredential.identityToken,
    rawNonce: rawNonce,
  );

  // Sign in the user with Firebase. If the nonce we generated earlier does
  // not match the nonce in `appleCredential.identityToken`, sign in will fail.
  return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
}

Future<UserCredential?> signInWithGoogle() async {
  final googleSignIn = GoogleSignIn();
  await googleSignIn.disconnect().catchError((e, stack) {
    // dev.log(e);
  });

  final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

  if (googleUser == null) return null;

  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future<UserCredential> signInWithFacebook() async {
  final LoginResult loginResult = await FacebookAuth.instance.login();

  final AccessToken accessToken = loginResult.accessToken!;
  final OAuthCredential credential =
      FacebookAuthProvider.credential(accessToken.token);

  return await FirebaseAuth.instance.signInWithCredential(credential);
}

//login state start here
final loginStatus =
    ChangeNotifierProvider.autoDispose<LoginState>((ref) => LoginState());

class LoginState extends ChangeNotifier {
  bool isChecked = false;
  bool isPassword = false;

  CusApiReq apiReq = CusApiReq();

  UserState userState = UserState();

  void toggleCheck() {
    isChecked = !isChecked;
    notifyListeners();
  }

  void togglePassword() {
    isPassword = !isPassword;
    notifyListeners();
  }

  Future<bool> login(
      BuildContext context, String email, String password) async {
    if (email == "") {
      erroralert(
        context,
        "Empty Field",
        "Please fill the email",
      );
    } else if (password == "") {
      erroralert(context, "Empty Field", "Please fill the password");
    } else {
      final req = {"email": email, "password": password};

      List data = await apiReq.postApi(jsonEncode(req), path: "/api/login");

      if (data[0] == false) {
        erroralert(
          context,
          "Error",
          data[1].toString(),
        );
      } else if (data[0]["status"] == false) {
        erroralert(
          context,
          "Error",
          data[0]["message"],
        );
      } else {
        final isuserset = await userState.setNewUserData(
            context, data[0]["data"]["id"].toString());

        if (isuserset) {
          if (isChecked) {
            await setLogPref();
          }
          notifyListeners();
          return true;
        } else {
          erroralert(context, "Error", "unable to set new user");
        }
      }
    }
    notifyListeners();
    return false;
  }

  Future<void> setLogPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("login", true);
  }

  Future<bool> isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLogin = prefs.getBool("login");
    if (isLogin != null) {
      if (isLogin) {
        notifyListeners();
        return true;
      }
    }
    notifyListeners();
    return false;
  }
}
