// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swrv/state/userstate.dart';

import '../../services/apirequest.dart';
import '../../utils/alerts.dart';

//login state start here
final createCampState = ChangeNotifierProvider.autoDispose<CreateCampState>(
    (ref) => CreateCampState());

class CreateCampState extends ChangeNotifier {
  double rating = 3;
  UserState userState = UserState();

  List<File> images = [];

  List data = [];
  void setdata(List dataval) {
    data = dataval;
    notifyListeners();
  }

  void addImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemp = File(image.path);

    images.add(imageTemp);
    notifyListeners();
  }

  void removeImage(File file) {
    images.remove(file);
    notifyListeners();
  }

  List<String> mention = [];

  void addMention(String data) {
    mention.add(data);
    notifyListeners();
  }

  void removeMention(String data) {
    mention.remove(data);
    notifyListeners();
  }

  List<String> hashtag = [];

  void addHashTag(String data) {
    hashtag.add(data);
    notifyListeners();
  }

  void removeHashTag(String data) {
    hashtag.remove(data);
    notifyListeners();
  }

  List<String> dos = [];

  void addDos(String data) {
    dos.add(data);
    notifyListeners();
  }

  void removeDos(String data) {
    dos.remove(data);
    notifyListeners();
  }

  List<String> dont = [];

  void addDont(String data) {
    dont.add(data);
    notifyListeners();
  }

  void removedont(String data) {
    dont.remove(data);
    notifyListeners();
  }

  void setRating(double val) {
    rating = val;
    notifyListeners();
  }

  List campData = [];

  void setCampData(List data) {
    campData = data;
    notifyListeners();
  }

  CusApiReq apiReq = CusApiReq();

  List platforms = [];
  List selectedPlatfomrs = [];
  List selectedPlatfomrsList = [];

  void setPlatforms(List data) {
    platforms = data;
    for (int i = 0; i < data.length; i++) {
      selectedPlatfomrs.add(false);
    }
    notifyListeners();
  }

  String? currencyValue;
  String? currencyId;
  List currencyList = [];

  void setCurrecny(List data) {
    currencyList = data;
    notifyListeners();
  }

  void setCurrencyId(int id) {
    currencyId = currencyList[id]["id"];
    notifyListeners();
  }

  void setCurrencyValue(String val) {
    currencyValue = val;
    notifyListeners();
  }

  String? cmpValue;
  String? cmpId;
  List cmpList = [];

  void setCmp(List data) {
    cmpList = data;
    notifyListeners();
  }

  void setCmpId(int id) {
    cmpId = cmpList[id]["id"];
    notifyListeners();
  }

  void setCmpValue(String val) {
    cmpValue = val;
    notifyListeners();
  }

  String? categoryValue;
  String? categoryId;
  List categoryList = [];

  void setCategory(List data) {
    categoryList = data;
    notifyListeners();
  }

  void setCategoryId(int id) {
    categoryId = categoryList[id]["id"];
    setCatValue(categoryList[id]["categoryName"]);

    notifyListeners();
  }

  void setCatValue(String val) {
    categoryValue = val;
    notifyListeners();
  }

  String? cityValue;
  String? cityId;
  List cityList = [];

  void setCity(List data) {
    cityList = data;
    notifyListeners();
  }

  void setCityId(int id) {
    cityId = cityList[id]["id"];
    notifyListeners();
  }

  void setCityValue(String val) {
    cityValue = val;
    notifyListeners();
  }

  void togglePlatfroms(int val) {
    selectedPlatfomrs[val] = !selectedPlatfomrs[val];
    if (selectedPlatfomrsList.contains(platforms[val]["id"])) {
      selectedPlatfomrsList.remove(platforms[val]["id"]);
    } else {
      selectedPlatfomrsList.add(platforms[val]["id"]);
    }
    notifyListeners();
  }

  Future<bool> createCamp(BuildContext context, List fields) async {
    bool testcase = false;

    for (int i = 0; i < fields.length; i++) {
      if (fields[i] == "") {
        testcase = true;
      }
    }

    if (testcase) {
      erroralert(
        context,
        "Empty Field",
        "Please fill all the fields",
      );
    } else if (int.parse(fields[4]) >= int.parse(fields[5])) {
      erroralert(
        context,
        "Error",
        "Min reach should be lower then max reach",
      );
    } else if (cmpId == null) {
      erroralert(
        context,
        "Empty Field",
        "Please select the category",
      );
    } else if (categoryId == null) {
      erroralert(
        context,
        "Empty Field",
        "Please select the category",
      );
    } else if (currencyValue == null) {
      erroralert(
        context,
        "Empty Field",
        "Please select the currency",
      );
    } else if (cityValue == null) {
      erroralert(
        context,
        "Empty Field",
        "Please select the city",
      );
    } else if (selectedPlatfomrsList.isEmpty) {
      erroralert(
        context,
        "Empty Field",
        "Please Select some platforms",
      );
    } else if (mention.isEmpty) {
      erroralert(
        context,
        "Empty Field",
        "Please mention at leat one person",
      );
    } else if (hashtag.isEmpty) {
      erroralert(
        context,
        "Empty Field",
        "Please Please write at leat one hashtag",
      );
    } else if (dos.isEmpty) {
      erroralert(
        context,
        "Empty Field",
        "Please write at leat one do's",
      );
    } else if (dont.isEmpty) {
      erroralert(
        context,
        "Empty Field",
        "Please write at leat one don't",
      );
    } else {
      final req = {
        "userId": await userState.getUserId(),
        "brandUserId": await userState.getUserId(),
        "brandId": await userState.getBrandId(),
        "cityId": cityId,
        "campaignTypeId": categoryId,
        "campaignName": fields[0],
        "campaignInfo": fields[1],
        "startAt": DateTime(
                int.parse(fields[2].toString().split("-")[2]),
                int.parse(fields[2].toString().split("-")[1]),
                int.parse(fields[2].toString().split("-")[0]))
            .toString(),
        "endAt": DateTime(
                int.parse(fields[3].toString().split("-")[2]),
                int.parse(fields[3].toString().split("-")[1]),
                int.parse(fields[3].toString().split("-")[0]))
            .toString(),
        "minReach": fields[4],
        "maxReach": fields[5],
        "costPerPost": fields[6],
        "totalBudget": fields[7],
        "minEligibleRating": rating.toString(),
        "currencyId": currencyId,
        "categories": cmpId.toString(),
        "platforms": seletedText(selectedPlatfomrsList),
        "mentions": seletedText(mention),
        "hashtags": seletedText(hashtag),
        "dos": seletedText(dos),
        "donts": seletedText(dont)
      };

      log(req.toString());

      // List data =
      //     await apiReq.postApi(jsonEncode(req), path: "/api/createchampaign");
      List data =
          await apiReq.postApi(jsonEncode(req), path: "/api/add-campaign");

      if (data[0] == false) {
        erroralert(
          context,
          "Error1",
          data[1].toString(),
        );
      } else if (data[0]["status"] == false) {
        erroralert(
          context,
          "Error2",
          data[0]["message"],
        );
      } else {
        notifyListeners();
        return true;
      }
    }
    notifyListeners();
    return false;
  }

  bool nextPage(BuildContext context, List fields) {
    bool res = false;
    bool testcase = false;

    for (int i = 0; i < fields.length; i++) {
      if (fields[i] == "") {
        testcase = true;
      }
    }

    if (testcase) {
      erroralert(
        context,
        "Empty Field",
        "Please fill all the fields",
      );
    } else if (int.parse(fields[4]) >= int.parse(fields[5])) {
      erroralert(
        context,
        "Error",
        "Min reach should be lower then max reach",
      );
    } else if (cmpId == null) {
      erroralert(
        context,
        "Empty Field",
        "Please select the category",
      );
    } else if (categoryId == null) {
      erroralert(
        context,
        "Empty Field",
        "Please select the category",
      );
    } else if (currencyValue == null) {
      erroralert(
        context,
        "Empty Field",
        "Please select the currency",
      );
    } else if (cityValue == null) {
      erroralert(
        context,
        "Empty Field",
        "Please select the city",
      );
    } else if (selectedPlatfomrsList.isEmpty) {
      erroralert(
        context,
        "Empty Field",
        "Please Select some platforms",
      );
    } else if (mention.isEmpty) {
      erroralert(
        context,
        "Empty Field",
        "Please mention at leat one person",
      );
    } else if (hashtag.isEmpty) {
      erroralert(
        context,
        "Empty Field",
        "Please Please write at leat one hashtag",
      );
    } else if (dos.isEmpty) {
      erroralert(
        context,
        "Empty Field",
        "Please write at leat one do's",
      );
    } else if (dont.isEmpty) {
      erroralert(
        context,
        "Empty Field",
        "Please write at leat one don't",
      );
    } else if (images.isEmpty) {
      erroralert(
        context,
        "Empty Field",
        "Please Select atleast one Mood",
      );
    } else {
      res = true;
    }

    return res;
  }

  Future<String> getBrandId() async {
    String userId = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userdata = prefs.getString("user");
    userId = jsonDecode(userdata!)[0]["brandId"].toString();
    notifyListeners();
    return userId;
  }

  String seletedText(List data) {
    String res = "";
    for (int i = 0; i < data.length; i++) {
      if ((i + 1) == data.length) {
        res += data[i];
      } else {
        res += "${data[i]},";
      }
    }
    return res;
  }
}
