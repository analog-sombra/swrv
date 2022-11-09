// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services/apirequest.dart';
import '../utils/alerts.dart';

final userInputState =
    ChangeNotifierProvider<UserInputState>((ref) => UserInputState());

class UserInputState extends ChangeNotifier {
  CusApiReq apiReq = CusApiReq();
  int curInput = 0;

  List platforms = [];
  List imgUrls = [];
  List<bool> isCompleted = [];
  int? selectedPlatform;
  List<TextEditingController> cont = [];

  void setCurInput(int val) {
    curInput = val;
    notifyListeners();
  }

  void setPlatforms(List data) {
    platforms = data;
    notifyListeners();
  }

  void addImgUrl(String url) {
    imgUrls.add(url);
    notifyListeners();
  }

  void addIsCompleted(bool value) {
    isCompleted.add(value);
    notifyListeners();
  }

  void setIsComplted(int index, bool value) {
    isCompleted[index] = value;
    notifyListeners();
  }

  void setSelectPlatform(int value) {
    selectedPlatform = value;
    notifyListeners();
  }

  void setNullPlatform() {
    selectedPlatform = null;
    notifyListeners();
  }

  void addControler() {
    cont.add(TextEditingController());
    notifyListeners();
  }

  //user input 2
  List currencyList = [];
  List selectedCurrency = [];
  List currencyVal = [];

  void setCurrencyList(List data) {
    currencyList = data;
    for (int i = 0; i < data.length; i++) {
      selectedCurrency.add(false);
    }
    notifyListeners();
  }

  void setCurrency(int index, bool value) {
    for (int i = 0; i < selectedCurrency.length; i++) {
      selectedCurrency[i] = false;
    }

    selectedCurrency[index] = value;
    if (value) {
      currencyVal = [currencyList[index]];
    } else {
      currencyVal = [];
    }
    log(currencyList.toString());

    notifyListeners();
  }

  List categoryList = [];
  List selectedCategory = [];
  List categoryVal = [];

  void setCategoryList(List data) {
    categoryList = data;
    for (int i = 0; i < data.length; i++) {
      selectedCategory.add(false);
    }
    notifyListeners();
  }

  void setCategory(int index, bool value) {
    selectedCategory[index] = value;
    if (value) {
      categoryVal.add(categoryList[index]);
    } else {
      categoryVal.remove(categoryList[index]);
    }

    notifyListeners();
  }

  String getCatValue() {
    String res = "";
    for (int i = 0; i < categoryVal.length; i++) {
      res += "${categoryVal[i]["categoryName"]}, ";
    }
    return res;
  }

  List languageList = [];
  List selectedLanguage = [];
  List languageVal = [];

  void setLanguageList(List data) {
    languageList = data;
    for (int i = 0; i < data.length; i++) {
      selectedLanguage.add(false);
    }
    notifyListeners();
  }

  void setLanguage(int index, bool value) {
    selectedLanguage[index] = value;
    if (value) {
      languageVal.add(languageList[index]);
    } else {
      languageVal.remove(languageList[index]);
    }

    notifyListeners();
  }

  String getlangValue() {
    String res = "";
    for (int i = 0; i < languageVal.length; i++) {
      res += "${languageVal[i]["languageName"]}, ";
    }
    return res;
  }

  //user input 4

  List genderList = ["MALE", "FEMALE", "TRANSGENDER"];
  List selectedGender = [false, false, false];
  List genderVal = [];

  void setGender(int index, bool value) {
    for (int i = 0; i < genderList.length; i++) {
      selectedGender[i] = false;
    }
    selectedGender[index] = value;
    if (value) {
      genderVal = [genderList[index]];
    } else {
      genderVal = [];
    }
    notifyListeners();
  }

  List countryList = [];
  List selectedCountry = [];
  List countryVal = [];

  void setCountryList(List data) {
    countryList = data;
    for (int i = 0; i < data.length; i++) {
      selectedCountry.add(false);
    }
    notifyListeners();
  }

  void setCountry(int index, bool value) {
    for (int i = 0; i < selectedCountry.length; i++) {
      selectedCountry[i] = false;
    }
    selectedCountry[index] = value;
    if (value) {
      countryVal = [countryList[index]];
    } else {
      countryVal = [];
    }
    notifyListeners();
  }

  List cityList = [];
  List selectedCity = [];
  List cityVal = [];

