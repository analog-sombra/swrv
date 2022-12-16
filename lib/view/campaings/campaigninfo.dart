// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:swrv/database/database.dart';
import 'package:swrv/database/models/favoritechamp.dart';
import 'package:swrv/services/apirequest.dart';
import 'package:swrv/state/userstate.dart';
import 'package:swrv/utils/alerts.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/widgets/alerts.dart';
import 'package:swrv/widgets/buttons.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../state/compaign/campaigninfostate.dart';
import '../../widgets/champaleart.dart';
import '../../widgets/componets.dart';
import '../navigation/bottomnavbar.dart';
import '../navigation/drawer.dart';

enum AcceptReq { none, panding, accepted, rejected }

class ChampignInfo extends HookConsumerWidget {
  final String id;
  const ChampignInfo({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());
    final width = MediaQuery.of(context).size.width;

    CusApiReq apiReq = CusApiReq();
    final userStateW = ref.watch(userState);
    final champdata = useState([]);
    ValueNotifier<bool> isLoading = useState(true);
    ValueNotifier<List> favList = useState([]);

    ValueNotifier<bool> isFav = useState(false);

    ValueNotifier<bool> isBrand = useState(false);
    ValueNotifier<AcceptReq> acceptReq = useState<AcceptReq>(AcceptReq.none);

    ValueNotifier<List> acceptRequestData = useState<List>([]);

    void init() async {
      //fav section
      isBrand.value = await userStateW.isBrand();
      final getfav =
          await isarDB.favoriteChamps.filter().champidEqualTo(id).findAll();
      favList.value = getfav;

      if (favList.value.isEmpty) {
        isFav.value = false;
      } else {
        isFav.value = true;
      }

      //campaigns info section
      final req = {
        "id": id,
      };

      List data =
          await apiReq.postApi(jsonEncode(req), path: "/api/campaign-search");
      if (data[0]["status"] == true) {
        champdata.value = data[0]["data"];
      } else {
        erroralert(context, "Error", "No Data found");
      }

      //accept section
      final req2 = {
        "search": {
          "campaign": id,
          "influencer": await userStateW.getUserId(),
          "fromUser": await userStateW.getUserId(),
        }
      };

      List reqdata =
          await apiReq.postApi2(jsonEncode(req2), path: "/api/search-invite");
      acceptRequestData.value = reqdata[0]["data"];

      if (reqdata[0]["status"] == false) {
        acceptReq.value = AcceptReq.none;
      } else if (acceptRequestData.value.first["status"]["code"] == "1") {
        acceptReq.value = AcceptReq.panding;
      } else if (acceptRequestData.value.first["status"]["code"] == "3") {
        acceptReq.value = AcceptReq.accepted;
      } else if (acceptRequestData.value.first["status"]["code"] == "5") {
        acceptReq.value = AcceptReq.rejected;
      }

      isLoading.value = false;
    }

    useEffect(() {
      init();
      return null;
    }, []);

    return Scaffold(
      backgroundColor: backgroundC,
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: CusDrawer(
        scaffoldKey: scaffoldKey,
      ),
      bottomNavigationBar: BotttomBar(
        scaffoldKey: scaffoldKey,
      ),
      body: SafeArea(
        child: isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Header(),
                    Container(
                      width: width,
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: whiteC,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                              color: shadowC,
                              blurRadius: 5,
                              offset: Offset(0, 6))
                        ],
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: CachedNetworkImage(
                                      imageUrl: champdata.value[0]["brand"]
                                          ["logo"],
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        "assets/images/user.png",
                                        fit: BoxFit.cover,
                                      ),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      champdata.value[0]["campaignName"],
                                      textAlign: TextAlign.left,
                                      textScaleFactor: 1,
                                      style: const TextStyle(
                                          color: blackC,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  isFav.value = !isFav.value;
                                  if (favList.value.isEmpty) {
                                    final newFav = FavoriteChamp()
                                      ..champid = id
                                      ..name =
                                          champdata.value[0]["campaignName"]
                                      ..img =
                                          champdata.value[0]["brand"]["logo"];
                                    await isarDB.writeTxn(() async {
                                      await isarDB.favoriteChamps.put(newFav);
                                    });
                                  } else {
                                    await isarDB.writeTxn(() async {
                                      await isarDB.favoriteChamps
                                          .delete(favList.value[0].id);
                                    });
                                  }
                                },
                                child: Icon(
                                  Icons.favorite,
                                  size: 30,
                                  color: isFav.value ? Colors.red : Colors.grey,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Center(
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Mentions",
                                        textScaleFactor: 1,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: blackC),
                                      ),
                                      for (int i = 0;
                                          i <
                                              champdata.value[0]["mentions"]
                                                  .toString()
                                                  .split(",")
                                                  .length;
                                          i++) ...[
                                        Container(
                                          width: 120,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            color: backgroundC,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            "@${champdata.value[0]["mentions"].toString().split(",")[i]}",
                                            textScaleFactor: 1,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: secondaryC),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Hashtags",
                                        textScaleFactor: 1,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: blackC),
                                      ),
                                      for (int i = 0;
                                          i <
                                              champdata.value[0]["hashtags"]
                                                  .toString()
                                                  .split(",")
                                                  .length;
                                          i++) ...[
                                        Container(
                                          width: 120,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            color: backgroundC,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            "#${champdata.value[0]["hashtags"].toString().split(",")[i]}",
                                            textScaleFactor: 1,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: secondaryC),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Rating",
                              textScaleFactor: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: secondaryC),
                            ),
                          ),
                          Row(
                            children: [
                              for (int i = 0;
                                  i <
                                      double.parse(champdata.value[0]
                                              ["minEligibleRating"])
                                          .toInt();
                                  i++) ...[
                                const Icon(
                                  Icons.star,
                                  color: primaryC,
                                  size: 25,
                                ),
                              ],
                              for (int i = 0;
                                  i <
                                      5 -
                                          double.parse(champdata.value[0]
                                                  ["minEligibleRating"])
                                              .toInt();
                                  i++) ...[
                                const Icon(
                                  Icons.star,
                                  color: backgroundC,
                                  size: 25,
                                ),
                              ],
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Brand info",
                              textScaleFactor: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: secondaryC),
                            ),
                          ),
                          Text(
                            champdata.value[0]["brand"]["name"],
                            textScaleFactor: 1,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: blackC),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Campaign info",
                              textScaleFactor: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: secondaryC),
                            ),
                          ),
                          Text(
                            champdata.value[0]["campaignInfo"],
                            textScaleFactor: 1,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: blackC),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Mooodboard",
                              textScaleFactor: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: secondaryC),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                for (int i = 0;
                                    i < champdata.value[0]["moodBoards"].length;
                                    i++) ...[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: CachedNetworkImage(
                                          imageUrl: champdata.value[0]
                                              ["moodBoards"][i]["url"],
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                            child: CircularProgressIndicator(
                                              value: downloadProgress.progress,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Attachmen",
                              textScaleFactor: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: secondaryC),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => PdfViewer(
                                        link: champdata.value[0]["attachments"]
                                            [0]["url"],
                                      )),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: backgroundC,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: const Icon(
                                      Icons.attachment,
                                      color: blackC,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text(
                                    "Attachment",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        color: blackC,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Platforms",
                              textScaleFactor: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: secondaryC),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                for (int i = 0;
                                    i < champdata.value[0]["platforms"].length;
                                    i++) ...[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: CachedNetworkImage(
                                          imageUrl: champdata.value[0]
                                                  ["platforms"][i]
                                              ["platformLogoUrl"],
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                                color: backgroundC,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: const [
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.done, color: Colors.green),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Do",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      color: blackC,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              for (int i = 0;
                                  i <
                                      champdata.value[0]["donts"]
                                          .toString()
                                          .split(",")
                                          .length;
                                  i++) ...[
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(Icons.done,
                                          color: Colors.green),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: blackC.withOpacity(0.15),
                                                blurRadius: 10),
                                          ],
                                          color: whiteC,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              champdata.value[0]["dos"]
                                                  .toString()
                                                  .split(",")[i],
                                              textScaleFactor: 1,
                                              style: const TextStyle(
                                                color: blackC,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ]
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: backgroundC,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: const [
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.close, color: Colors.red),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Don't",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      color: blackC,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              for (int i = 0;
                                  i <
                                      champdata.value[0]["donts"]
                                          .toString()
                                          .split(",")
                                          .length;
                                  i++) ...[
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(Icons.done,
                                          color: Colors.green),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: blackC.withOpacity(0.15),
                                                blurRadius: 10),
                                          ],
                                          color: whiteC,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              champdata.value[0]["donts"]
                                                  .toString()
                                                  .split(",")[i],
                                              textScaleFactor: 1,
                                              style: const TextStyle(
                                                color: blackC,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ]
                            ],
                          ),
                        ],
                      ),
                    ),
                    CampaignBudget(
                      currencyCode: champdata.value[0]["currency"]["code"],
                      totalBudget: champdata.value[0]["totalBudget"],
                      costperpost: champdata.value[0]["costPerPost"],
                    ),
                    CampaignTarget(
                      location: champdata.value[0]["brand"]["city"]["state"]
                          ["country"]["name"],
                      maxReach: champdata.value[0]["maxReach"],
                      minReach: champdata.value[0]["minReach"],
                      startDate: champdata.value[0]["startAt"],
                      endDate: champdata.value[0]["endAt"],
                    ),
                    if (isBrand.value) ...[
                      PandingAcceptRequest(
                        id: id,
                      ),
                      PandingDraftRequest(
                        id: id,
                      ),
                    ] else ...[
                      if (acceptReq.value == AcceptReq.none) ...[
                        InviteToCampaign(
                          id: id,
                          toUserId: champdata.value[0]["brandUserId"],
                        ),
                      ] else if (acceptReq.value == AcceptReq.accepted) ...[
                        CampaignsTabs(
                          id: id,
                        ),
                        UserDrafts(
                          id: id,
                        ),
                      ] else if (acceptReq.value == AcceptReq.panding) ...[
                        const InviteToCampaignPanding(),
                      ] else if (acceptReq.value == AcceptReq.rejected) ...[
                        InviteToCampaignRejected(
                          id: id,
                          toUserId: champdata.value[0]["brandUserId"],
                          reason: acceptRequestData.value.first["status"]
                              ["message"],
                        )
                      ],
                    ],
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class CampaignBudget extends HookWidget {
  const CampaignBudget({
    super.key,
    required this.currencyCode,
    required this.costperpost,
    required this.totalBudget,
  });
  final String currencyCode;
  final String costperpost;
  final String totalBudget;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: whiteC,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: shadowC, blurRadius: 5, offset: Offset(0, 6))
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: const [
              FaIcon(
                FontAwesomeIcons.coins,
                color: secondaryC,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Budget",
                textScaleFactor: 1,
                style: TextStyle(
                  color: blackC,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Divider(
            color: blackC,
          ),
          Row(
            children: [
              const Text(
                "Cost per post",
                textScaleFactor: 1,
                style: TextStyle(
                  color: blackC,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Text(
                "$costperpost $currencyCode",
                textScaleFactor: 1,
                style: const TextStyle(
                  color: blackC,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Text(
                "Total Budget",
                textScaleFactor: 1,
                style: TextStyle(
                  color: blackC,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Text(
                "$totalBudget $currencyCode",
                textScaleFactor: 1,
                style: const TextStyle(
                  color: blackC,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Text(
                "Remaining",
                textScaleFactor: 1,
                style: TextStyle(
                  color: blackC,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Text(
                "1400 $currencyCode",
                textScaleFactor: 1,
                style: const TextStyle(
                  color: blackC,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CampaignTarget extends HookWidget {
  const CampaignTarget({
    super.key,
    required this.location,
    required this.minReach,
    required this.maxReach,
    required this.startDate,
    required this.endDate,
  });
  final String location;
  final String minReach;
  final String maxReach;
  final String startDate;
  final String endDate;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: whiteC,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: shadowC, blurRadius: 5, offset: Offset(0, 6))
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: const [
              FaIcon(
                FontAwesomeIcons.coins,
                color: secondaryC,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Target",
                textScaleFactor: 1,
                style: TextStyle(
                  color: blackC,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Divider(
            color: blackC,
          ),
          Row(
            children: [
              const Text(
                "Audience location",
                textScaleFactor: 1,
                style: TextStyle(
                  color: secondaryC,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Text(
                location,
                textScaleFactor: 1,
                style: const TextStyle(
                  color: secondaryC,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Text(
                "Min reach",
                textScaleFactor: 1,
                style: TextStyle(
                  color: blackC,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Text(
                minReach,
                textScaleFactor: 1,
                style: const TextStyle(
                  color: blackC,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Text(
                "Max reach",
                textScaleFactor: 1,
                style: TextStyle(
                  color: blackC,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Text(
                maxReach,
                textScaleFactor: 1,
                style: const TextStyle(
                  color: blackC,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Text(
                "Start date",
                textScaleFactor: 1,
                style: TextStyle(
                  color: blackC,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Text(
                "${startDate.split("-")[2].split(" ")[0]}-${startDate.split("-")[1]}-${startDate.split("-")[0]}",
                textScaleFactor: 1,
                style: const TextStyle(
                  color: blackC,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Text(
                "End date",
                textScaleFactor: 1,
                style: TextStyle(
                  color: blackC,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Text(
                "${endDate.split("-")[2].split(" ")[0]}-${endDate.split("-")[1]}-${endDate.split("-")[0]}",
                textScaleFactor: 1,
                style: const TextStyle(
                  color: blackC,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InviteToCampaign extends HookConsumerWidget {
  const InviteToCampaign({
    super.key,
    required this.id,
    required this.toUserId,
  });
  final String id;
  final String toUserId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    TextEditingController msg = useTextEditingController();
    return Container(
      width: width,
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: secondaryC,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: shadowC, blurRadius: 5, offset: Offset(0, 6))
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          const Text(
            "Would you like to participate in this campaign?",
            textScaleFactor: 1,
            style: TextStyle(
              color: whiteC,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: SizedBox(
              width: 200,
              child: CusBtn(
                btnColor: primaryC,
                btnText: "Apply",
                textSize: 18,
                btnFunction: () {
                  connectAlert(context, ref, msg, id, toUserId);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class InviteToCampaignPanding extends HookConsumerWidget {
  const InviteToCampaignPanding({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: secondaryC,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: shadowC, blurRadius: 5, offset: Offset(0, 6))
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: const [
          Text(
            "Your request progress.. ",
            textScaleFactor: 1,
            style: TextStyle(
              color: whiteC,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class InviteToCampaignRejected extends HookConsumerWidget {
  const InviteToCampaignRejected({
    super.key,
    required this.id,
    required this.toUserId,
    required this.reason,
  });
  final String id;
  final String toUserId;
  final String reason;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    TextEditingController msg = useTextEditingController();
    return Container(
      width: width,
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: secondaryC,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: shadowC, blurRadius: 5, offset: Offset(0, 6))
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Your request has been rejected..",
            textScaleFactor: 1,
            style: TextStyle(
              color: whiteC,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Reason",
            textScaleFactor: 1,
            style: TextStyle(
              color: whiteC,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Divider(
            color: whiteC,
          ),
          Text(
            reason,
            textScaleFactor: 1,
            style: const TextStyle(
              color: whiteC,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: SizedBox(
              width: 200,
              child: CusBtn(
                btnColor: primaryC,
                btnText: "Apply Again",
                textSize: 18,
                btnFunction: () {
                  connectAlert(context, ref, msg, id, toUserId);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PdfViewer extends HookConsumerWidget {
  final String link;
  const PdfViewer({Key? key, required this.link}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<bool> isLoading = useState(true);
    PdfViewerController controller = PdfViewerController();
    useEffect(() {
      Timer(const Duration(seconds: 10), () {
        isLoading.value = false;
      });
      return null;
    });
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundC,
      appBar: AppBar(
        backgroundColor: secondaryC,
        title: const Text(
          "SWRV PDF Viwer",
          textScaleFactor: 1,
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: SizedBox(
                  width: width,
                  height: height,
                  child: (isLoading.value)
                      ? const Center(child: CircularProgressIndicator())
                      : SfPdfViewer.network(
                          controller: controller,
                          link,
                          pageLayoutMode: PdfPageLayoutMode.single,
                        ),
                ),
              ),
              if (!isLoading.value) ...[
                Positioned(
                  left: 0,
                  bottom: height * 0.025,
                  child: SizedBox(
                    width: width,
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryC),
                              onPressed: () {
                                controller.previousPage();
                              },
                              child: const Text("Previous")),
                        )),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryC),
                                onPressed: () {
                                  controller.nextPage();
                                },
                                child: const Text("Next")),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class CampaignsTabs extends HookConsumerWidget {
  const CampaignsTabs({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chamInfoState = ref.watch(campaignInfoState);

    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      width: width,
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: whiteC,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: shadowC,
            blurRadius: 5,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < chamInfoState.tabName.length; i++) ...[
                  InkWell(
                    onTap: () {
                      chamInfoState.setCurTab(i);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                          )
                        ],
                        color: (chamInfoState.curTab == i)
                            ? secondaryC
                            : backgroundC,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        chamInfoState.tabName[i],
                        textScaleFactor: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: (chamInfoState.curTab == i) ? whiteC : blackC,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (chamInfoState.curTab == 0) ...[
            CreateDraft(
              id: id,
            )
          ],
          if (chamInfoState.curTab == 1) ...[],
          if (chamInfoState.curTab == 2) ...[const CampPayments()],
        ],
      ),
    );
  }
}

class CampPayments extends HookWidget {
  const CampPayments({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey =
        useMemoized(() => GlobalKey<FormState>());
    final width = MediaQuery.of(context).size.width;
    TextEditingController amount = useTextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          width: width,
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: whiteC,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: blackC.withOpacity(0.2),
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: const [
                  Text(
                    "Budget",
                    textScaleFactor: 1,
                    style: TextStyle(
                      color: blackC,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "6400 USD",
                    textScaleFactor: 1,
                    style: TextStyle(
                      color: blackC,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Divider(
                color: blackC,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: const [
                  Text(
                    "Received",
                    textScaleFactor: 1,
                    style: TextStyle(
                      color: blackC,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "1200 USD",
                    textScaleFactor: 1,
                    style: TextStyle(
                      color: blackC,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: const [
                  Text(
                    "Panding",
                    textScaleFactor: 1,
                    style: TextStyle(
                      color: blackC,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "5200 USD",
                    textScaleFactor: 1,
                    style: TextStyle(
                      color: blackC,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          width: width,
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: whiteC,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: blackC.withOpacity(0.2),
                blurRadius: 5,
              ),
            ],
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Payment request",
                  textScaleFactor: 1,
                  style: TextStyle(
                    color: secondaryC,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      "Enter Amount",
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: blackC,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TextFormField(
                          controller: amount,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {},
                          validator: (value) {
                            if (value == null || value.isEmpty || value == "") {
                              return 'Enter the amount description.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: backgroundC,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CusBtn(
                  btnColor: const Color(0xff01FFF4),
                  btnText: "Request",
                  textSize: 18,
                  btnFunction: () {
                    if (formKey.currentState!.validate()) {
                      comingalert(context);
                    }
                  },
                  textColor: blackC,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CreateDraft extends HookConsumerWidget {
  const CreateDraft({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey =
        useMemoized(() => GlobalKey<FormState>());
    final width = MediaQuery.of(context).size.width;
    final campaignInfoStateW = ref.watch(campaignInfoState);
    CusApiReq apiReq = CusApiReq();
    TextEditingController discription = useTextEditingController();
    TextEditingController publishDate = useTextEditingController();

    void init() async {
      final req1 = {};
      List platforms =
          await apiReq.postApi(jsonEncode(req1), path: "/api/getplatform");

      if (platforms[0]["status"]) {
        campaignInfoStateW.setPlatforms(platforms[0]["data"]);
      } else {
        erroralert(context, "error", "No Record Fount");
      }
    }

    useEffect(() {
      init();
      return null;
    }, []);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      width: width,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: whiteC,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: blackC.withOpacity(0.2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Create campaign draft",
              textScaleFactor: 1,
              style: TextStyle(
                color: secondaryC,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (!campaignInfoStateW.createDraft) ...[
              const Text(
                "Would you like to Create campaign draft ?",
                textScaleFactor: 1,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: secondaryC,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CusBtn(
                btnColor: const Color(0xff01FFF4),
                btnText: "Create",
                textSize: 18,
                btnFunction: () {
                  campaignInfoStateW.setCreateDraft(true);
                },
                textColor: blackC,
              )
            ] else ...[
              if (campaignInfoStateW.platforms.isEmpty ||
                  campaignInfoStateW.selectedPlatfomrs.isEmpty) ...[
                const CircularProgressIndicator()
              ] else ...[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0;
                          i < campaignInfoStateW.platforms.length;
                          i++) ...[
                        InkWell(
                          onTap: () {
                            campaignInfoStateW.togglePlatfroms(i);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 5),
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: whiteC,
                              shape: BoxShape.circle,
                              border: campaignInfoStateW.selectedPlatfomrs[i]
                                  ? Border.all(color: Colors.blue, width: 2)
                                  : Border.all(
                                      color: Colors.transparent, width: 2),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: SizedBox(
                                width: 35,
                                height: 35,
                                child: CachedNetworkImage(
                                  imageUrl: campaignInfoStateW.platforms[i]
                                      ["platformLogoUrl"],
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    campaignInfoStateW.addAttachment(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: backgroundC,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.attachment,
                          color: blackC,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          (campaignInfoStateW.attachments == null)
                              ? "Attachments"
                              : campaignInfoStateW.attachments!.path
                                  .split("/")
                                  .last,
                          textScaleFactor: 1,
                          style: const TextStyle(
                            color: blackC,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {
                              campaignInfoStateW.addAttachment(context);
                            },
                            child: const Icon(
                              Icons.add,
                              color: blackC,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty || value == "") {
                          return "Please enter the publish date";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        campaignInfoStateW.setPublishDate(value);
                      },
                      readOnly: true,
                      controller: publishDate,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.calendar_month,
                          color: Colors.black.withOpacity(0.8),
                        ),
                        filled: true,
                        fillColor: const Color(0xfff3f4f6),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      onTap: () async {
                        var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(DateTime.now().year + 2,
                              DateTime.now().month, DateTime.now().day),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: Colors.pink,
                                  onSurface: Colors.pink,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.pink,
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        publishDate.text =
                            DateFormat("dd-MM-yyyy").format(date!);
                        campaignInfoStateW.setPublishDate(
                            DateFormat("dd-MM-yyyy").format(date));
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TextFormField(
                      minLines: 4,
                      maxLines: 6,
                      controller: discription,
                      onChanged: (value) {
                        campaignInfoStateW.setDescription(value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty || value == "") {
                          return 'Please enter the some description.';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xfff3f4f6),
                        hintText: "description...",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CusBtn(
                  btnColor: secondaryC,
                  btnText: "Submit",
                  textSize: 18,
                  btnFunction: () async {
                    if (formKey.currentState!.validate()) {
                      await campaignInfoStateW.createcmapDraft(context, id);
                    }
                  },
                ),
              ],
            ]
          ],
        ),
      ),
    );
  }
}

class PandingAcceptRequest extends HookConsumerWidget {
  const PandingAcceptRequest({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campaignInfoStateW = ref.watch(campaignInfoState);
    TextEditingController rejectInvite = useTextEditingController();

    void init() async {
      await campaignInfoStateW.setAcceptRequest(context, id);
    }

    useEffect(() {
      init();
      return null;
    }, []);
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      width: width,
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: whiteC,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: shadowC,
            blurRadius: 5,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Requested Invites",
            textScaleFactor: 1,
            style: TextStyle(
              color: blackC,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (campaignInfoStateW.acceptRequest.isEmpty) ...[
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                "No Request..",
                textScaleFactor: 1,
                style: TextStyle(
                  color: blackC,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (int i = 0;
                    i < campaignInfoStateW.acceptRequest.length;
                    i++) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: whiteC,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: SizedBox(
                                width: 60,
                                height: 60,
                                child: CachedNetworkImage(
                                  imageUrl: campaignInfoStateW.acceptRequest[i]
                                      ["influencer"]["pic"],
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    "assets/images/user.png",
                                    fit: BoxFit.cover,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  campaignInfoStateW.acceptRequest[i]
                                      ["influencer"]["name"],
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1,
                                  style: const TextStyle(
                                      color: blackC,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  campaignInfoStateW.acceptRequest[i]
                                      ["influencer"]["email"],
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1,
                                  style: const TextStyle(
                                      color: blackC,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(),
                        const Text(
                          "Message",
                          textAlign: TextAlign.left,
                          textScaleFactor: 1,
                          style: TextStyle(
                              color: blackC,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          campaignInfoStateW.acceptRequest[i]["status"]
                              ["message"],
                          textAlign: TextAlign.left,
                          textScaleFactor: 1,
                          style: const TextStyle(
                              color: blackC,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        const Divider(),
                        Row(
                          children: [
                            OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                side:
                                    const BorderSide(width: 2.0, color: greenC),
                              ),
                              onPressed: () {
                                champAccecptInvite(
                                  context,
                                  ref,
                                  campaignInfoStateW.acceptRequest[i]["id"],
                                  id,
                                );
                              },
                              icon: const Icon(
                                Icons.thumb_up,
                                color: greenC,
                              ),
                              label: const Text(
                                "Accept",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    color: greenC,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(width: 2.0, color: redC),
                              ),
                              onPressed: () {
                                champRejectInvite(
                                  context,
                                  ref,
                                  rejectInvite,
                                  campaignInfoStateW.acceptRequest[i]["id"],
                                  id,
                                );
                              },
                              icon: const Icon(Icons.thumb_down, color: redC),
                              label: const Text(
                                "Reject",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    color: redC,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PandingDraftRequest extends HookConsumerWidget {
  const PandingDraftRequest({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campaignInfoStateW = ref.watch(campaignInfoState);
    TextEditingController rejectDraft = useTextEditingController();

    void init() async {
      await campaignInfoStateW.setDraftRequest(context, id);
    }

    useEffect(() {
      init();
      return null;
    }, []);
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      width: width,
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: whiteC,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: shadowC,
            blurRadius: 5,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Requested Drafts",
            textScaleFactor: 1,
            style: TextStyle(
              color: blackC,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (campaignInfoStateW.draftRequest.isEmpty) ...[
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                "No request for drafts..",
                textScaleFactor: 1,
                style: TextStyle(
                  color: blackC,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (int i = 0;
                    i < campaignInfoStateW.draftRequest.length;
                    i++) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: whiteC,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: SizedBox(
                                width: 60,
                                height: 60,
                                child: CachedNetworkImage(
                                  imageUrl: campaignInfoStateW.draftRequest[i]
                                      ["influencer"]["pic"],
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    "assets/images/user.png",
                                    fit: BoxFit.cover,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  campaignInfoStateW.draftRequest[i]
                                      ["influencer"]["name"],
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1,
                                  style: const TextStyle(
                                      color: blackC,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  campaignInfoStateW.draftRequest[i]
                                      ["influencer"]["email"],
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1,
                                  style: const TextStyle(
                                      color: blackC,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(),
                        const Text(
                          "Message",
                          textAlign: TextAlign.left,
                          textScaleFactor: 1,
                          style: TextStyle(
                              color: blackC,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          campaignInfoStateW.draftRequest[i]["description"],
                          textAlign: TextAlign.left,
                          textScaleFactor: 1,
                          style: const TextStyle(
                              color: blackC,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Publish Date : ${campaignInfoStateW.draftRequest[i]["publishAt"].toString().split("-")[2].split(" ")[0]}-${campaignInfoStateW.draftRequest[i]["publishAt"].toString().split("-")[1]}-${campaignInfoStateW.draftRequest[i]["publishAt"].toString().split("-")[0]}",
                          textAlign: TextAlign.left,
                          textScaleFactor: 1,
                          style: const TextStyle(
                              color: blackC,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        const Divider(),
                        Row(
                          children: [
                            OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                side:
                                    const BorderSide(width: 2.0, color: greenC),
                              ),
                              onPressed: () {
                                champAccecptDraft(
                                  context,
                                  ref,
                                  campaignInfoStateW.draftRequest[i]["id"],
                                  id,
                                );
                              },
                              icon: const Icon(
                                Icons.thumb_up,
                                color: greenC,
                              ),
                              label: const Text(
                                "Accept",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    color: greenC,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(width: 2.0, color: redC),
                              ),
                              onPressed: () {
                                champRejectDraft(
                                  context,
                                  ref,
                                  rejectDraft,
                                  campaignInfoStateW.draftRequest[i]["id"],
                                  id,
                                );
                              },
                              icon: const Icon(Icons.thumb_down, color: redC),
                              label: const Text(
                                "Reject",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    color: redC,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserDrafts extends HookConsumerWidget {
  const UserDrafts({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<List> userDrafts = useState([]);
    CusApiReq apiReq = CusApiReq();
    UserState userState = UserState();

    void init() async {
      final req1 = {
        "search": {
          "fromUser": await userState.getUserId(),
          "influencer": await userState.getUserId(),
          "campaign": id
        }
      };
      List drafts =
          await apiReq.postApi2(jsonEncode(req1), path: "/api/search-draft");
      if (drafts[0]["status"]) {
        userDrafts.value = drafts[0]["data"];
      }
    }

    useEffect(() {
      init();
      return null;
    }, []);
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      width: width,
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: whiteC,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: shadowC,
            blurRadius: 5,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Requested Drafts",
            textScaleFactor: 1,
            style: TextStyle(
              color: blackC,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (userDrafts.value.isEmpty) ...[
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                "No drafts created..",
                textScaleFactor: 1,
                style: TextStyle(
                  color: blackC,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (int i = 0; i < userDrafts.value.length; i++) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: whiteC,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: SizedBox(
                                width: 60,
                                height: 60,
                                child: CachedNetworkImage(
                                  imageUrl: userDrafts.value[i]["influencer"]
                                      ["pic"],
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    "assets/images/user.png",
                                    fit: BoxFit.cover,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  userDrafts.value[i]["influencer"]["name"],
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1,
                                  style: const TextStyle(
                                      color: blackC,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  userDrafts.value[i]["influencer"]["email"],
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1,
                                  style: const TextStyle(
                                      color: blackC,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(),
                        const Text(
                          "Message",
                          textAlign: TextAlign.left,
                          textScaleFactor: 1,
                          style: TextStyle(
                              color: blackC,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          userDrafts.value[i]["description"],
                          textAlign: TextAlign.left,
                          textScaleFactor: 1,
                          style: const TextStyle(
                              color: blackC,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Publish Date : ${userDrafts.value[i]["publishAt"].toString().split("-")[2].split(" ")[0]}-${userDrafts.value[i]["publishAt"].toString().split("-")[1]}-${userDrafts.value[i]["publishAt"].toString().split("-")[0]}",
                          textAlign: TextAlign.left,
                          textScaleFactor: 1,
                          style: const TextStyle(
                              color: blackC,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        const Divider(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: blackC.withOpacity(0.2), blurRadius: 5)
                            ],
                            borderRadius: BorderRadius.circular(5),
                            color: (userDrafts.value[i]["status"]["name"] ==
                                    "PANDING")
                                ? primaryC
                                : (userDrafts.value[i]["status"]["name"] ==
                                        "REJECTED")
                                    ? redC
                                    : greenC,
                          ),
                          child: Text(
                            userDrafts.value[i]["status"]["name"],
                            textAlign: TextAlign.left,
                            textScaleFactor: 1,
                            style: const TextStyle(
                              color: whiteC,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
