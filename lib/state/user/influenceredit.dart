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
    } else if (userGender == "FEMALE") {
      selectedGender[1] = true;
    } else {
      selectedGender[2] = true;
    }
    bio = await userState.getUserBio();

    notifyListeners();
  }

  Future<bool> sectionOneUpdate(BuildContext context) async {
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
    List data =
        await cusApiReq.postApi(jsonEncode(req), path: "/api/updateuser");

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
      userState.updateUser(context);
      notifyListeners();
      return true;
    }

    notifyListeners();
    return false;
  }

  void showdata() {
    // final req = {
    //   "id": await userState.getUserId(),
    //   "userName": fields[1],
    //   "userKnownAs": fields[2],
    //   "userDOB": DateTime(
    //           int.parse(fields[3].toString().split("-")[2]),
    //           int.parse(fields[3].toString().split("-")[1]),
    //           int.parse(fields[3].toString().split("-")[0]))
    //       .toString(),
    //   "userBioInfo": fields[4]
    // };

    // final req = {
    //   "username": username,
    //   "nickname": nickname,
    //   "email": email,
    //   "dob": dob,
    //   "bio": bio,
    //   "gender": genderVal[0]
    // };
    // log(req.toString());
  }
}
