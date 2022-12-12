import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final myAccountState = ChangeNotifierProvider.autoDispose<MyAccountState>(
  (ref) => MyAccountState(),
);

class MyAccountState extends ChangeNotifier {
  List<String> tabName = [
    "Channels",
    "Persnal info",
    "Past associations",
    "Reviews",
  ];
  int curTab = 0;
  void setCurTab(int val) {
    curTab = val;
    notifyListeners();
  }
}
