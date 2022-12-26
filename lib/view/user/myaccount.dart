// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/services/apirequest.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/widgets/buttons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../state/user/myaccoutstate.dart';
import '../../state/userstate.dart';
import '../../utils/alerts.dart';
import '../../widgets/alerts.dart';
import '../../widgets/componets.dart';
import '../campaings/createchamp/selectecategory.dart';
import '../home/home.dart';
import '../navigation/bottomnavbar.dart';
import '../navigation/drawer.dart';

class MyAccount extends HookConsumerWidget {
  final String id;
  final bool isSendMsg;
  const MyAccount({super.key, required this.id, required this.isSendMsg});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());
    final width = MediaQuery.of(context).size.width;
    ValueNotifier<bool> isLoading = useState(true);

    ValueNotifier<bool> isBrand = useState(false);
    // final userStateW = ref.watch(userState);
    final myAccountStateW = ref.watch(myAccountState);
    CusApiReq cusApiReq = CusApiReq();

    ValueNotifier<String?> username = useState(null);
    ValueNotifier<String?> bio = useState(null);
    ValueNotifier<String?> rating = useState(null);
    ValueNotifier<String?> avatar = useState(null);
    ValueNotifier<String?> personalHistory = useState(null);
    ValueNotifier<String?> careerHistory = useState(null);
    ValueNotifier<String?> externalLinks = useState(null);

    TextEditingController msg = useTextEditingController();

    void init() async {
      final req = {"id": id};
      final data =
          await cusApiReq.postApi(jsonEncode(req), path: "/api/getuser");
      if (data[0]["status"] == false) {
        erroralert(context, "User not found", "This user not exist");
      } else {
        final userdata = data[0]["data"];
        isBrand.value = userdata[0]["role"]["code"] == "50" ? true : false;
        username.value = userdata[0]["userName"];
        bio.value = userdata[0]["bio"];
        rating.value = userdata[0]["rating"];
        avatar.value = userdata[0]["pic"];
        personalHistory.value = userdata[0]["personalHistory"];
        careerHistory.value = userdata[0]["careerHistory"];
        externalLinks.value = userdata[0]["externalLinks"];
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
      body: isLoading.value
          ? const Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Header(),
                    const SizedBox(
                      height: 20,
                    ),
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
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: avatar.value!,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  "assets/images/car.jpg",
                                  fit: BoxFit.cover,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      username.value!,
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: blackC,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        for (int i = 0;
                                            i <
                                                double.parse(rating.value!)
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
                                                    double.parse(rating.value!)
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
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    // width: 200,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: backgroundC,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: shadowC,
                                            blurRadius: 5,
                                            offset: Offset(0, 6))
                                      ],
                                    ),
                                    child: IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: const [
                                                Text(
                                                  "2 00 5887",
                                                  textScaleFactor: 1,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: blackC),
                                                ),
                                                Text(
                                                  "Reach",
                                                  textScaleFactor: 1,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: blackC),
                                                ),
                                              ],
                                            ),
                                          ),
                                          VerticalDivider(
                                            color: blackC.withOpacity(0.55),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: const [
                                                Text(
                                                  "1 34 9887",
                                                  textScaleFactor: 1,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: blackC),
                                                ),
                                                Text(
                                                  "impression",
                                                  textScaleFactor: 1,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: blackC),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              "Bio",
                              textScaleFactor: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: blackC),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              bio.value!,
                              textScaleFactor: 1,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: blackC),
                            ),
                          ),
                          if (isSendMsg) ...[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: CusBtn(
                                btnColor: secondaryC,
                                btnText: "Sent Message",
                                textSize: 18,
                                btnFunction: () {
                                  sendMsgAlert(context, ref, msg, id);
                                },
                                elevation: 1,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (isBrand.value) ...[
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
                          children: [
                            const Text(
                              "Would yo like to collaorate ?",
                              textScaleFactor: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: blackC),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CusBtn(
                              btnColor: primaryC,
                              btnText: "Create campaign",
                              textSize: 18,
                              btnFunction: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateCampaignsPage(),
                                  ),
                                );
                              },
                              elevation: 1,
                            ),
                            CusBtn(
                              btnColor: const Color(0xFF10BCE2),
                              btnText: "Invite to a campaign",
                              textSize: 18,
                              btnFunction: () {
                                comingalert(context);
                                // ref.read(pageIndex.state).state = 32;
                              },
                              elevation: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                    ProfileTabs(
                      info: bio.value!,
                      careerHistory: careerHistory.value!,
                      personalHistory: personalHistory.value!,
                      externalLinks: externalLinks.value!,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (myAccountStateW.curTab == 0) ...[
                      const PostInfo(),
                      const SizedBox(
                        height: 10,
                      ),
                      const AverageResult(),
                    ],
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class ProfileTabs extends HookConsumerWidget {
  const ProfileTabs({
    super.key,
    required this.info,
    required this.careerHistory,
    required this.externalLinks,
    required this.personalHistory,
  });
  final String personalHistory;
  final String careerHistory;
  final String info;
  final String externalLinks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myAccountStateW = ref.watch(myAccountState);

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
                for (int i = 0; i < myAccountStateW.tabName.length; i++) ...[
                  InkWell(
                    onTap: () {
                      myAccountStateW.setCurTab(i);
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
                        color: (myAccountStateW.curTab == i)
                            ? secondaryC
                            : backgroundC,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        myAccountStateW.tabName[i],
                        textScaleFactor: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color:
                              (myAccountStateW.curTab == i) ? whiteC : blackC,
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
          if (myAccountStateW.curTab == 1) ...[
            PersnalInfo(
              info: info,
              careerHistory: careerHistory,
              personalHistory: personalHistory,
              externalLinks: externalLinks,
            )
          ],
          if (myAccountStateW.curTab == 2) ...[const PastAssociations()],
          if (myAccountStateW.curTab == 3) ...[const AccountReviews()],
        ],
      ),
    );
  }
}

class PostInfo extends HookWidget {
  const PostInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    ValueNotifier<List> data = useState([
      {"name": "Posts", "num": "345"},
      {"name": "Followers", "num": "654"},
      {"name": "Post Engagement", "num": "643"},
      {"name": "Post Reach", "num": "456"},
      {"name": "Post View", "num": "335"},
    ]);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
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
          const SizedBox(
            height: 10,
          ),
          for (int i = 0; i < data.value.length; i++) ...[
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: blackC.withOpacity(0.35),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    data.value[i]["name"],
                    textScaleFactor: 1,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: secondaryC,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        data.value[i]["num"],
                        textScaleFactor: 1,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: secondaryC,
                        ),
                      ),
                      const Text(
                        "30% of stands",
                        textScaleFactor: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF7CFF01),
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
    );
  }
}

