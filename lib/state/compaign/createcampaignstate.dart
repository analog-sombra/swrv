// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swrv/state/userstate.dart';

import '../../services/apirequest.dart';
import '../../utils/alerts.dart';

enum CampaingType {
  none,
  sponsoredPosts,
  unboxingOrReviewPosts,
  discountCodes,
  giveawaysContest
}

enum Approval { none, yes, no }

//login state start here
final createCampState = ChangeNotifierProvider.autoDispose<CreateCampState>(
    (ref) => CreateCampState());

class CreateCampState extends ChangeNotifier {
  //base setup
  UserState userState = UserState();
  CusApiReq apiReq = CusApiReq();

//page one
  CampaingType campType = CampaingType.none;
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

  void setCampType(int val) {
    if (val == 0) {
      campType = CampaingType.sponsoredPosts;
    } else if (val == 1) {
      campType = CampaingType.unboxingOrReviewPosts;
    } else if (val == 2) {
      campType = CampaingType.discountCodes;
    } else if (val == 3) {
      campType = CampaingType.giveawaysContest;
    }
    notifyListeners();
  }

  //page two
  List platforms = [];
  List selectedPlatfomrs = [];
  List selectedPlatfomrsList = [];

  Future<void> setPlatforms() async {
    final req1 = {};
    List data =
        await apiReq.postApi(jsonEncode(req1), path: "/api/getplatform");
    platforms = data[0]["data"];
    for (int i = 0; i < platforms.length; i++) {
      selectedPlatfomrs.add(false);
    }
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

  List<String> mediaType = ["Post", "Story", "Reel", "Video", "Audio"];
  int selectedMediaType = -1;
  void setMediaType(int val) {
    selectedMediaType = val;
    notifyListeners();
  }

  File? attachments;

  Future<void> addAttachment(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );
    if (result == null) return;
    final att = File(result.files.single.path!);
    int sizeInBytes = att.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb > 2) {
      erroralert(context, "Error", "File Size should be less then 2 MB");
      return;
    } else {
      attachments = att;
    }

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

  Approval approval = Approval.none;
  void setApproval(Approval val) {
    approval = val;
    notifyListeners();
  }

  String? campInfo;
  void setCampInfo(String val) {
    campInfo = val;
    notifyListeners();
  }

  String? affiliatedLinks;
  void setAffiliatedLinks(String val) {
    affiliatedLinks = val;
    notifyListeners();
  }

  String? discountCoupons;
  void setDiscountCoupons(String val) {
    discountCoupons = val;
    notifyListeners();
  }

  double rating = 3;

  void setRating(double val) {
    rating = val;
    notifyListeners();
  }

  // ####################################

  List<File> images = [];

  bool isChampCreated = false;
  String? champId;

  void setChampCreated(bool val) {
    isChampCreated = val;
    notifyListeners();
  }

  void setChampId(String id) {
    champId = id;
    notifyListeners();
  }

  List data = [];
  void setdata(List dataval) {
    data = dataval;
    notifyListeners();
  }

  Future<void> addImage(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemp = File(image.path);
    int sizeInBytes = imageTemp.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb > 2) {
      erroralert(context, "Error", "Image file Size should be less then 2 MB");
      return;
    } else {
      images.add(imageTemp);
    }
    notifyListeners();
  }

  void removeImage(File file) {
    images.remove(file);
    notifyListeners();
  }

  List campData = [];

  void setCampData(List data) {
    campData = data;
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

  Future<List> createCamp(BuildContext context, List fields) async {
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
    } else if (attachments == null) {
      erroralert(
        context,
        "Empty Field",
        "Please Attach a file",
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
        return [data[0]["data"]];
      }
    }
    notifyListeners();
    return [false];
  }

  Future<void> addMoodBorad(BuildContext context) async {
    for (int i = 0; i < images.length; i++) {
      String? imgFilePath;
      dynamic res = await apiReq.uploadFile(images[i].path);
      if (res["status"] == false) {
        erroralert(context, "error", res["status"].toString());
      }
      imgFilePath = res["data"]["filePath"];
      final req = {
        "campaignId": champId,
        "title": "moodboard$champId$i",
        "url": imgFilePath
      };

      await apiReq.postApi(jsonEncode(req), path: "/api/add-campaign-mood");
    }
  }

  Future<void> addAttachmentUrl(BuildContext context) async {
    String? attFilePath;
    dynamic res = await apiReq.uploadFile(attachments!.path);
    if (res["status"] == false) {
      erroralert(context, "error", res["status"].toString());
    }
    attFilePath = res["data"]["filePath"];
    final req = {
      "campaignId": champId,
      "title": "attachemtn$champId",
      "url": attFilePath
    };

    await apiReq.postApi(jsonEncode(req), path: "/api/add-campaign-attachment");
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
