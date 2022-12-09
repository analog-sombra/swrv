import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/state/userstate.dart';

final userProfileEditState =
    ChangeNotifierProvider.autoDispose<UserProfileEditState>(
  (ref) => UserProfileEditState(),
);

class UserProfileEditState extends ChangeNotifier {
  UserState userState = UserState();
  //section one
  String? email;
  String? username;
  String? nickname;
  String? dob;
  String? bio;

  String? gender;
  List<String> genders = ["MALE", "FEMALE", "TRANSGENDER"];
  int selectedGender = -1;

  Future<void> initSectionOne(BuildContext context) async {
    email = await userState.getUserEmail();
    username = await userState.getUserName();
    nickname = await userState.getNickname();
    String swapdob = await userState.getUserDob();
    dob =
        "${swapdob.split("-")[2]}-${swapdob.split("-")[1]}-${swapdob.split("-")[0]}";
    final userGender = await userState.getUserGender();

    if (userGender == "MALE") {
      selectedGender = 1;
      gender = "MALE";
    } else if (userGender == "FEMALE") {
      selectedGender = 2;
      gender = "FEMALE";
    } else {
      selectedGender = 3;
      gender = "TRANSGENDER";
    }
    bio = await userState.getUserBio();
  }

  void showdata() {
    final req = {
      "username": username,
      "nickname": nickname,
      "email": email,
      "dob": dob,
      "bio": bio,
      "gender": gender
    };
    log(req.toString());
  }
}
