// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:swrv/database/database.dart';
import 'package:swrv/database/models/favoritechamp.dart';
import 'package:swrv/services/apirequest.dart';
import 'package:swrv/utils/alerts.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/widgets/alerts.dart';
import 'package:swrv/widgets/cuswidgets.dart';

import '../../widgets/componets.dart';
import '../navigation/bottomnavbar.dart';
import '../navigation/drawer.dart';

class ChampignInfopage extends HookConsumerWidget {
  final String id;
  const ChampignInfopage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());
    final width = MediaQuery.of(context).size.width;

    CusApiReq apiReq = CusApiReq();
    final champdata = useState([]);
    ValueNotifier<bool> isLoading = useState(true);
    ValueNotifier<List> favList = useState([]);

    ValueNotifier<bool> isFav = useState(false);

    TextEditingController res = useTextEditingController();
    TextEditingController msg = useTextEditingController();

    void init() async {
      final getfav =
          await isarDB.favoriteChamps.filter().champidEqualTo(id).findAll();
      favList.value = getfav;

      if (favList.value.isEmpty) {
        isFav.value = false;
      } else {
        isFav.value = true;
      }

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
                                          const Icon(
                                        Icons.error,
                                        color: Colors.blue,
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
                                    // Text(
                                    //   "Category: ${createCmpSW.categoryValue}",
                                    //   textAlign: TextAlign.left,
                                    //   textScaleFactor: 1,
                                    //   style: TextStyle(
                                    //       color: blackC.withOpacity(0.65),
                                    //       fontSize: 13,
                                    //       fontWeight: FontWeight.w400),
                                    // ),
                                    // Text(
                                    //   website.value,
                                    //   textAlign: TextAlign.left,
                                    //   textScaleFactor: 1,
                                    //   style: TextStyle(
                                    //       color: blackC.withOpacity(0.55),
                                    //       fontSize: 14,
                                    //       fontWeight: FontWeight.w400),
                                    // ),
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
                              "Champign info",
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
                          // const Padding(
                          //   padding: EdgeInsets.symmetric(vertical: 10),
                          //   child: Text(
                          //     "Mooodboard",
                          //     textScaleFactor: 1,
                          //     textAlign: TextAlign.left,
                          //     style: TextStyle(
                          //         fontSize: 18,
                          //         fontWeight: FontWeight.w500,
                          //         color: secondaryC),
                          //   ),
                          // ),
                          // SingleChildScrollView(
                          //   scrollDirection: Axis.horizontal,
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     mainAxisSize: MainAxisSize.max,
                          //     children: [
                          //       for (int i = 0;
                          //           i < createCmpSW.images.length;
                          //           i++) ...[
                          //         Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: 8),
                          //           child: ClipRRect(
                          //             borderRadius: BorderRadius.circular(6),
                          //             child: SizedBox(
                          //               width: 60,
                          //               height: 60,
                          //               child: Image.file(
                          //                 createCmpSW.images[i],
                          //                 fit: BoxFit.cover,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ],
                          //   ),
                          // ),
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
                    Container(
                        width: width,
                        margin: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: secondaryC,
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
                                    connectAlert(context, res, msg);
                                  },
                                ),
                              ),
                            )
                          ],
                        )),
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
