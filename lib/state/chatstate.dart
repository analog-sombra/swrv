// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/services/apirequest.dart';
import 'package:swrv/state/userstate.dart';

final chatState = ChangeNotifierProvider<ChatState>(
  (ref) => ChatState(),
);

class ChatState extends ChangeNotifier {
  List mes = [];
  UserState userState = UserState();
  CusApiReq cusApiReq = CusApiReq();
  Future<void> setMessages(BuildContext context, String userId) async {
    mes = [];

    final req1 = {
      "search": {
        "fromUser": await userState.getUserId(),
        "toUser": userId,
      }
    };

    List data1 =
        await cusApiReq.postApi2(jsonEncode(req1), path: "/api/search-chat");

    final req2 = {
      "search": {
        "fromUser": userId,
        "toUser": await userState.getUserId(),
      }
    };

    List data2 =
        await cusApiReq.postApi2(jsonEncode(req2), path: "/api/search-chat");

    if (data1[0]["status"] == true) {
      mes = [...mes, ...data1[0]["data"]];
    }
    if (data2[0]["status"] == true) {
      mes = [...mes, ...data2[0]["data"]];
    }

    mes.sort((a, b) {
      DateTime dateOne = DateTime.parse(a["updatedAt"]);
      DateTime dateTwo = DateTime.parse(b["updatedAt"]);
      return dateOne.compareTo(dateTwo);
    });
    notifyListeners();
  }

  Future<void> sendMessage(
      BuildContext context, String msg, String userId) async {
    final req = {
      "campaignDraftId": "0",
      "fromUserId": await userState.getUserId(),
      "toUserId": userId,
      "comment": msg
    };

    await cusApiReq.postApi(jsonEncode(req), path: "/api/add-chat");
    notifyListeners();
  }
}
