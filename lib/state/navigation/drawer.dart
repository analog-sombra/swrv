import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final drawerIndex = StateProvider.autoDispose<DrawerIndex>(
  (ref) => DrawerIndex(),
);

class DrawerIndex extends ChangeNotifier {
  int index = 0;
  void setIndex(int value) {
    index = value;
    notifyListeners();
  }
}

final bottomIndex = StateProvider.autoDispose<BottomIndex>(
  (ref) => BottomIndex(),
);

class BottomIndex extends ChangeNotifier {
  int index = 0;
  void setIndex(int value) {
    index = value;
    notifyListeners();
  }
}
