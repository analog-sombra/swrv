// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:swrv/database/models/campaignsearch.dart';

import '../../database/database.dart';
import '../../services/apirequest.dart';
import '../../utils/alerts.dart';

final findCampState =
    ChangeNotifierProvider<FindCampState>((ref) => FindCampState());

class FindCampState extends ChangeNotifier {
  CusApiReq apiReq = CusApiReq();
  bool isActiveChamp = false;
  bool isSearch = false;
  bool isAdvance = false;
  List searchData = [];
  List filterlist = [];
  String? filtervalue;

  void setIsSearch(bool val) {
    isSearch = val;
    notifyListeners();
  }

  void setIsAdvance(bool val) {
    isAdvance = val;
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
        "active": isActiveChamp ? "1" : "0"
      };

      List data =
          await apiReq.postApi(jsonEncode(req), path: "/api/campaign-search");

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
        notifyListeners();
        return [jsonEncode(data[0]["data"])];
      }
    }

// request.body = json.encode({
//   "id": "8",
//   "platform": "4,5",
//   "name": "name",
//   "category": "2",
//   "city": "1,2",
//   "brand": "3",
//   "type": "1,2",
//   "user": "",
//   "currency": "2",
//   "active": "1"
// });

    notifyListeners();
    return [false];
  }

  Future<void> saveFilter(BuildContext context, String filter) async {
    if (selectedPlatfomrsList.isEmpty) {
      erroralert(context, "Error", "Please Select platform");
    } else if (cmpId == null) {
      erroralert(context, "Error", "Please Select category");
    } else if (cityId == null) {
      erroralert(context, "Error", "Please Select city");
    } else {
      final newFilter = CampaignSearch()
        ..name = filter
        ..category = cmpId
        ..platforms = selectedPlatformList()
        ..city = cityId
        ..isActive = isActiveChamp ? "1" : "0";

      await isarDB.writeTxn(() async {
        await isarDB.campaignSearchs.put(newFilter);
      });
      susalert(context, "Saved", "successfully Saved the filter");
    }
    notifyListeners();
  }

  void setFilterValue(String val) {
    filtervalue = val;
    notifyListeners();
  }

  Future<void> loadFilter() async {
    filterlist = await isarDB.campaignSearchs.where().findAll();
    notifyListeners();
  }

  Future<List> loadFromFilter(
      BuildContext context, CampaignSearch filter) async {
    final req = {
      "city": filter.city,
      "platform": filter.platforms,
      "category": filter.category,
      "active": filter.isActive
    };

    List data =
        await apiReq.postApi(jsonEncode(req), path: "/api/campaign-search");

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
      notifyListeners();
      return [jsonEncode(data[0]["data"])];
    }
    notifyListeners();
    return [false];
  }

  Future<List> textSearch(BuildContext context, String text) async {
    if (text == "") {
      erroralert(context, "Error", "In order to search fell the field...");
    } else {
      final req = {"name": text};

      List data =
          await apiReq.postApi(jsonEncode(req), path: "/api/campaign-search");

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
        notifyListeners();
        return [jsonEncode(data[0]["data"])];
      }
    }
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

    selectedPlatfomrsList = [];
    cmpValue = null;
    cmpId = null;

    cityValue = null;
    cityId = null;

    isSearch = false;
    searchData = [];

    notifyListeners();
  }
}
