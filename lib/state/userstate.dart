// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swrv/utils/alerts.dart';

import '../services/apirequest.dart';

final userState = ChangeNotifierProvider.autoDispose<UserState>(
  (ref) => UserState(),
);

class UserState extends ChangeNotifier {
  CusApiReq apiReq = CusApiReq();

//user login related setup
  Future<bool> updateUser(BuildContext context) async {
    bool response = await setNewUserData(context, await getUserId());
    return response;
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

  Future<void> setUserData(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user);
  }

  Future<void> clearUserData() async {
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
      await setUserData(jsonEncode(userdata[0]["data"]));
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

//get some user data
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

    if (jsonDecode(userdata!)[0]["role"]["code"].toString() == "50") {
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

  Future<String> getUserDob() async {
    String getDob = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    getDob = jsonDecode(userdata!)[0]["dob"].toString();
    notifyListeners();
    return getDob;
  }

  Future<String> getUserGender() async {
    String getGender = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    getGender = jsonDecode(userdata!)[0]["gender"]["name"].toString();
    notifyListeners();
    return getGender;
  }

  Future<String> getUserBio() async {
    String getBio = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    getBio = jsonDecode(userdata!)[0]["bio"].toString();
    notifyListeners();
    return getBio;
  }

  // "personalHistory":"","careerHistory":"","externalLinks
  Future<String> getUserPersonalHis() async {
    String personalHistory = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    personalHistory = jsonDecode(userdata!)[0]["personalHistory"].toString();
    notifyListeners();
    return personalHistory;
  }

  Future<String> getUserCareerHis() async {
    String careerHistory = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    careerHistory = jsonDecode(userdata!)[0]["careerHistory"].toString();
    notifyListeners();
    return careerHistory;
  }

  Future<String> getUserExternalLinks() async {
    String externalLinks = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    externalLinks = jsonDecode(userdata!)[0]["externalLinks"].toString();
    notifyListeners();
    return externalLinks;
  }

  Future<String> getUserInfo() async {
    String getInfo = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    getInfo = jsonDecode(userdata!)[0]["info"].toString();
    notifyListeners();
    return getInfo;
  }

  Future<String> getUserRating() async {
    String getRating = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    getRating = jsonDecode(userdata!)[0]["rating"].toString();
    notifyListeners();
    return getRating;
  }

  Future<String> getUserBrandId() async {
    String userbrandId = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    userbrandId = jsonDecode(userdata!)[0]["brandId"].toString();
    notifyListeners();
    return userbrandId;
  }

  Future<String> getNickname() async {
    String userId = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    userId = jsonDecode(userdata!)[0]["knownAs"].toString();
    notifyListeners();
    return userId;
  }

  Future<String> getBrandId() async {
    String userId = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    userId = jsonDecode(userdata!)[0]["brandId"].toString();
    notifyListeners();
    return userId;
  }

  Future<bool> isBrandAdded() async {
    bool res = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    final brand = jsonDecode(userdata!)[0]["brand"];
    if (brand.isNotEmpty) {
      res = true;
    }
    return res;
  }

  Future<String> getBrandName() async {
    String brandName = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    brandName = jsonDecode(userdata!)[0]["brand"]["name"].toString();
    notifyListeners();
    return brandName;
  }

  Future<String> getBrandCode() async {
    String brandCode = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    brandCode = jsonDecode(userdata!)[0]["brand"]["code"].toString();
    notifyListeners();
    return brandCode;
  }

  Future<String> getBrandInfo() async {
    String brandInfo = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    brandInfo = jsonDecode(userdata!)[0]["brand"]["info"].toString();
    notifyListeners();
    return brandInfo;
  }

  Future<String> getWebsite() async {
    String website = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    website = jsonDecode(userdata!)[0]["website"].toString();
    notifyListeners();
    return website;
  }

  Future<bool> isProfileCompleted() async {
    bool res = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    final userinfo = jsonDecode(userdata!)[0]["profileCompleteness"].toString();
    if (userinfo == "1") {
      res = true;
    }
    notifyListeners();
    return res;
  }
}
