// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swrv/state/userstate.dart';

import '../../services/apirequest.dart';
import '../../utils/alerts.dart';

final userProfileEditState =
    ChangeNotifierProvider.autoDispose<UserProfileEditState>(
  (ref) => UserProfileEditState(),
);

class UserProfileEditState extends ChangeNotifier {
  UserState userState = UserState();
  CusApiReq cusApiReq = CusApiReq();

  //section one
  String? email;
  String? username;
  String? nickname;
  String? dob;
  String? bio;

  File? imageFile;

  Future<void> uploadImage(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      imageFile = imageTemp;
    } on PlatformException catch (e) {
      erroralert(context, "Error", 'Failed to pick image: $e');
    }
    notifyListeners();
  }

  void setEmail(String val) {
    email = val;
    notifyListeners();
  }

  void setUserName(String val) {
    username = val;
    notifyListeners();
  }

  void setNickName(String val) {
    nickname = val;
    notifyListeners();
  }

  void setDob(String val) {
    dob = val;
    notifyListeners();
  }

  void setBio(String val) {
    bio = val;
    notifyListeners();
  }

  List<String> genderList = ["MALE", "FEMALE", "TRANSGENDER"];
  List<bool> selectedGender = [false, false, false];
  List<String> genderVal = [];

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

  Future<void> initSectionOne(BuildContext context) async {
    email = await userState.getUserEmail();
    username = await userState.getUserName();
    nickname = await userState.getNickname();
    String swapdob = await userState.getUserDob();
    dob =
        "${swapdob.split("-")[2]}-${swapdob.split("-")[1]}-${swapdob.split("-")[0]}";
    final userGender = await userState.getUserGender();
    genderVal = [userGender];
    if (userGender == "MALE") {
      selectedGender[0] = true;
      genderVal[0] = "MALE";
    } else if (userGender == "FEMALE") {
      selectedGender[1] = true;
      genderVal[0] = "FEMALE";
    } else {
      selectedGender[2] = true;
      genderVal[0] = "TRANSGENDER";
    }
    bio = await userState.getUserBio();

    notifyListeners();
  }

  Future<void> sectionOneUpdate(BuildContext context) async {
    String? imgFilePath;
    if (imageFile != null) {
      dynamic res = await cusApiReq.uploadFile(imageFile!.path);
      imgFilePath = res["data"]["filePath"];
    }
    final req = {
      "id": await userState.getUserId(),
      "userName": username,
      "userKnownAs": nickname,
      "userDOB": DateTime(
              int.parse(dob.toString().split("-")[2]),
              int.parse(dob.toString().split("-")[1]),
              int.parse(dob.toString().split("-")[0]))
          .toString(),
      "userBioInfo": bio,
      "userGender": (genderVal[0] == "MALE")
          ? "1"
          : (genderVal[0] == "FEMALE")
              ? "2"
              : "3"
    };

    if (imgFilePath != null) {
      req["userPicUrl"] = imgFilePath;
    }

    await cusApiReq.postApi(jsonEncode(req), path: "/api/updateuser");
    await userState.updateUser(context);

    // if (data[0] == false) {
    //   erroralert(
    //     context,
    //     "Error1",
    //     data[1].toString(),
    //   );
    // } else if (data[0]["status"] == false) {
    //   erroralert(
    //     context,
    //     "Error2",
    //     data[0]["message"],
    //   );
    // } else {
    // }

    // notifyListeners();
    // return false;
  }

  //section two
  // String? userInfo;
  String? personalHistory;
  String? careerHistory;
  String? website;

  // void setUserInfo(String value) {
  //   userInfo = value;
  //   notifyListeners();
  // }

  void setPersonalHistory(String value) {
    personalHistory = value;
    notifyListeners();
  }

  void setCareerHistory(String value) {
    careerHistory = value;
    notifyListeners();
  }

  void setWebsite(String value) {
    website = value;
    notifyListeners();
  }

  Future<void> initSectionTwo(BuildContext context) async {
    personalHistory = await userState.getUserPersonalHis();
    careerHistory = await userState.getUserCareerHis();
    website = await userState.getUserExternalLinks();
  }

  Future<void> sectionTwoUpdate(BuildContext context) async {
    final req = {
      "id": await userState.getUserId(),
      "personalHistory": personalHistory,
      "careerHistory": careerHistory,
      "externalLinks": website
    };

    await cusApiReq.postApi(jsonEncode(req), path: "/api/updateuser");
    await userState.updateUser(context);
  }

  //section three
  List platforms = [];
  List imgUrls = [];
  List<bool> isCompleted = [];
  int selectedPlatform = 0;
  List<TextEditingController> cont = [];
  List savedPlatform = [];

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

  void addControler() {
    cont.add(TextEditingController());
    notifyListeners();
  }

  Future<void> loadSavedPlatform(String platformid) async {
    final req = {
      "userId": await userState.getUserId(),
      "platformId": platformid,
    };
    List data =
        await cusApiReq.postApi(jsonEncode(req), path: "/api/get-user-handle");
    savedPlatform = data[0]["data"];
    notifyListeners();
  }

  Future<bool> addHandal(
      BuildContext context, String platformid, String handal) async {
    final req = {
      "userId": await userState.getUserId(),
      "platformId": platforms[selectedPlatform]["id"],
      "handleName": handal
    };

    List data =
        await cusApiReq.postApi(jsonEncode(req), path: "/api/add-handle");

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
        "Successfully added new handle",
      );
      await loadSavedPlatform(platforms[selectedPlatform]["id"]);
      notifyListeners();
      return true;
    }

    notifyListeners();
    return false;
  }

  void clearAfterAdding() {
    imgUrls = [];
    isCompleted = [];
    cont = [];
    notifyListeners();
  }

  //section four
  //user input 2
  List mainmarketList = [];
  List selectedMainmarket = [];
  List mainmarketVal = [];

  void setMainmarketList(List data) {
    mainmarketList = data;
    for (int i = 0; i < data.length; i++) {
      selectedMainmarket.add(false);
    }
    notifyListeners();
  }

  void setMainmarket(int index, bool value) {
    for (int i = 0; i < selectedMainmarket.length; i++) {
      selectedMainmarket[i] = false;
    }

    selectedMainmarket[index] = value;
    if (value) {
      mainmarketVal = [mainmarketList[index]];
    } else {
      mainmarketVal = [];
    }

    notifyListeners();
  }

  List othermarketList = [];
  List selectedOthermarket = [];
  List othermarketVal = [];

  void setOthermarketList(List data) {
    othermarketList = data;
    for (int i = 0; i < data.length; i++) {
      selectedOthermarket.add(false);
    }
    notifyListeners();
  }

  void setOthermarket(int index, bool value) {
    selectedOthermarket[index] = value;
    if (value) {
      othermarketVal.add(othermarketList[index]);
    } else {
      othermarketVal.remove(othermarketList[index]);
    }

    notifyListeners();
  }

  String getOthermarketValue() {
    String res = "";
    for (int i = 0; i < othermarketVal.length; i++) {
      res += "${othermarketVal[i]["name"]}, ";
    }
    return res;
  }

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

  Future<void> sectionFourUpdate(BuildContext context) async {
    if (currencyVal.isEmpty) {
      erroralert(context, "Empty Field", "Please select a currecny");
    } else if (categoryVal.isEmpty) {
      erroralert(context, "Empty Field", "Please some category");
    } else if (languageVal.isEmpty) {
      erroralert(context, "Empty Field", "Please select a language");
    } else if (mainmarketVal.isEmpty) {
      erroralert(context, "Empty Field", "Please select Main Market");
    } else if (othermarketVal.isEmpty) {
      erroralert(context, "Empty Field", "Please select a Other Market");
    } else {
      final req = {
        "id": await userState.getUserId(),
        "currencyId": currencyVal[0]["id"].toString(),
        "languages": getLanguages(),
        "categories": getCategorys(),
        "marketId": mainmarketVal[0]["id"].toString(),
        "markets": getOthermarket()
      };

      await cusApiReq.postApi(jsonEncode(req), path: "/api/updateuser");

      await userState.updateUser(context);
      notifyListeners();
    }

    notifyListeners();
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

  String getOthermarket() {
    String res = "";
    for (int i = 0; i < othermarketVal.length; i++) {
      res += "${othermarketVal[i]["id"]},";
    }
    return res;
  }

  //section five

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

  String? cityValue;

  void setCityValue(String? val) {
    cityValue = val;
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

  void resetCitySelection() {
    for (int i = 0; i < selectedCity.length; i++) {
      selectedCity[i] = false;
    }
    cityVal = [];
    cityValue = null;
    notifyListeners();
  }

  String? address;
  void setAddress(String value) {
    address = value;
    ChangeNotifier();
  }

  String? number;
  void setNumber(String value) {
    number = value;
    ChangeNotifier();
  }

  Future<void> sectionFiveUpdate(BuildContext context) async {
    if (countryVal.isEmpty) {
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
        "id": await userState.getUserId(),
        "cityId": cityVal[0]["id"].toString(),
        "userContact": number,
        "userGender": (genderVal[0] == "MALE")
            ? "1"
            : (genderVal[0] == "FEMALE")
                ? "2"
                : "3",
        "userFullPostalAddress": address
      };

      await cusApiReq.postApi(jsonEncode(req), path: "/api/updateuser");
      await userState.updateUser(context);
      notifyListeners();
    }
  }
}
