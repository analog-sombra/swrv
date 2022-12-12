// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
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
  File? imageFile;
  String? countryCode;

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

  void setCountryCode(int id) {
    countryCode = cityList[id]["country"]["isd"];
    notifyListeners();
  }

  Future<bool> createBrand(
    BuildContext context,
    List<String> fields,
  ) async {
    String? imgFilePath;
    if (imageFile != null) {
      dynamic res = await apiReq.uploadFile(imageFile!.path);
      imgFilePath = res["data"]["filePath"];
    }

    if (fields[5].toString().length != 10) {
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
        "userId": await userState.getUserId(),
        "brandLogoUrl": imgFilePath,
        "brandName": fields[0],
        "brandCode": fields[1],
        "brandWebUrl": fields[2],
        "brandFullRegisteredAddress": fields[3],
        "brandSupportEmail": fields[4],
        "brandSupportContact": fields[5],
        "brandBioInfo": fields[6],
        "comapnyBio": fields[7],
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
