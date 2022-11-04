// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../services/apirequest.dart';
import '../../utils/alerts.dart';

//login state start here
final createCampState =
    ChangeNotifierProvider<CreateCampState>((ref) => CreateCampState());

class CreateCampState extends ChangeNotifier {
  CusApiReq apiReq = CusApiReq();
  TextEditingController name = TextEditingController();
  TextEditingController info = TextEditingController();

  List platforms = [
    "assets/images/facebook.png",
    "assets/images/instagram.png",
    "assets/images/snapchat.png",
    "assets/images/twitter.png",
    "assets/images/youtube.png",
    "assets/images/linkedin.png"
  ];

  List selectedPlatfomrs = [false, false, false, false, false, false];

  String? categoryValue;
  List categoryList = [
    "Sponsored Post",
    "Unboxing Review Posts",
    "Discount codes",
    "Giveaways & contest",
    "Campaign",
  ];

  String? currencyValue;
  List currencyList = ["USD", "INR", "EUR", "BSD", "BYN", "BZD"];

  void setCatValue(String val) {
    categoryValue = val;
    notifyListeners();
  }

  void setCountryValue(String val) {
    currencyValue = val;
    notifyListeners();
  }

  void togglePlatfroms(int val) {
    selectedPlatfomrs[val] = !selectedPlatfomrs[val];
    notifyListeners();
  }

  Future<bool> createCamp(BuildContext context) async {
    if (name.text == "") {
      erroralert(
        context,
        "Empty Field1",
        "Please fill the name of the campaigns",
      );
    } else if (info.text == "") {
      erroralert(
        context,
        "Empty Field2",
        "Please fill the info of the campaigns",
      );
    } else if (categoryValue == null) {
      erroralert(
        context,
        "Empty Field2",
        "Please select the category",
      );
    } else if (currencyValue == null) {
      erroralert(
        context,
        "Empty Field2",
        "Please select the currency",
      );
    } else {
      final req = {
        "f": "createCampaign",
        "campaignName": name.text.toString(),
        "campaignInfo": info.text.toString(),
        "currencyId": "1",
        "categories": categoryValue.toString(),
        "platforms": selectedPlatformList()
      };

      List data = await apiReq.createCmp(
          "http://192.168.0.133/cs/api/api.php", jsonEncode(req));
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
        return true;
      }
    }
    notifyListeners();
    return false;
  }

  String selectedPlatformList() {
    String res = "";
    for (int i = 0; i < selectedPlatfomrs.length; i++) {
      if (selectedPlatfomrs[i]) {
        res += "${i + 1},";
      }
    }
    return res;
  }
}
