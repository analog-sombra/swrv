// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swrv/state/userstate.dart';

import '../services/apirequest.dart';
import '../utils/alerts.dart';

final registerState = ChangeNotifierProvider.autoDispose<RegisterStatus>(
    (ref) => RegisterStatus());

class RegisterStatus extends ChangeNotifier {
  bool isBrand = false;
  bool isShowPass1 = false;
  bool isShowPass2 = false;

  bool isCheck1 = false;
  bool isCheck2 = false;

  CusApiReq apiReq = CusApiReq();
  UserState userState = UserState();

  void setBrand(bool val) {
    isBrand = val;
    notifyListeners();
  }

  void togglePass1() {
    isShowPass1 = !isShowPass1;
    notifyListeners();
  }

  void togglePass2() {
    isShowPass2 = !isShowPass2;
    notifyListeners();
  }

  void setCheck1(bool val) {
    isCheck1 = val;
    notifyListeners();
  }

  void setCheck2(bool val) {
    isCheck2 = val;
    notifyListeners();
  }

  Future<bool> register(
    BuildContext context,
    TextEditingController email,
    TextEditingController pass,
    TextEditingController coPass,
  ) async {
    if (email.text == "") {
      erroralert(
        context,
        "Empty Field",
        "Please fill the email",
      );
    } else if (!EmailValidator.validate(email.text)) {
      erroralert(
        context,
        'Wrong Email',
        'Please enter your email correctly',
      );
    } else if (pass.text == "") {
      erroralert(
        context,
        'Empty Field',
        'Please fill the password',
      );
    } else if (coPass.text == "") {
      erroralert(
        context,
        'Empty Field',
        'Please fill the Re-Password!',
      );
    }
    // else if (!validatePassword(pass.text)) {
    //   erroralert(
    //     context,
    //     'Password Error',
    //     'Your Password is weak try a different password',
    //   );
    // }
    else if (pass.text != coPass.text) {
      erroralert(
        context,
        'Same Password!',
        'Password and Re-Password should be same.',
      );
    } else if (!isCheck1 || !isCheck2) {
      erroralert(
        context,
        'Cehck The box',
        'In order to proceed check all the box.',
      );
    } else {
      if (isBrand) {
        if (email.text.contains("@gmail") ||
            email.text.contains("@yahoo") ||
            email.text.contains("@hotmail")) {
          erroralert(
            context,
            'Email error',
            'Please enter your brand email',
          );
        } else {
          final req = {
            "email": email.text,
            "password": pass.text,
            "confirm-password": coPass.text,
            "isBrand": "1",
            "isInfluencer": "0"
          };

          final data =
              await apiReq.postApi(jsonEncode(req), path: "/api/register");

          if (data[0] == false) {
            erroralert(
              context,
              'Error',
              'Something went wrong please try again',
            );
          } else if (data[0]["status"] == false) {
            erroralert(
              context,
              'Error',
              data[0]["message"].toString(),
            );
          } else {
            final isuserset = await userState.setNewUserData(
                context, data[0]["data"]["id"].toString());
            if (isuserset) {
              await setLogPref();
              notifyListeners();
              return true;
            } else {
              erroralert(context, "Error", "unable to set new user");
            }
          }
        }
      } else {
        final req = {
          "email": email.text,
          "password": pass.text,
          "confirm-password": coPass.text,
          "isBrand": "0",
          "isInfluencer": "1"
        };

        final data =
            await apiReq.postApi(jsonEncode(req), path: "/api/register");

        if (data[0] == false) {
          erroralert(
            context,
            'Error',
            data[1].toString(),
          );
        } else if (data[0]["status"] == false) {
          erroralert(
            context,
            'Error',
            data[0]["message"].toString(),
          );
        } else {
          await setLogPref();
          userState.setNewUserData(
            context,
            data[0]["data"]["id"].toString(),
          );
          notifyListeners();
          return true;
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
}
