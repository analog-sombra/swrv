import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/services/apirequest.dart';
import 'package:swrv/state/userstate.dart';

final messageState = ChangeNotifierProvider<MessageState>(
  (ref) => MessageState(),
);

class MessageState extends ChangeNotifier {
  CusApiReq cusApiReq = CusApiReq();
  UserState userState = UserState();
  Future<void> saveToken(String token) async {
    final req = {"id": await userState.getUserId(), "deviceToken": token};
    log(req.toString());
    await cusApiReq.postApi(jsonEncode(req), path: "/api/updateuser");
  }
}
