// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/services/apirequest.dart';

import '../../utils/alerts.dart';
import '../userstate.dart';

final campaignInfoState = ChangeNotifierProvider.autoDispose<CampaignInfoState>(
  (ref) => CampaignInfoState(),
);

class CampaignInfoState extends ChangeNotifier {
  UserState userState = UserState();
  CusApiReq apiReq = CusApiReq();
  bool createDraft = false;
  String? description;
  String? publishDate;
  File? attachments;
  List<String> tabName = [
    "Campaign draft",
    "Live Campaigns",
    "Payments",
  ];
  int curTab = 0;
  void setCurTab(int val) {
    curTab = val;
    notifyListeners();
  }

  void setCreateDraft(bool val) {
    createDraft = val;
    notifyListeners();
  }

  void setDescription(String text) {
    description = text;
    notifyListeners();
  }

  void setPublishDate(String text) {
    publishDate = text;
    notifyListeners();
  }

  List platforms = [];
  List selectedPlatfomrs = [];
  String? platfromid;

  void setPlatforms(List data) {
    platforms = data;
    for (int i = 0; i < data.length; i++) {
      selectedPlatfomrs.add(false);
    }
    notifyListeners();
  }

  void togglePlatfroms(int val) {
    for (int i = 0; i < selectedPlatfomrs.length; i++) {
      selectedPlatfomrs[i] = false;
    }
    selectedPlatfomrs[val] = true;
    platfromid = platforms[val]["id"];

    notifyListeners();
  }

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

  Future<void> createcmapDraft(
    BuildContext context,
    String champId,
  ) async {
    if (platfromid == null) {
      erroralert(context, "Error", "Please select a platform");
    } else if (attachments == null) {
      erroralert(
        context,
        "Empty Field",
        "Please Attach a file",
      );
    } else {
      String? attFilePath;
      dynamic res = await apiReq.uploadFile(attachments!.path);
      if (res["status"] == false) {
        erroralert(context, "error", res["status"].toString());
      }
      attFilePath = res["data"]["filePath"];

      final req = {
        "campaignId": champId,
        "influencerId": await userState.getUserId(),
        "handleId": platfromid,
        "publishAt": DateTime(
          int.parse(publishDate.toString().split("-")[2]),
          int.parse(publishDate.toString().split("-")[1]),
          int.parse(publishDate.toString().split("-")[0]),
        ).toString(),
        "attach01": attFilePath,
        "description": description
      };

      List data = await apiReq.postApi(jsonEncode(req), path: "/api/add-draft");
      if (data[0] == false) {
        Navigator.pop(context);
        erroralert(
          context,
          "Error",
          data[1].toString(),
        );
      } else if (data[0]["status"] == false) {
        Navigator.pop(context);
        erroralert(
          context,
          "Error",
          data[0]["message"],
        );
      } else {
        createDraft = false;
        Navigator.pop(context);
        susalert(context, "Sent", "Request has been sent");
      }
    }
  }

  Future<void> applyForChamp(
      BuildContext context, String des, String champId, String toUserId) async {
    final req = {
      
      "campaignId": champId,
      "influencerId": await userState.getUserId(),
      "fromUserId": await userState.getUserId(),
      "toUserId": toUserId,
      "inviteMessage": des
    };

    List data = await apiReq.postApi(jsonEncode(req), path: "/api/add-invite");
    if (data[0] == false) {
      Navigator.pop(context);
      erroralert(
        context,
        "Error",
        data[1].toString(),
      );
    } else if (data[0]["status"] == false) {
      Navigator.pop(context);

      erroralert(
        context,
        "Error",
        data[0]["message"],
      );
    } else {
      Navigator.pop(context);
      susalert(context, "Sent", "Request has been sent");
    }
  }

  Future<void> acceptCamp(BuildContext context, String id) async {
    final req = {"id": id, "status": "3"};

    List data =
        await apiReq.postApi(jsonEncode(req), path: "/api/update-invite");
    if (data[0] == false) {
      Navigator.pop(context);
      erroralert(
        context,
        "Error",
        data[1].toString(),
      );
    } else if (data[0]["status"] == false) {
      Navigator.pop(context);

      erroralert(
        context,
        "Error",
        data[0]["message"],
      );
    } else {
      Navigator.pop(context);
      susalert(context, "Sent", "Successfully accepted the request.");
    }
  }

  Future<void> rejectCamp(
      BuildContext context, String id, String reason) async {
    final req = {"id": id, "status": "5", "rejectReason": reason};

    List data =
        await apiReq.postApi(jsonEncode(req), path: "/api/update-invite");

    if (data[0] == false) {
      Navigator.pop(context);
      erroralert(
        context,
        "Error",
        data[1].toString(),
      );
    } else if (data[0]["status"] == false) {
      Navigator.pop(context);

      erroralert(
        context,
        "Error",
        data[0]["message"],
      );
    } else {
      Navigator.pop(context);
      susalert(context, "Sent", "Successfully rejected the request.");
    }
  }

  List acceptRequest = [];
  Future<void> setAcceptRequest(BuildContext context, String champId) async {
    final req = {
      "search": {
        "status": "1",
        "campaign": champId,
        "toUser": await userState.getUserId(),
      }
    };

    List data =
        await apiReq.postApi2(jsonEncode(req), path: "/api/search-invite");

    acceptRequest = data[0]["data"];

    notifyListeners();
  }

  List draftRequest = [];
  Future<void> setDraftRequest(BuildContext context, String champId) async {
    final req = {
      "search": {
        "status": "1",
        "campaign": champId,
        "toUser": await userState.getUserId(),
      }
    };

    List data =
        await apiReq.postApi2(jsonEncode(req), path: "/api/search-draft");

    draftRequest = data[0]["data"];

    notifyListeners();
  }

  Future<void> acceptDraft(BuildContext context, String id) async {
    final req = {"id": id, "status": "3"};

    List data =
        await apiReq.postApi(jsonEncode(req), path: "/api/update-draft");
    if (data[0] == false) {
      Navigator.pop(context);
      erroralert(
        context,
        "Error",
        data[1].toString(),
      );
    } else if (data[0]["status"] == false) {
      Navigator.pop(context);

      erroralert(
        context,
        "Error",
        data[0]["message"],
      );
    } else {
      Navigator.pop(context);
      susalert(context, "Sent", "Successfully accepted the draft request.");
    }
  }

  Future<void> rejectDraft(
      BuildContext context, String id, String reason) async {
    final req = {"id": id, "status": "5", "rejectReason": reason};

    List data =
        await apiReq.postApi(jsonEncode(req), path: "/api/update-draft");
    if (data[0] == false) {
      Navigator.pop(context);
      erroralert(
        context,
        "Error",
        data[1].toString(),
      );
    } else if (data[0]["status"] == false) {
      Navigator.pop(context);

      erroralert(
        context,
        "Error",
        data[0]["message"],
      );
    } else {
      Navigator.pop(context);
      susalert(context, "Sent", "Successfully rejected the draft request.");
    }
  }
}
