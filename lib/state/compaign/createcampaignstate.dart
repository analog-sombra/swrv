// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/apirequest.dart';
import '../../utils/alerts.dart';

//login state start here
final createCampState =
    ChangeNotifierProvider<CreateCampState>((ref) => CreateCampState());

class CreateCampState extends ChangeNotifier {
  double rating = 3;

  void setRating(double val) {
    rating = val;
    notifyListeners();
  }

  List campData = [];

  void setCampData(List data) {
    campData = data;
    notifyListeners();
  }

  CusApiReq apiReq = CusApiReq();

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

  String? currencyValue;
  String? currencyId;
  List currencyList = [];

  void setCurrecny(List data) {
    currencyList = data;
    notifyListeners();
  }

  void setCurrencyId(int id) {
    currencyId = currencyList[id]["id"];
    notifyListeners();
  }

  void setCurrencyValue(String val) {
    currencyValue = val;
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

  String? categoryValue;
  String? categoryId;
  List categoryList = [];

  void setCategory(List data) {
    categoryList = data;
    notifyListeners();
  }

  void setCategoryId(int id) {
    categoryId = categoryList[id]["id"];
    setCatValue(categoryList[id]["categoryName"]);

    notifyListeners();
  }

  void setCatValue(String val) {
    categoryValue = val;
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

  void togglePlatfroms(int val) {
    selectedPlatfomrs[val] = !selectedPlatfomrs[val];
    if (selectedPlatfomrsList.contains(platforms[val]["id"])) {
      selectedPlatfomrsList.remove(platforms[val]["id"]);
    } else {
      selectedPlatfomrsList.add(platforms[val]["id"]);
    }
    notifyListeners();
  }

  Future<bool> createCamp(BuildContext context, List fields) async {
    bool testcase = false;

    for (int i = 0; i < fields.length; i++) {
      if (fields[i] == "") {
        testcase = true;
      }
    }

    if (testcase) {
      erroralert(
        context,
        "Empty Field",
        "Please fill all the fields",
      );
    } else if (int.parse(fields[4]) >= int.parse(fields[5])) {
      erroralert(
        context,
        "Error",
        "Min reach should be lower then max reach",
      );
    }
     else if (cmpId == null) {
      erroralert(
        context,
        "Empty Field",
        "Please select the category",
      );
    }  else if (categoryId == null) {
      erroralert(
        context,
        "Empty Field",
        "Please select the category",
      );
    } else if (currencyValue == null) {
      erroralert(
        context,
        "Empty Field",
        "Please select the currency",
      );
    } else if (cityValue == null) {
      erroralert(
        context,
        "Empty Field",
        "Please select the city",
      );
    } else if (selectedPlatfomrsList.isEmpty) {
      erroralert(
        context,
        "Empty Field",
        "Please Select some platforms",
      );
    } else {
      final userdata = await getUser();

      final req = {
        "brandUserId": jsonDecode(userdata)[0]["id"].toString(),
        "brandId": jsonDecode(userdata)[0]["brand"]["id"].toString(),
        "cityId": cityId,
        "campaignTypeId": categoryId,
        "campaignName": fields[0],
        "campaignInfo": fields[1],
        "startAt": DateTime(
                int.parse(fields[2].toString().split("-")[2]),
                int.parse(fields[2].toString().split("-")[1]),
                int.parse(fields[2].toString().split("-")[0]))
            .toString(),
        "endAt": DateTime(
                int.parse(fields[3].toString().split("-")[2]),
                int.parse(fields[3].toString().split("-")[1]),
                int.parse(fields[3].toString().split("-")[0]))
            .toString(),
        "minReach": fields[4],
        "maxReach": fields[5],
        "costPerPost": fields[6],
        "totalBudget": fields[7],
        "minEligibleRating": rating.toString(),
        "currencyId": currencyId,
        "categories": cmpId.toString(),
        "platforms": selectedPlatformList()
      };

      List data =
          await apiReq.postApi(jsonEncode(req), path: "/api/createchampaign");

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
        clearData();
        notifyListeners();
        return true;
      }
    }
    notifyListeners();
    return false;
  }

  Future<String> getBrandId() async {
    String userId = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    userId = jsonDecode(userdata!)[0]["brandId"].toString();
    notifyListeners();
    return userId;
  }

  String selectedPlatformList() {
    String res = "";
    for (int i = 0; i < selectedPlatfomrsList.length; i++) {
      res += "${selectedPlatfomrsList[i]},";
    }
    return res;
  }

  void clearData() {
    platforms = [];
    selectedPlatfomrs = [];
    selectedPlatfomrsList = [];

    currencyValue = null;
    currencyId = null;
    currencyList = [];

    categoryId = null;
    categoryList = [];

    cityValue = null;
    cityId = null;
    cityList = [];
  }

  Future<dynamic> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get("user");
  }
}
