// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
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

enum RevType { none, cash, product, revenue, discount }

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
    List data = await apiReq.postApi(jsonEncode({}), path: "/api/getplatform");
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

  String? target;
  void setTarget(String val) {
    target = val;
    notifyListeners();
  }

  String? minTarget;
  void setMinTarget(String val) {
    minTarget = val;
    notifyListeners();
  }

  double rating = 3;

  void setRating(double val) {
    rating = val;
    notifyListeners();
  }

  //page 3
  List<String> audienceLocation = [];

  void addAudienceLocation(String data) {
    audienceLocation.add(data);
    notifyListeners();
  }

  void removeAudienceLocation(String data) {
    audienceLocation.remove(data);
    notifyListeners();
  }

  String? minInf;
  void setMinInf(String val) {
    minInf = val;
    notifyListeners();
  }

  String? tillDate;
  void setTillDate(String val) {
    tillDate = val;
    notifyListeners();
  }

  String? cmpValue;
  String? cmpId;
  List cmpList = [];

  Future<void> setCmp() async {
    List data = await apiReq.postApi(jsonEncode({}), path: "/api/getcategory");
    cmpList = data[0]["data"];
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

  List<String> remuneration = ["Cash", "Product", "Revenue", "Discount"];
  String? remunerationValue;
  RevType revType = RevType.none;
  void setRemuneration(String val) {
    remunerationValue = val;
    notifyListeners();
  }

  void setRevVal(int index) {
    if (index == 0) {
      revType = RevType.cash;
    } else if (index == 1) {
      revType = RevType.product;
    } else if (index == 2) {
      revType = RevType.revenue;
    } else if (index == 3) {
      revType = RevType.discount;
    }
  }

  String? currencyValue;
  String? currencyId;
  List currencyList = [];

  Future<void> setCurrecny() async {
    List data = await apiReq.postApi(jsonEncode({}), path: "/api/getcurrency");

    currencyList = data[0]["data"];
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

  //  cashText
//  productText
//  revenueText
//  discountText

  String? cashText;
  void setCashText(String val) {
    cashText = val;
    notifyListeners();
  }

  String? productText;
  void setProductText(String val) {
    productText = val;
    notifyListeners();
  }

  String? revenueText;
  void setRevenueText(String val) {
    revenueText = val;
    notifyListeners();
  }

  String? discountText;
  void setDiscountText(String val) {
    discountText = val;
    notifyListeners();
  }

  //page four
  String? name;
  void setName(String val) {
    name = val;
    notifyListeners();
  }

  String? startDate;
  void setStartDate(String val) {
    startDate = val;
    notifyListeners();
  }

  String? endDate;
  void setEndDate(String val) {
    endDate = val;
    notifyListeners();
  }

  String? minReach;
  void setMinReach(String val) {
    minReach = val;
    notifyListeners();
  }

  String? maxReach;
  void setMaxreach(String val) {
    maxReach = val;
    notifyListeners();
  }

  String? costPerPost;
  void setCostPerPost(String val) {
    costPerPost = val;
    notifyListeners();
  }

  String? totalBudget;
  void setTotalBudget(String val) {
    totalBudget = val;
    notifyListeners();
  }

  List<File> images = [];

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

  String? cityValue;

  void setCityValue(String? val) {
    cityValue = val;
    notifyListeners();
  }

  List cityList = [];
  List selectedCity = [];
  List cityVal = [];

  void setCityList(List data) {
    cityList = data;
    for (int i = 0; i < data.length; i++) {
      selectedCity.add(false);
    }
    notifyListeners();
  }

  void setCity(int index, bool value) {
    for (int i = 0; i < selectedCity.length; i++) {
      selectedCity[i] = false;
    }
    selectedCity[index] = value;
    if (value) {
      cityVal = [cityList[index]];
    } else {
      cityVal = [];
    }
    notifyListeners();
  }

  void resetCitySelection() {
    for (int i = 0; i < selectedCity.length; i++) {
      selectedCity[i] = false;
    }
    cityVal = [];
    cityValue = null;
    notifyListeners();
  }

  // ####################################

  String? champId;

  void setChampId(String id) {
    champId = id;
    notifyListeners();
  }

  List campData = [];

  void setCampData(List data) {
    campData = data;
    notifyListeners();
  }

  Future<List> createCamp(BuildContext context) async {
    final req = {
      "userId": await userState.getUserId(),
      "brandUserId": await userState.getUserId(),
      "brandId": await userState.getBrandId(),
      "cityId": cityVal[0]["id"].toString(),
      "campaignTypeId": categoryId,
      "campaignName": name,
      "campaignInfo": campInfo,
      "startAt": DateTime(
              int.parse(startDate.toString().split("-")[2]),
              int.parse(startDate.toString().split("-")[1]),
              int.parse(startDate.toString().split("-")[0]))
          .toString(),
      "endAt": DateTime(
              int.parse(endDate.toString().split("-")[2]),
              int.parse(endDate.toString().split("-")[1]),
              int.parse(endDate.toString().split("-")[0]))
          .toString(),
      "minReach": minReach,
      "maxReach": maxReach,
      "costPerPost": costPerPost,
      "totalBudget": totalBudget,
      "minEligibleRating": rating.toString(),
      "currencyId": currencyId,
      "categories": cmpId.toString(),
      "platforms": seletedText(selectedPlatfomrsList),
      "mentions": seletedText(mention),
      "hashtags": seletedText(hashtag),
      "dos": seletedText(dos),
      "donts": seletedText(dont),
      "totalParticipants": minInf,
      "remuneration": (revType == RevType.cash)
          ? "1"
          : (revType == RevType.product)
              ? "2"
              : (revType == RevType.revenue)
                  ? "3"
                  : "4",
      "postApproval": approval == Approval.yes ? "1" : "0",
      "inviteStartAt": startDate,
      "inviteEndAt": tillDate,
      "geoLat": "0",
      "geoLng": "0",
      "georadiusKm": "3",
      "audienceLocations": seletedText(audienceLocation)
    };
    if (cashText != null) {
      req["remunerationCash"] = cashText;
    }
    if (productText != null) {
      req["remunerationProductDetail"] = productText;
    }
    if (revenueText != null) {
      req["remunerationRevenuePer"] = revenueText;
    }
    if (discountText != null) {
      req["dicountCoupon"] = discountText;
    }
    if (minTarget != null) {
      req["minTarget"] = minTarget;
    }
    if (target != null) {
      req["maxTarget"] = target;
    }


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

    notifyListeners();
    return [false];
  }

  Future<void> addMoodBorad(BuildContext context) async {
    for (int i = 0; i < images.length; i++) {
      String? imgFilePath;
      dynamic res = await apiReq.uploadFile(images[i].path);
      if (res["status"] == false) {
        erroralert(context, "error", res["messages"].toString());
      }
      imgFilePath = res["data"]["filePath"];
      final req = {
        "campaignId": champId,
        "title": "moodboard$champId${i.toString()}",
        "url": imgFilePath
      };

      await apiReq.postApi(jsonEncode(req), path: "/api/add-campaign-mood");
    }
  }

  Future<void> addAttachmentUrl(BuildContext context) async {
    String? attFilePath;
    dynamic res = await apiReq.uploadFile(attachments!.path);
    if (res["status"] == false) {
      erroralert(context, "error", res["message"].toString());
    }
    attFilePath = res["data"]["filePath"];

    final req = {
      "campaignId": champId,
      "title": "attachemtn$champId",
      "url": attFilePath
    };


    await apiReq.postApi(jsonEncode(req), path: "/api/add-campaign-attachment");
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
