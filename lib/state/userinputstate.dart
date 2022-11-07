import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userInputState =
    ChangeNotifierProvider<UserInputState>((ref) => UserInputState());

class UserInputState extends ChangeNotifier {
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
      currencyVal.add(currencyList[index]);
    } else {
      currencyVal.remove(currencyList[index]);
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
    for (int i = 0; i < selectedLanguage.length; i++) {
      selectedLanguage[i] = false;
    }
    selectedLanguage[index] = value;
    if (value) {
      languageVal.add(languageList[index]);
    } else {
      languageVal.remove(languageList[index]);
    }

    notifyListeners();
  }

  //user input 4
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
      countryVal.add(countryList[index]);
    } else {
      countryVal.remove(countryList[index]);
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
      cityVal.add(cityList[index]);
    } else {
      cityVal.remove(cityList[index]);
    }
    notifyListeners();
  }
}