class AverageResult extends HookWidget {
  const AverageResult({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    ValueNotifier<List> data = useState([
      {"name": "Posts", "num": "345"},
      {"name": "Followers", "num": "654"},
      {"name": "Post Engagement", "num": "643"},
      {"name": "Post Reach", "num": "456"},
      {"name": "Post View", "num": "335"},
    ]);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
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
          const Text(
            "Average result",
            textScaleFactor: 1,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: secondaryC),
          ),
          const SizedBox(
            height: 10,
          ),
          for (int i = 0; i < data.value.length; i++) ...[
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: blackC.withOpacity(0.35),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    data.value[i]["name"],
                    textScaleFactor: 1,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: secondaryC,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    data.value[i]["num"],
                    textScaleFactor: 1,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: secondaryC,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class PersnalInfo extends HookConsumerWidget {
  const PersnalInfo({
    super.key,
    required this.info,
    required this.careerHistory,
    required this.externalLinks,
    required this.personalHistory,
  });
  final String personalHistory;
  final String careerHistory;
  final String info;
  final String externalLinks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final userStateW = ref.watch(userState);
    final name = useState("");
    void init() async {
      name.value = await userStateW.getUserName();
    }

    useEffect(() {
      init();
      return null;
    }, []);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      width: width,
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
          Text(
            name.value,
            textScaleFactor: 1,
            textAlign: TextAlign.left,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: secondaryC),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            info,
            textScaleFactor: 1,
            textAlign: TextAlign.left,
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.w400, color: blackC),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Personal life",
            textScaleFactor: 1,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: secondaryC),
          ),
          const SizedBox(
            height: 10,
          ),
          if (personalHistory == "") ...[
            const Text(
              "User not completed this part",
              textScaleFactor: 1,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, color: blackC),
            ),
          ],
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Career",
            textScaleFactor: 1,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: secondaryC),
          ),
          const SizedBox(
            height: 10,
          ),
          if (careerHistory == "") ...[
            const Text(
              "User not completed this part",
              textScaleFactor: 1,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, color: blackC),
            ),
          ],
          Text(
            careerHistory,
            textScaleFactor: 1,
            textAlign: TextAlign.left,
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.w400, color: blackC),
          ),
          const SizedBox(
            height: 20,
          ),
          if (externalLinks != "") ...[
            const Text(
              "External links",
              textScaleFactor: 1,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500, color: secondaryC),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                try {
                  if (!await launchUrl(Uri.parse(externalLinks))) {
                    erroralert(
                        context, "Error", 'Could not open $externalLinks');
                  }
                } catch (e) {
                  erroralert(context, "Error", 'Could not opne $externalLinks');
                }
              },
              child: const Text(
                "Official website",
                textScaleFactor: 1,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.blue),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ],
      ),
    );
  }
}

