// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../services/apirequest.dart';
import '../../../state/compaign/createcampaignstate.dart';
import '../../../utils/alerts.dart';
import '../../../utils/utilthemes.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/componets.dart';
import '../../navigation/bottomnavbar.dart';
import '../../navigation/drawer.dart';
import 'createcampone.dart';

class CreateCampaignsPage extends HookConsumerWidget {
  const CreateCampaignsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());
    final createCmpSW = ref.watch(createCampState);
    CusApiReq apiReq = CusApiReq();

    void init() async {
      final req3 = {};
      List category = await apiReq.postApi(jsonEncode(req3),
          path: "/api/get-campaign-type");

      if (category[0]["status"]) {
        createCmpSW.setCategory(category[0]["data"]);
      } else {
        erroralert(context, "error", "No Record Fount");
      }
    }

    useEffect(() {
      init();
      return null;
    }, []);

    final width = MediaQuery.of(context).size.width;
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
                          color: shadowC, blurRadius: 5, offset: Offset(0, 6))
                    ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Select one Below",
                              textScaleFactor: 1,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: blackC),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 80,
                              child: CusBtn(
                                  btnColor: secondaryC,
                                  btnText: "Next",
                                  textSize: 20,
                                  btnFunction: () {
                                    if (createCmpSW.categoryId == null) {
                                      erroralert(context, "Error",
                                          "Please Select any one option");
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CreateCampOne(),
                                        ),
                                      );
                                    }
                                  }),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (createCmpSW.categoryList.isEmpty) ...[
                          const Center(child: CircularProgressIndicator())
                        ] else ...[
                          GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 10,
                              mainAxisExtent: 240,
                            ),
                            itemCount: createCmpSW.categoryList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  createCmpSW.setCategoryId(index);
                                  createCmpSW.setCampType(index);
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: whiteC,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      (createCmpSW.categoryList[index]["id"] ==
                                              createCmpSW.categoryId)
                                          ? BoxShadow(
                                              color: blackC.withOpacity(0.3),
                                              blurRadius: 10)
                                          : BoxShadow(
                                              color: blackC.withOpacity(0.15),
                                              blurRadius: 5)
                                    ],
                                    border: (createCmpSW.categoryList[index]
                                                ["id"] ==
                                            createCmpSW.categoryId)
                                        ? Border.all(
                                            color: secondaryC, width: 2.5)
                                        : Border.all(
                                            color: Colors.transparent,
                                            width: 0),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  top: Radius.circular(8)),
                                          child: SizedBox(
                                            height: 100,
                                            child: CachedNetworkImage(
                                              imageUrl: createCmpSW
                                                      .categoryList[index]
                                                  ["categoryPicUrl"],
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      Column(
                                                children: [
                                                  CircularProgressIndicator(
                                                      value: downloadProgress
                                                          .progress),
                                                ],
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                Icons.error,
                                                color: Colors.blue,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              createCmpSW.categoryList[index]
                                                      ["categoryName"]
                                                  .toString(),
                                              textScaleFactor: 1,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: blackC),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              createCmpSW.categoryList[index]
                                                      ["categoryDescription"]
                                                  .toString(),
                                              textScaleFactor: 1,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: blackC),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}
