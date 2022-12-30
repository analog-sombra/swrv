import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/services/apirequest.dart';
import 'package:swrv/state/userstate.dart';

final inboxState = ChangeNotifierProvider<InboxState>(
  (ref) => InboxState(),
);

class InboxState extends ChangeNotifier {
  CusApiReq cusApiReq = CusApiReq();
  UserState userState = UserState();
  List messages = [];
  List<String> msgIds = [];
  Future<void> showInboxMsg(BuildContext context) async {
    messages = [];
    msgIds = [];
    // final req1 = {
    //   "search": {"toUser": await userState.getUserId()}
    // };

    // final req2 = {
    //   "search": {"fromUser": await userState.getUserId()}
    // };

    //  List data1 =
    // await cusApiReq.postApi2(jsonEncode(req1), path: "/api/search-chat");

    // List data2 =
    //     await cusApiReq.postApi2(jsonEncode(req2), path: "/api/search-chat");

    final req1 = {
      "search": {"fromToUser": await userState.getUserId()}
    };
    List data =
        await cusApiReq.postApi2(jsonEncode(req1), path: "/api/search-chat");

    String userId = await userState.getUserId();

    if (data[0]["status"]) {
      List response = data[0]["data"];
      for (int i = 0; i < response.length; i++) {
        final fromId = response[i]["fromUser"]["id"].toString();
        final toId = response[i]["toUser"]["id"].toString();
        if (fromId == userId) {
          if (!msgIds.contains(toId)) {
            msgIds.add(toId);
            messages = [...messages, response[i]];
          }
        }
        if (toId == userId) {
          if (!msgIds.contains(fromId)) {
            msgIds.add(fromId);
            messages = [...messages, response[i]];
          }
        }
      }
    }
  }
}
