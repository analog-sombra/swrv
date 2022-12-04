// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../services/apirequest.dart';
import '../../utils/alerts.dart';

final findBrandState = ChangeNotifierProvider.autoDispose<FindBrandState>(
    (ref) => FindBrandState());

class FindBrandState extends ChangeNotifier {
  CusApiReq apiReq = CusApiReq();
  bool isSearch = false;
  List searchData = [];

  void setIsSearch(bool val) {
    isSearch = val;
    notifyListeners();
  }

  void setSearchData(List data) {
    searchData = data;
    notifyListeners();
  }

  Future<List> textSearch(BuildContext context, String text) async {
    if (text == "") {
      erroralert(context, "Error", "In order to search fell the field...");
    } else {
      final req = {"search": text};

      List data =
          await apiReq.postApi(jsonEncode(req), path: "/api/search-brand");

      if (data[0] == false) {
        erroralert(
          context,
          "Error",
          data[1].toString(),
        );
      } else if (data[0]["status"] == false) {
        erroralert(
          context,
          "Error",
          data[0]["message"],
        );
      } else {
        notifyListeners();
        return [jsonEncode(data[0]["data"])];
      }
    }
    notifyListeners();
    return [false];
  }

  void clear() {
    isSearch = false;
    searchData = [];
    notifyListeners();
  }
}
