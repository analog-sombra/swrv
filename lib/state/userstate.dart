// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swrv/utils/alerts.dart';

import '../services/apirequest.dart';

final userState = ChangeNotifierProvider<UserState>((ref) => UserState());

class UserState extends ChangeNotifier {
  CusApiReq apiReq = CusApiReq();

  void setProfileComp(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isProfileCompleted", val);
  }

  Future<bool> isProfileComp() async {
    bool result = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isProfileCompleted = prefs.getBool("isProfileCompleted");
    if (isProfileCompleted == true) {
      notifyListeners();
      return true;
    }
    notifyListeners();
    return result;
  }

  void setUserData(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user);
  }

  Future<String> getUserData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? response = prefs.getString("user");
    if (response == null) {
      erroralert(context, "Empty User", "There is no user data");
    }
    notifyListeners();
    return response!;
  }

  void clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    notifyListeners();
  }

  Future<bool> setNewUserData(BuildContext context, String userid) async {
    final req = {"id": userid};

    final userdata =
        await apiReq.postApi(jsonEncode(req), path: "/api/getuser");

    if (userdata[0]["status"] == false) {
      erroralert(context, "Empty User", "There is no user data");
    } else {
      setUserData(jsonEncode(userdata[0]["data"]));
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  Future<String> getUserName() async {
    String username = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    username = jsonDecode(userdata!)[0]["userName"].toString();
    notifyListeners();
    return username;
  }

  Future<bool> isBrand() async {
    bool isBrand = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    if (jsonDecode(userdata!)[0]["role.code"].toString() == "50") {
      isBrand = true;
    }
    notifyListeners();
    return isBrand;
  }

  Future<String> getUserAvatar() async {
    String userAvatar = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    userAvatar = jsonDecode(userdata!)[0]["pic"].toString();
    notifyListeners();
    return userAvatar;
  }

  Future<String> getUserEmail() async {
    String userEmail = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    userEmail = jsonDecode(userdata!)[0]["email"].toString();
    notifyListeners();
    return userEmail;
  }

  Future<String> getUserId() async {
    String userId = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    userId = jsonDecode(userdata!)[0]["id"].toString();
    notifyListeners();
    return userId;
  }

  Future<String> getNickname() async {
    String userId = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    userId = jsonDecode(userdata!)[0]["knownAs"].toString();
    notifyListeners();
    return userId;
  }
}
