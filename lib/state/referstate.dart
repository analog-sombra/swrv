// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/services/apirequest.dart';
import 'package:swrv/state/userstate.dart';
import 'package:swrv/utils/alerts.dart';

final referStatus = ChangeNotifierProvider.autoDispose<ReferState>(
  (ref) => ReferState(),
);

class ReferState extends ChangeNotifier {
  CusApiReq apiReq = CusApiReq();
  UserState userState = UserState();
  String? name;
  String? email;
  String? contact;

  void setName(String text) {
    name = text;
    notifyListeners();
  }

  void setEmail(String text) {
    email = text;
    notifyListeners();
  }

  void setContact(String text) {
    contact = text;
    notifyListeners();
  }

  Future<void> sendRefer(BuildContext context) async {
    final req = {
      "userId": await userState.getUserId(),
      "name": name,
      "email": email,
      "contact": contact
    };
    final data =
        await apiReq.postApi(jsonEncode(req), path: "/api/send-referral");
    if (data[0]["status"] == false) {
      erroralert(context, "Error", data[0]["message"]);
    } else {
      susalert(context, "Sent", "Successfully sent the invite");
    }
  }
}
