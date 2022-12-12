// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
