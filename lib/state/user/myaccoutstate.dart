// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/services/apirequest.dart';
import 'package:swrv/state/userstate.dart';

import '../../utils/alerts.dart';

final myAccountState = ChangeNotifierProvider.autoDispose<MyAccountState>(
  (ref) => MyAccountState(),
);

class MyAccountState extends ChangeNotifier {
  UserState userState = UserState();
  CusApiReq apiReq = CusApiReq();
  List<String> tabName = [
    "Channels",
    "Personal Info",
    "Past associations",
    "Reviews",
  ];
  int curTab = 0;
  void setCurTab(int val) {
    curTab = val;
    notifyListeners();
  }

  Future<void> sendMsg(BuildContext context, String msg, String userId) async {
    final req = {
      "campaignDraftId": "0",
      "fromUserId": await userState.getUserId(),
      "toUserId": userId,
      "comment": msg,
    };

    List data = await apiReq.postApi(jsonEncode(req), path: "/api/add-chat");
    if (data[0] == false) {
      Navigator.pop(context);
      erroralert(
        context,
        "Error1",
        data[1].toString(),
      );
    } else if (data[0]["status"] == false) {
      Navigator.pop(context);

      erroralert(
        context,
        "Error2",
        data[0]["message"],
      );
    } else {
      Navigator.pop(context);
      susalert(context, "Sent", "Message has been sent");
    }
  }
}
