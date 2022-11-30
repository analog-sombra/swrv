// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/state/userstate.dart';

import '../../services/apirequest.dart';
import '../../utils/alerts.dart';
import '../brandinputstate.dart';

final createBrandState = ChangeNotifierProvider.autoDispose<CreateBrandState>(
    (ref) => CreateBrandState());

class CreateBrandState extends ChangeNotifier {
  BrandInputState brandInput = BrandInputState();
  UserState userState = UserState();

  CusApiReq apiReq = CusApiReq();
  String? cityValue;
  String? cityId;
  List cityList = [];
  String? brandlogo;
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

  Future<bool> createBrand(
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
    } else if (fields[4].toString().length != 10) {
      erroralert(
        context,
        "Contact number",
        "Contact number should be 10 deigt",
      );
    } else if (cityId == null) {
      erroralert(
        context,
        "City Error",
        "Please select a ctiy",
      );
    } else {
      final req = {
        "userId": userid,
        "brandName": fields[0],
        "brandCode": fields[1],
        "brandFullRegisteredAddress": fields[2],
        "brandSupportEmail": fields[3],
        "brandSupportContact": fields[4],
        "brandBioInfo": fields[5],
        "cityId": cityId
      };

      List data = await apiReq.postApi(jsonEncode(req), path: "/api/add-brand");

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
        await userState.setNewUserData(context, data[0]["data"]["id"]);
        brandInput.setBrandValue(
            "${data[0]["data"]["brand"]["name"]} [${data[0]["data"]["brand"]["code"]}]");
        log("${data[0]["data"]["brand"]["name"]} [${data[0]["data"]["brand"]["code"]}]");
        log(brandInput.brandValue.toString());
        notifyListeners();
        return true;
      }
    }

    notifyListeners();
    return false;
  }

  // Future<bool> uploadLogo(BuildContext context, String imagepath) async {
  //   dynamic data = await apiReq.uploadFile(imagepath, path: "brand/logo/");

  //   if (data['status'] == false) {
  //     erroralert(
  //       context,
  //       "Error",
  //       data['message'],
  //     );
  //   } else {
  //     brandlogo = data['data']['filePath'];
  //     notifyListeners();
  //     return true;
  //   }

  //   notifyListeners();
  //   return false;
  // }
}
