// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/state/userstate.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/view/home/home.dart';

import '../../../services/apirequest.dart';
import '../../../state/user/influenceredit.dart';
import '../../../utils/alerts.dart';
import '../../../widgets/componets.dart';
import '../../navigation/bottomnavbar.dart';
import '../../navigation/drawer.dart';

class UserEditThree extends HookConsumerWidget {
  const UserEditThree({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());

    CusApiReq apiReq = CusApiReq();
    final userStateW = ref.watch(userState);
    final userProfileEditW = ref.watch(userProfileEditState);

    void init() async {
      final req = {};
      List data =
          await apiReq.postApi(jsonEncode(req), path: "/api/getplatform");
      userProfileEditW.setPlatforms(data[0]["data"]);

      if (data[0]["status"] == false) {
        erroralert(
            context, "Error", "Oops something went wrong please try again");
      }
    }

    useEffect(() {
      init();
      return;
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Header(
                isShowUser: false,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 10),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Edit Profile",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        "Channels",
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int i = 0;
                              i < userProfileEditW.platforms.length;
                              i++) ...[
                            InkWell(
                              onTap: () async {
                                userProfileEditW.setSelectPlatform(i);

                                await userProfileEditW.loadSavedPlatform(
                                    userProfileEditW.platforms[i]["id"]);
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        (userProfileEditW.selectedPlatform == i)
                                            ? Colors.pink
                                            : Colors.transparent,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 3)
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                width: 50,
                                height: 50,
                                padding: const EdgeInsets.all(10),
                                child: Center(
                                  child: CachedNetworkImage(
                                    imageUrl: userProfileEditW.platforms[i]
                                        ["platformLogoUrl"],
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                        backgroundColor: Colors.pink,
                      ),
                      onPressed: () {
                        if (userProfileEditW.cont.isEmpty) {
                          if (userProfileEditW.selectedPlatform != null) {
                            userProfileEditW.addControler();
                            userProfileEditW.addIsCompleted(false);
                            userProfileEditW.addImgUrl(
                                userProfileEditW.platforms[userProfileEditW
                                    .selectedPlatform!]["platformLogoUrl"]);
                          } else {
                            erroralert(context, "Error",
                                "Please select any platform first");
                          }
                        } else if (userProfileEditW.cont.last.text == "") {
                          erroralert(context, "Error",
                              "Please fill the last field first");
                        } else {
                          if (userProfileEditW.selectedPlatform != null) {
                            userProfileEditW.addControler();

                            userProfileEditW.addIsCompleted(false);
                            userProfileEditW.addImgUrl(
                                userProfileEditW.platforms[userProfileEditW
                                    .selectedPlatform!]["platformLogoUrl"]);
                          } else {
                            erroralert(context, "Error",
                                "Please select any platform first");
                          }
                        }
                      },
                      child: const Text(
                        "Add new Channel",
                        textScaleFactor: 1,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    for (int i = 0;
                        i < userProfileEditW.savedPlatform.length;
                        i++) ...[
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.transparent,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 5)
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              width: 40,
                              height: 40,
                              padding: const EdgeInsets.all(10),
                              child: Center(
                                child: Image.network(
                                  userProfileEditW.savedPlatform[i]["platform"]
                                      ["logo"],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                userProfileEditW.savedPlatform[i]["name"],
                                textScaleFactor: 1,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: blackC.withOpacity(0.85),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    for (int i = 0; i < userProfileEditW.cont.length; i++) ...[
                      CusFiels(
                        cont: userProfileEditW.cont[i],
                        index: i,
                        imgUrl: userProfileEditW.imgUrls[i],
                      )
                    ],
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                              backgroundColor: backgroundC,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Back",
                              textAlign: TextAlign.center,
                              textScaleFactor: 1,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                              backgroundColor: secondaryC,
                            ),
                            onPressed: () async {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                                (route) => false,
                              );
                            },
                            child: const Text(
                              "Save",
                              textAlign: TextAlign.center,
                              textScaleFactor: 1,
                              style: TextStyle(
                                  color: whiteC,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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

class CusFiels extends HookConsumerWidget {
  final TextEditingController cont;
  final int index;
  final String imgUrl;
  const CusFiels({
    Key? key,
    required this.cont,
    required this.index,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileEditStateW = ref.watch(userProfileEditState);

    return StatefulBuilder(builder: (context, setStat) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.transparent,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Image.network(
                  imgUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: TextField(
                  controller: cont,
                  readOnly: userProfileEditStateW.isCompleted[index],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xfff3f4f6),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Enter your username",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.65),
                    ),
                  ),
                ),
              ),
            ),
            if (!userProfileEditStateW.isCompleted[index]) ...[
              Container(
                margin: const EdgeInsets.only(left: 10),
                width: 80,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.pink,
                  ),
                  onPressed: () async {
                    await userProfileEditStateW.addHandal(
                        context,
                        userProfileEditStateW.platforms[index]["id"],
                        userProfileEditStateW.cont[index].text);

                    userProfileEditStateW.setIsComplted(index, true);
                    userProfileEditStateW.clearAfterAdding();
                  },
                  child: const Text(
                    "Done",
                    textScaleFactor: 1,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ],
        ),
      );
    });
  }
}
