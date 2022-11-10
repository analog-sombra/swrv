// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../services/apirequest.dart';
import '../../utils/alerts.dart';

final findCampState =
    ChangeNotifierProvider<FindCampState>((ref) => FindCampState());

class FindCampState extends ChangeNotifier {
  CusApiReq apiReq = CusApiReq();
  bool isActiveChamp = false;
  bool isSearch = false;
  List searchData = [];

  void setIsSearch(bool val) {
    isSearch = val;
    notifyListeners();
  }

  void setSearchData(List data) {
    searchData = data;
    notifyListeners();
  }

  bool isBrand = false;

  void setIsActive(bool val) {
    isActiveChamp = val;
    notifyListeners();
  }

  void setIsBrand(bool val) {
    isBrand = val;
    notifyListeners();
  }

  List platforms = [];
  List selectedPlatfomrs = [];
  List selectedPlatfomrsList = [];

  void setPlatforms(List data) {
    platforms = data;
    for (int i = 0; i < data.length; i++) {
      selectedPlatfomrs.add(false);
    }
    notifyListeners();
  }

  void togglePlatfroms(int val) {
    selectedPlatfomrs[val] = !selectedPlatfomrs[val];
    if (selectedPlatfomrsList.contains(platforms[val]["id"])) {
      selectedPlatfomrsList.remove(platforms[val]["id"]);
    } else {
      selectedPlatfomrsList.add(platforms[val]["id"]);
    }
    notifyListeners();
  }

  String? cmpValue;
  String? cmpId;
  List cmpList = [];

  void setCmp(List data) {
    cmpList = data;
    notifyListeners();
  }

  void setCmpId(int id) {
    cmpId = cmpList[id]["id"];
    notifyListeners();
  }

  void setCmpValue(String val) {
    cmpValue = val;
    notifyListeners();
  }

  String? cityValue;
  String? cityId;
  List cityList = [];

  void setCity(List data) {
    cityList = data;
    notifyListeners();
  }

  void setCityId(int id) {
    cityId = cityList[id]["id"];
    notifyListeners();
  }

  void setCityValue(String val) {
    cityValue = val;
    notifyListeners();
  }

  Future<List> startSeatch(BuildContext context) async {
    if (selectedPlatfomrsList.isEmpty) {
      erroralert(context, "Error", "Please Select platform");
    } else if (cmpId == null) {
      erroralert(context, "Error", "Please Select category");
    } else if (cityId == null) {
      erroralert(context, "Error", "Please Select city");
    } else {
      final req = {
        "city": cityId,
        "platform": selectedPlatformList(),
        "category": cmpId,
      };
      log(req.toString());

      List data =
          await apiReq.postApi(jsonEncode(req), path: "/api/campaign-search");

      log(data.toString());

      if (data[0] == false) {
        erroralert(
          context,
          "Error1",
          data[1].toString(),
        );
      } else if (data[0]["status"] == false) {
        erroralert(
          context,
          "Error2",
          data[0]["message"],
        );
      } else {
        notifyListeners();
        return [jsonEncode(data[0]["data"])];
      }
    }

//     {
//   "id":"",
//   "platform": "1,2",
//   "category":"",
//   "city": "",
//   "brand":"",
//   "type":"",
//   "user":"",
//   "currency":""
// }

    notifyListeners();
    return [false];
  }

  String selectedPlatformList() {
    String res = "";
    for (int i = 0; i < selectedPlatfomrsList.length; i++) {
      if (i == (selectedPlatfomrsList.length - 1)) {
        res += "${selectedPlatfomrsList[i]}";
      } else {
        res += "${selectedPlatfomrsList[i]},";
      }
    }

    return res;
  }

  void clear() {
    isActiveChamp = false;
    for (int i = 0; i < selectedPlatfomrs.length; i++) {
      selectedPlatfomrs[i] = false;
    }
    
    // selectedPlatfomrs = [];
    // selectedPlatfomrsList = [];

    cmpValue = null;
    cmpId = null;

    cityValue = null;
    cityId = null;
    isSearch = false;
    searchData = [];

    notifyListeners();
  }
}
