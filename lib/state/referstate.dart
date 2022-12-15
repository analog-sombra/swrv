import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final referStatus = ChangeNotifierProvider.autoDispose<ReferState>(
  (ref) => ReferState(),
);

class ReferState extends ChangeNotifier {
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
    final req = {"name": name, "email": email, "contact": contact};
    log(req.toString());
  }
}
