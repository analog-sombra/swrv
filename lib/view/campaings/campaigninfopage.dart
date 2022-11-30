// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/services/apirequest.dart';
import 'package:swrv/utils/alerts.dart';
import 'package:swrv/utils/utilthemes.dart';

import '../../widgets/componets.dart';

class ChampignInfopage extends HookConsumerWidget {
  final String id;
  const ChampignInfopage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    CusApiReq apiReq = CusApiReq();
    final champdata = useState([]);
    ValueNotifier<bool> isLoading = useState(true);

    void init() async {
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
                                    child: Image.asset(
                                      "assets/images/user.png",
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
