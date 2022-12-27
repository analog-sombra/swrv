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
  Future<void> showInboxMsg(BuildContext context) async {
    messages = [];
    // final req1 = {
    //   "search": {"toUser": await userState.getUserId()}
    // };
    final req1 = {
      "fromToUser": {"toUser": await userState.getUserId()}
    };
    // final req2 = {
    //   "search": {"fromUser": await userState.getUserId()}
    // };
    List data1 =
        await cusApiReq.postApi2(jsonEncode(req1), path: "/api/search-chat");
    // List data2 =
    //     await cusApiReq.postApi2(jsonEncode(req2), path: "/api/search-chat");

    if (data1[0]["status"]) {
      messages = [...messages, ...data1[0]["data"]];
    }
    // if (data2[0]["status"]) {
    //   messages = [...messages, ...data2[0]["data"]];
    // }
  }
}
