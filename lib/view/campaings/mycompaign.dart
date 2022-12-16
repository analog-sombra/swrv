import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/widgets/componets.dart';

import '../../services/apirequest.dart';
import '../../state/userstate.dart';
import '../navigation/bottomnavbar.dart';
import '../navigation/drawer.dart';
import 'campaigninfo.dart';

class MyCampaings extends HookConsumerWidget {
  const MyCampaings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());
    final width = MediaQuery.of(context).size.width;
    final userStateW = ref.watch(userState);
    ValueNotifier<bool> isFinished = useState(false);
    ValueNotifier<bool> isLoading = useState(true);
    ValueNotifier<bool> isBrand = useState(false);
    CusApiReq apiReq = CusApiReq();

    ValueNotifier<List> champ = useState([]);

    void init() async {
      final userid = await userStateW.getUserId();
      final req = {"id": userid};
      dynamic data =
          await apiReq.postApi(jsonEncode(req), path: "/api/get-my-campaigns");
      champ.value = data[0]["data"]["campaigns"];

      isBrand.value = await userStateW.isBrand();

      isLoading.value = false;
    }

    useEffect(() {
      init();
      return null;
    }, []);

    List platformUrls(List plt) {
      List data = [];

      for (int j = 0; j < plt.length; j++) {
        data.add(plt[j]["platformLogoUrl"]);
      }
      return data;
    }

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
      body: isLoading.value
          ? const Padding(
              padding: EdgeInsets.all(
                20,
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Header(),
                    const Padding(
                      padding: EdgeInsets.only(left: 25, top: 20),
                      child: Text(
                        "My campaign",
                        textScaleFactor: 1,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: blackC),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25, top: 10),
                      child: Text(
                        "Here you can manage all the\ncampaigns that you are participating in.",
                        textScaleFactor: 1,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: blackC),
                      ),
                    ),
                    if (isBrand.value) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                  backgroundColor: isFinished.value
                                      ? whiteC
                                      : const Color(0xff01fff4),
                                ),
                                onPressed: () {
                                  isFinished.value = false;
                                },
                                child: Text(
                                  "Active Campaign",
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      color: isFinished.value
                                          ? blackC.withOpacity(0.65)
                                          : blackC,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: isFinished.value
                                      ? const Color(0xff01fff4)
                                      : whiteC,
                                ),
                                onPressed: () {
                                  isFinished.value = true;
                                },
                                child: Text(
                                  "Finished campaign",
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      color: isFinished.value
                                          ? blackC
                                          : blackC.withOpacity(0.65),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (champ.value.isEmpty) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 20),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                "You have no campaign right now",
                                textScaleFactor: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: blackC),
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        Container(
                          width: width,
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                  color: shadowC,
                                  blurRadius: 5,
                                  offset: Offset(0, 6))
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    for (int i = 0;
                                        i < champ.value.length;
                                        i++) ...[
                                      HomeCard(
                                        imgUrl: champ.value[i]["brand"]["logo"],
                                        title: champ.value[i]["name"],
                                        btnColor: const Color(0xfffbc98e),
                                        btnText: "View",
                                        btnFunction: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ChampignInfo(
                                                id: champ.value[i]["id"],
                                              ),
                                            ),
                                          );
                                        },
                                        website:
                                            "Min Eligible Rating : ${champ.value[i]["minEligibleRating"]}",
                                        category:
                                            "Category: ${champ.value[i]["type"]["name"]}",
                                        isHeart: false,
                                        amount:
                                            "${champ.value[i]["totalBudget"]}",
                                        currency:
                                            "${champ.value[i]["currency"]["code"]}",
                                        platforms: platformUrls(
                                            champ.value[i]["platforms"]),
                                      ),
                                    ],
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ] else ...[
                      const UserCamp(),
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

class UserCamp extends HookConsumerWidget {
  const UserCamp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<List> userDrafts = useState([]);
    CusApiReq apiReq = CusApiReq();
    UserState userState = UserState();

    void init() async {
      final req1 = {
        "search": {
          "fromUser": await userState.getUserId(),
          "influencer": await userState.getUserId()
        }
      };
      log(req1.toString());
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
            "Your Campaigns",
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