  void setCityList(List data) {
    cityList = data;
    for (int i = 0; i < data.length; i++) {
      selectedCity.add(false);
    }
    notifyListeners();
  }

  void setCity(int index, bool value) {
    for (int i = 0; i < selectedCity.length; i++) {
      selectedCity[i] = false;
    }
    selectedCity[index] = value;
    if (value) {
      cityVal = [cityList[index]];
    } else {
      cityVal = [];
    }
    notifyListeners();
  }

  Future<bool> userUpdate1(
      BuildContext context, List fields, String userid) async {
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
    } else {
      final req = {
        "id": userid,
        "userName": fields[1],
        "userKnownAs": fields[2],
        "userDOB": DateTime(
                int.parse(fields[3].toString().split("-")[2]),
                int.parse(fields[3].toString().split("-")[1]),
                int.parse(fields[3].toString().split("-")[0]))
            .toString(),
        "userBioInfo": fields[4]
      };

      List data =
          await apiReq.postApi(jsonEncode(req), path: "/api/updateuser");

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
        return true;
      }
    }

    notifyListeners();
    return false;
  }

  Future<bool> uloadAvatar(
      BuildContext context, String imagepath, String userid) async {
    List data =
        await apiReq.uploadImage(imagepath, userid, path: "/api/uploadavatar");

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
      return true;
    }

    notifyListeners();
    return false;
  }

  Future<bool> userUpdate2(BuildContext context, String userid) async {
    if (currencyVal.isEmpty) {
      erroralert(context, "Empty Field", "Please select a currecny");
    } else if (categoryVal.isEmpty) {
      erroralert(context, "Empty Field", "Please some category");
    } else if (languageVal.isEmpty) {
      erroralert(context, "Empty Field", "Please select a language");
    } else {
      final req = {
        "id": userid.toString(),
        "currencyId": currencyVal[0]["id"].toString(),
        "languages": getLanguages(),
        "categories": getCategorys()
      };

      List data =
          await apiReq.postApi(jsonEncode(req), path: "/api/updateuser");

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
        return true;
      }
    }

    notifyListeners();
    return false;
  }

  String getCategorys() {
    String res = "";
    for (int i = 0; i < categoryVal.length; i++) {
      res += "${categoryVal[i]["id"]},";
    }
    return res;
  }

  String getLanguages() {
    String res = "";
    for (int i = 0; i < languageVal.length; i++) {
      res += "${languageVal[i]["id"]},";
    }
 
    return res;
  }

  Future<bool> addHandal(BuildContext context, String userid, String platformid,
      String handal) async {
    final req = {
      "userId": userid,
      "platformId": platformid,
      "handleName": handal
    };

    List data = await apiReq.postApi(jsonEncode(req), path: "/api/add-handle");

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
      susalert(
        context,
        "Successfully",
        "Successfully added new Handal",
      );
      notifyListeners();
      return true;
    }

    notifyListeners();
    return false;
  }

  Future<bool> userUpdate4(
      BuildContext context, String userid, List fields) async {
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
    } else if (fields[0].toString().length != 10) {
      erroralert(
        context,
        "Empty Field",
        "Number should be 10 degit",
      );
    } else if (countryVal.isEmpty) {
      erroralert(
        context,
        "Empty Field",
        "Please select a country",
      );
    } else if (cityVal.isEmpty) {
      erroralert(
        context,
        "Empty Field",
        "Please select a city",
      );
    } else {
      final req = {
        "id": userid.toString(),
        "cityId": cityVal[0]["id"].toString(),
        "userContact": fields[0].toString(),
        "userGender": genderVal[0]
      };

      List data =
          await apiReq.postApi(jsonEncode(req), path: "/api/updateuser");

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
        return true;
      }
    }

    notifyListeners();
    return false;
  }

  void clear() {
    currencyList = [];
    selectedCurrency = [];
    currencyVal = [];

    categoryList = [];
    selectedCategory = [];
    categoryVal = [];

    languageList = [];
    selectedLanguage = [];
    languageVal = [];

    selectedGender = [false, false, false];
    genderVal = [];

    countryList = [];
    selectedCountry = [];
    countryVal = [];

    cityList = [];
    selectedCity = [];
    cityVal = [];

    platforms = [];
    imgUrls = [];
    isCompleted = [];
    selectedPlatform = null;
    cont = [];
  }
}