class AccountReviews extends HookConsumerWidget {
  const AccountReviews({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: shadowC, blurRadius: 5, offset: Offset(0, 6))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: const [
                FaIcon(CupertinoIcons.star_fill, color: primaryC),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Reviews",
                  textAlign: TextAlign.left,
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: blackC, fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: const [
                TopInfluencerBox(
                  name: "sona",
                  avatar: "assets/images/post1.jpg",
                  score: "2000",
                  rating: 4,
                  reach: "200000",
                  imporession: "300000",
                  dob: "Dec 12, 2003",
                ),
                TopInfluencerBox(
                  name: "Sonali",
                  avatar: "assets/images/post2.jpg",
                  score: "2000",
                  rating: 4,
                  reach: "200000",
                  imporession: "300000",
                  dob: "Dec 12, 2003",
                ),
                TopInfluencerBox(
                  name: "Jaya",
                  avatar: "assets/images/post3.jpg",
                  score: "2000",
                  rating: 4,
                  reach: "200000",
                  imporession: "300000",
                  dob: "Dec 12, 2003",
                ),
                TopInfluencerBox(
                  name: "Moni",
                  avatar: "assets/images/post6.jpg",
                  score: "2000",
                  rating: 4,
                  reach: "200000",
                  imporession: "300000",
                  dob: "Dec 12, 2003",
                ),
                TopInfluencerBox(
                  name: "Amina",
                  avatar: "assets/images/post5.jpg",
                  score: "2000",
                  rating: 4,
                  reach: "200000",
                  imporession: "300000",
                  dob: "Dec 12, 2003",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PastAssociations extends HookConsumerWidget {
  const PastAssociations({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: shadowC, blurRadius: 5, offset: Offset(0, 6))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: const [
                FaIcon(CupertinoIcons.star_fill, color: primaryC),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Past association",
                  textAlign: TextAlign.left,
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: blackC, fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: const [
                TopInfluencerBox(
                  name: "sona",
                  avatar: "assets/images/post1.jpg",
                  score: "2000",
                  rating: 4,
                  reach: "200000",
                  imporession: "300000",
                  dob: "Dec 12, 2003",
                ),
                TopInfluencerBox(
                  name: "Sonali",
                  avatar: "assets/images/post2.jpg",
                  score: "2000",
                  rating: 4,
                  reach: "200000",
                  imporession: "300000",
                  dob: "Dec 12, 2003",
                ),
                TopInfluencerBox(
                  name: "Jaya",
                  avatar: "assets/images/post3.jpg",
                  score: "2000",
                  rating: 4,
                  reach: "200000",
                  imporession: "300000",
                  dob: "Dec 12, 2003",
                ),
                TopInfluencerBox(
                  name: "Moni",
                  avatar: "assets/images/post6.jpg",
                  score: "2000",
                  rating: 4,
                  reach: "200000",
                  imporession: "300000",
                  dob: "Dec 12, 2003",
                ),
                TopInfluencerBox(
                  name: "Amina",
                  avatar: "assets/images/post5.jpg",
                  score: "2000",
                  rating: 4,
                  reach: "200000",
                  imporession: "300000",
                  dob: "Dec 12, 2003",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
