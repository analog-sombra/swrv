import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/view/campaings/campaigninfo.dart';

import '../../services/apirequest.dart';
import '../../state/userstate.dart';
import '../../widgets/componets.dart';
import '../navigation/bottomnavbar.dart';
import '../navigation/drawer.dart';

class DraftsPage extends HookConsumerWidget {
  const DraftsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());
    final width = MediaQuery.of(context).size.width;

    ValueNotifier<List> darfData = useState([
      {
        "img": "assets/images/1.jpg",
        "name": "sohan",
        "msg":
            "There’s just one more thing you need to do to get started with us."
      },
      {
        "img": "assets/images/2.jpg",
        "name": "Rahul",
        "msg":
            "Thank you for scheduling an appointment with our office. You are confirmed for an appointment with"
      },
      {
        "img": "assets/images/3.jpg",
        "name": "Mohan",
        "msg":
            "Thank you for providing the information we requested. We will follow up with you shortly regarding the next steps."
      },
      {
        "img": "assets/images/4.jpg",
        "name": "Soniya",
        "msg":
            "We’re super excited to announce that we’re opening our doors on DATE at TIME. Come join us!"
      },
      {
        "img": "assets/images/5.jpg",
        "name": "Sonali",
        "msg":
            "Thank you for your business! We pride ourselves on great service and it’s your feedback that makes that possible!"
      },
      {
        "img": "assets/images/6.jpg",
        "name": "Sakhi",
        "msg":
            "We just wanted to remind you that we’re waiting for the DOCUMENT you agreed to send us so we can complete the TRANSACTION we discussed."
      },
      {
        "img": "assets/images/7.jpg",
        "name": "Ansh ikha",
        "msg": "We look forward to seeing you for your appointment today."
      },
    ]);

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Header(),
              SizedBox(
                height: 20,
              ),
              // Container(
              //   width: width,
              //   margin: const EdgeInsets.all(15),
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              //   decoration: BoxDecoration(
              //     color: whiteC,
              //     borderRadius: BorderRadius.circular(16),
              //     boxShadow: const [
              //       BoxShadow(
              //           color: shadowC, blurRadius: 5, offset: Offset(0, 6))
              //     ],
              //   ),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       ClipRRect(
              //         borderRadius: BorderRadius.circular(10),
              //         child: TextField(
              //           onTap: () {
              //             comingalert(context);
              //           },
              //           readOnly: true,
              //           decoration: InputDecoration(
              //             prefixIcon: const Icon(Icons.search),
              //             suffixIcon: const Icon(Icons.sort),
              //             filled: true,
              //             fillColor: backgroundC,
              //             border: InputBorder.none,
              //             focusedBorder: InputBorder.none,
              //             enabledBorder: InputBorder.none,
              //             errorBorder: InputBorder.none,
              //             disabledBorder: InputBorder.none,
              //             hintText: "Search",
              //             hintStyle: TextStyle(
              //               fontSize: 20,
              //               color: blackC.withOpacity(0.4),
              //             ),
              //           ),
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 20,
              //       ),
              //       for (int i = 0; i < darfData.value.length; i++) ...[
              //         GestureDetector(
              //           onTap: () {
              //             comingalert(context);
              //           },
              //           child: Container(
              //             decoration: BoxDecoration(
              //               border: Border(
              //                   bottom: BorderSide(
              //                       color: blackC.withOpacity(0.25))),
              //             ),
              //             padding: const EdgeInsets.symmetric(vertical: 8),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               mainAxisSize: MainAxisSize.max,
              //               children: [
              //                 ClipRRect(
              //                   borderRadius: BorderRadius.circular(10),
              //                   child: SizedBox(
              //                     width: 40,
              //                     height: 40,
              //                     child: Image.asset(
              //                       darfData.value[i]["img"],
              //                       fit: BoxFit.cover,
              //                     ),
              //                   ),
              //                 ),
              //                 const SizedBox(
              //                   width: 15,
              //                 ),
              //                 Expanded(
              //                   child: Column(
              //                     mainAxisSize: MainAxisSize.min,
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     mainAxisAlignment: MainAxisAlignment.start,
              //                     children: [
              //                       Text(
              //                         darfData.value[i]["name"],
              //                         textScaleFactor: 1,
              //                         textAlign: TextAlign.start,
              //                         style: const TextStyle(
              //                           fontSize: 16,
              //                           fontWeight: FontWeight.w500,
              //                           color: blackC,
              //                         ),
              //                       ),
              //                       Text(
              //                         darfData.value[i]["msg"],
              //                         textScaleFactor: 1,
              //                         textAlign: TextAlign.start,
              //                         style: TextStyle(
              //                           fontSize: 12,
              //                           fontWeight: FontWeight.w400,
              //                           color: blackC.withOpacity(0.55),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 const Icon(Icons.circle,
              //                     color: Colors.blue, size: 15),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ],
              //     ],
              //   ),
              // ),
              UserCamp(),
              SizedBox(
                height: 80,
              )
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
            "Your Drafts",
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
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => PdfViewer(
                                      link: userDrafts.value[i]["attach01"],
                                    )),
                              ),
                            );
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
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
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
