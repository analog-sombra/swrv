import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userInputState =
    ChangeNotifierProvider<UserInputState>((ref) => UserInputState());

class UserInputState extends ChangeNotifier {
  
}
