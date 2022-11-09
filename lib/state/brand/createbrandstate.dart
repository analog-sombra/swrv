import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final createBrandState =
    ChangeNotifierProvider<CreateBrandState>((ref) => CreateBrandState());

class CreateBrandState extends ChangeNotifier {
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
}
