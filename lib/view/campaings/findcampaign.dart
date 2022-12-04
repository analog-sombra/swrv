// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/view/brand/brandinfo.dart';
import 'package:swrv/view/campaings/campaigninfopage.dart';
import 'package:swrv/view/user/userinfo.dart';
import 'package:swrv/widgets/componets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../services/apirequest.dart';
import '../../state/brand/findbrandstate.dart';
import '../../state/compaign/findcompaignstate.dart';
import '../../state/influencer/findinfluencerstate.dart';
import '../../state/userstate.dart';
import '../../utils/alerts.dart';
import '../navigation/bottomnavbar.dart';
import '../navigation/drawer.dart';

class FindCampaings extends HookConsumerWidget {
  const FindCampaings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());
    ValueNotifier<String?> filtervalue = useState(null);
    ValueNotifier<List<String>> filterlist =
        useState(["filter 1", "filter 2", "flter 3"]);

    final findCampStateW = ref.watch(findCampState);
    final findInfStateW = ref.watch(findInfState);

    ValueNotifier<bool> isBrand = useState(false);
    final userStateW = ref.watch(userState);

    void init() async {
      isBrand.value = await userStateW.isBrand();
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
                  "Find campaign",
                  textScaleFactor: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w800, color: blackC),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 25, top: 10),
                child: Text(
                  "Here you can manage all the campaign that you\nare participating in.",
                  textScaleFactor: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400, color: blackC),
                ),
              ),
              if (isBrand.value == false) ...[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                            backgroundColor: findCampStateW.isBrand
                                ? whiteC
                                : const Color(0xff01fff4),
                          ),
                          onPressed: () {
                            findCampStateW.setIsBrand(false);
                          },
                          child: Text(
                            "Campaign",
                            textAlign: TextAlign.center,
                            textScaleFactor: 1,
                            style: TextStyle(
                                color: findCampStateW.isBrand
                                    ? blackC.withOpacity(0.65)
                                    : blackC,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
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
                            backgroundColor: findCampStateW.isBrand
                                ? const Color(0xff01fff4)
                                : whiteC,
                          ),
                          onPressed: () {
                            findCampStateW.setIsBrand(true);
                          },
                          child: Text(
                            "Brand",
                            textAlign: TextAlign.center,
                            textScaleFactor: 1,
                            style: TextStyle(
                                color: findCampStateW.isBrand
                                    ? blackC
                                    : blackC.withOpacity(0.65),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (isBrand.value) ...[
                if (findInfStateW.isAdvance) ...[
                  const AdvanceInfSearch(),
                ] else ...[
                  const TextInfSeach(),
                ],
                const UserList()
                //is user is brand
              ] else ...[
                if (findCampStateW.isBrand) ...[
                  const TextBrandSearch(),
                  const BrandList(),
                ] else ...[
                  if (findCampStateW.isAdvance) ...[
                    const AdvanceCampaignSearch(),
                  ] else ...[
                    const TextCampaignSeach(),
                  ],
                  const CampaingList(),
                ]
              ],
              const SizedBox(
                height: 30,
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

class TextCampaignSeach extends HookConsumerWidget {
  const TextCampaignSeach({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    TextEditingController textSearch = useTextEditingController();
    final findCampStateW = ref.watch(findCampState);

    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: whiteC,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: shadowC, blurRadius: 5, offset: Offset(0, 6))
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: textSearch,
                decoration: const InputDecoration(
                  isDense: true,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  filled: true,
                  fillColor: Color(0xfff3f4f6),
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
          Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  findCampStateW.setIsAdvance(true);
                  // comingalert(context);
                },
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: secondaryC,
                ),
                label: const Text(
                  "Advance filter",
                  textScaleFactor: 1,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: secondaryC,
                    fontSize: 16,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  findCampStateW.clear();
                },
                child: const Icon(
                  Icons.delete,
                  color: secondaryC,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryC,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  final data =
                      await findCampStateW.textSearch(context, textSearch.text);
                  if (data[0] != false) {
                    findCampStateW.setIsSearch(true);
                    findCampStateW.setSearchData(jsonDecode(data[0]));
                  }
                },
                child: const Text(
                  "Search",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: whiteC,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TextInfSeach extends HookConsumerWidget {
  const TextInfSeach({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    TextEditingController textSearch = useTextEditingController();
    // final findCampStateW = ref.watch(findCampState);
    final findInfStateW = ref.watch(findInfState);

    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: whiteC,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: shadowC, blurRadius: 5, offset: Offset(0, 6))
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: textSearch,
                decoration: const InputDecoration(
                  isDense: true,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  filled: true,
                  fillColor: Color(0xfff3f4f6),
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
          Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  findInfStateW.setIsAdvance(true);
                  // comingalert(context);
                },
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: secondaryC,
                ),
                label: const Text(
                  "Advance filter",
                  textScaleFactor: 1,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: secondaryC,
                    fontSize: 16,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  findInfStateW.clear();
                },
                child: const Icon(
                  Icons.delete,
                  color: secondaryC,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryC,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  final data =
                      await findInfStateW.textSearch(context, textSearch.text);
                  if (data[0] != false) {
                    findInfStateW.setIsSearch(true);
                    findInfStateW.setSearchData(jsonDecode(data[0]));
                  }
                },
                child: const Text(
                  "Search",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: whiteC,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TextBrandSearch extends HookConsumerWidget {
  const TextBrandSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    TextEditingController textSearch = useTextEditingController();
    final findBrandStateW = ref.watch(findBrandState);

    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: whiteC,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: shadowC, blurRadius: 5, offset: Offset(0, 6))
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: textSearch,
                decoration: const InputDecoration(
                  isDense: true,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  filled: true,
                  fillColor: Color(0xfff3f4f6),
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
          Row(
            children: [
              const Spacer(),
              InkWell(
                onTap: () {
                  findBrandStateW.clear();
                },
                child: const Icon(
                  Icons.delete,
                  color: secondaryC,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryC,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  final data = await findBrandStateW.textSearch(
                      context, textSearch.text);
                  if (data[0] != false) {
                    findBrandStateW.setIsSearch(true);
                    findBrandStateW.setSearchData(jsonDecode(data[0]));
                  }
                },
                child: const Text(
                  "Search",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: whiteC,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AdvanceCampaignSearch extends HookConsumerWidget {
  const AdvanceCampaignSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    CusApiReq apiReq = CusApiReq();
    final findCampStateW = ref.watch(findCampState);
    void init() async {
      final req1 = {};
      List platforms =
          await apiReq.postApi(jsonEncode(req1), path: "/api/getplatform");

      final req3 = {};
      List category =
          await apiReq.postApi(jsonEncode(req3), path: "api/getcategory");

      final req4 = {};
      List city = await apiReq.postApi(jsonEncode(req4), path: "api/getcity");

      if (platforms[0]["status"] &&
          category[0]["status"] &&
          city[0]["status"]) {
        findCampStateW.setPlatforms(platforms[0]["data"]);

        findCampStateW.setCmp(category[0]["data"]);
        findCampStateW.setCity(city[0]["data"]);
      } else {
        erroralert(context, "error", "No Record Fount");
      }
    }

    useEffect(() {
      init();
      return null;
    }, []);
    return Container(
      width: width,
      margin: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: whiteC,
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
          // Row(
          //   children: [
          //     const Spacer(),
          //     ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: backgroundC,
          //         elevation: 0,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //       ),
          //       onPressed: () {
          //         comingalert(context);
          //       },
          //       child: const Text(
          //         "Save filter",
          //         textAlign: TextAlign.center,
          //         textScaleFactor: 1,
          //         style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.w500,
          //           color: blackC,
          //         ),
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     DropdownButtonHideUnderline(
          //       child: DropdownButton2<String>(
          //         hint: const Text(
          //           "Saved filter",
          //           textScaleFactor: 1,
          //           style: TextStyle(
          //               fontSize: 16,
          //               color: blackC,
          //               fontWeight: FontWeight.w500),
          //         ),
          //         buttonDecoration: BoxDecoration(
          //           boxShadow: const [],
          //           borderRadius: BorderRadius.circular(10),
          //           color: backgroundC,
          //         ),
          //         itemPadding: const EdgeInsets.only(left: 5, right: 5),
          //         buttonPadding: const EdgeInsets.only(left: 5, right: 5),
          //         style: const TextStyle(
          //             fontSize: 18, fontWeight: FontWeight.w400),
          //         value: filtervalue.value,
          //         icon: const Icon(
          //           Icons.arrow_drop_down,
          //           color: Colors.black,
          //         ),
          //         items: filterlist.value.map((String item) {
          //           return DropdownMenuItem(
          //               value: item,
          //               child: Text(
          //                 item,
          //                 textScaleFactor: 1,
          //                 style: const TextStyle(
          //                     color: Colors.black, fontSize: 18),
          //               ));
          //         }).toList(),
          //         onChanged: (newval) {
          //           filtervalue.value = newval;
          //         },
          //         buttonElevation: 2,
          //         itemHeight: 40,
          //         dropdownMaxHeight: 200,
          //         dropdownPadding: null,
          //         isDense: false,
          //         dropdownElevation: 8,
          //         scrollbarRadius: const Radius.circular(40),
          //         scrollbarThickness: 6,
          //         scrollbarAlwaysShow: true,
          //         offset: const Offset(0, 0),
          //         dropdownDecoration: BoxDecoration(
          //           color: whiteC,
          //           borderRadius: BorderRadius.circular(5),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Select",
              textScaleFactor: 1,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w500, color: secondaryC),
            ),
          ),
          if (findCampStateW.cmpList.isEmpty) ...[
            const CircularProgressIndicator(),
          ] else ...[
            SizedBox(
              width: width,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  hint: const Text(
                    "Category",
                    textScaleFactor: 1,
                    style: TextStyle(
                        fontSize: 16,
                        color: blackC,
                        fontWeight: FontWeight.w400),
                  ),
                  buttonDecoration: BoxDecoration(
                    boxShadow: const [],
                    borderRadius: BorderRadius.circular(10),
                    color: backgroundC,
                  ),
                  itemPadding: const EdgeInsets.only(left: 20, right: 5),
                  buttonPadding: const EdgeInsets.only(left: 20, right: 5),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400),
                  value: findCampStateW.cmpValue,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  items: [
                    for (int i = 0; i < findCampStateW.cmpList.length; i++) ...[
                      DropdownMenuItem(
                        onTap: () {
                          findCampStateW.setCmpId(i);
                        },
                        value: findCampStateW.cmpList[i]["categoryName"],
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: blackC.withOpacity(0.25),
                              ),
                            ),
                          ),
                          width: 220,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "[${findCampStateW.cmpList[i]["categoryCode"]}] ${findCampStateW.cmpList[i]["categoryName"]}",
                            textScaleFactor: 1,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ]
                  ],
                  onChanged: (newval) {
                    findCampStateW.setCmpValue(newval!);
                  },
                  buttonElevation: 2,
                  itemHeight: 40,
                  dropdownMaxHeight: 250,
                  dropdownPadding: null,
                  isDense: false,
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(40),
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                  offset: const Offset(0, 0),
                  dropdownDecoration: BoxDecoration(
                      color: const Color(0xfffbfbfb),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const []),
                ),
              ),
            ),
          ],
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Channels",
              textScaleFactor: 1,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w500, color: secondaryC),
            ),
          ),
          if (findCampStateW.platforms.isEmpty ||
              findCampStateW.selectedPlatfomrs.isEmpty) ...[
            const CircularProgressIndicator()
          ] else ...[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < findCampStateW.platforms.length; i++) ...[
                    GestureDetector(
                      onTap: () {
                        findCampStateW.togglePlatfroms(i);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 5),
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: whiteC,
                          shape: BoxShape.circle,
                          border: findCampStateW.selectedPlatfomrs[i]
                              ? Border.all(color: Colors.blue, width: 2)
                              : Border.all(color: Colors.transparent, width: 2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: SizedBox(
                            width: 35,
                            height: 35,
                            child: CachedNetworkImage(
                              imageUrl: findCampStateW.platforms[i]
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
          ],
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "City",
              textScaleFactor: 1,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w500, color: secondaryC),
            ),
          ),
          if (findCampStateW.cityList.isEmpty) ...[
            const CircularProgressIndicator(),
          ] else ...[
            SizedBox(
              width: width,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  hint: const Text(
                    "City",
                    textScaleFactor: 1,
                    style: TextStyle(
                        fontSize: 16,
                        color: blackC,
                        fontWeight: FontWeight.w400),
                  ),
                  buttonDecoration: BoxDecoration(
                    boxShadow: const [],
                    borderRadius: BorderRadius.circular(10),
                    color: backgroundC,
                  ),
                  itemPadding: const EdgeInsets.only(left: 20, right: 5),
                  buttonPadding: const EdgeInsets.only(left: 20, right: 5),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400),
                  value: findCampStateW.cityValue,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  items: [
                    for (int i = 0;
                        i < findCampStateW.cityList.length;
                        i++) ...[
                      DropdownMenuItem(
                        onTap: () {
                          findCampStateW.setCityId(i);
                        },
                        value: findCampStateW.cityList[i]["cityName"],
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: blackC.withOpacity(0.25),
                              ),
                            ),
                          ),
                          width: 220,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "[${findCampStateW.cityList[i]["cityCode"]}] ${findCampStateW.cityList[i]["cityName"]}",
                            textScaleFactor: 1,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ]
                  ],
                  onChanged: (newval) {
                    findCampStateW.setCityValue(newval!);
                  },
                  buttonElevation: 2,
                  itemHeight: 40,
                  dropdownMaxHeight: 250,
                  dropdownPadding: null,
                  isDense: false,
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(40),
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                  offset: const Offset(0, 0),
                  dropdownDecoration: BoxDecoration(
                      color: const Color(0xfffbfbfb),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const []),
                ),
              ),
            ),
          ],
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                FlutterSwitch(
                  width: 50,
                  height: 25.0,
                  valueFontSize: 25.0,
                  toggleSize: 20.0,
                  value: findCampStateW.isActiveChamp,
                  borderRadius: 30.0,
                  padding: 3.0,
                  showOnOff: false,
                  activeColor: secondaryC,
                  inactiveColor: backgroundC,
                  onToggle: (val) {
                    findCampStateW.setIsActive(val);
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Show only active campaign",
                  textScaleFactor: 1,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: secondaryC),
                ),
              ],
            ),
          ),
          Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  findCampStateW.setIsAdvance(false);
                  // comingalert(context);
                },
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: secondaryC,
                ),
                label: const Text(
                  "Text Search",
                  textScaleFactor: 1,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: secondaryC,
                    fontSize: 16,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  findCampStateW.clear();
                },
                child: const Icon(
                  Icons.delete,
                  color: secondaryC,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryC,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  final data = await findCampStateW.startSeatch(context);
                  if (data[0] != false) {
                    findCampStateW.setIsSearch(true);
                    findCampStateW.setSearchData(jsonDecode(data[0]));
                  }
                },
                child: const Text(
                  "Search",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: whiteC,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CampaingList extends HookConsumerWidget {
  const CampaingList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final findCampStateW = ref.watch(findCampState);

    List platformUrls(List plt) {
      List data = [];

      for (int j = 0; j < plt.length; j++) {
        data.add(plt[j]["platformLogoUrl"]);
      }
      return data;
    }

    return findCampStateW.isSearch
        ? Container(
            width: width,
            margin: const EdgeInsets.symmetric(horizontal: 25),
            padding: const EdgeInsets.symmetric(vertical: 15),
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
                    children: [
                      Text(
                        "Found: ${findCampStateW.searchData.length} Campaigns",
                        textAlign: TextAlign.left,
                        textScaleFactor: 1,
                        style: const TextStyle(
                            color: blackC,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            comingalert(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: backgroundC,
                            elevation: 0,
                          ),
                          icon: const Icon(
                            Icons.sort,
                            color: blackC,
                          ),
                          label: Text(
                            "Reach",
                            textAlign: TextAlign.left,
                            textScaleFactor: 1,
                            style: TextStyle(
                                color: blackC.withOpacity(0.55),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
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
                      if (findCampStateW.searchData.isEmpty) ...[
                        Text(
                          "Reach",
                          textAlign: TextAlign.left,
                          textScaleFactor: 1,
                          style: TextStyle(
                              color: blackC.withOpacity(0.85),
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                      for (int i = 0;
                          i < findCampStateW.searchData.length;
                          i++) ...[
                        HomeCard(
                          imgUrl: findCampStateW.searchData[i]["brand"]["logo"],
                          title:
                              "${findCampStateW.searchData[i]["campaignName"]}",
                          btnColor: const Color(0xfffbc98e),
                          btnText: "Learn more & apply",
                          btnFunction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChampignInfopage(
                                  id: findCampStateW.searchData[i]["id"],
                                ),
                              ),
                            );
                            // ref.read(pageIndex.state).state = 21;
                          },
                          website:
                              "Min Eligible Rating : ${findCampStateW.searchData[i]["minEligibleRating"]} ",
                          category: "Category: Consumer Electronics",
                          isHeart: false,
                          amount:
                              "${findCampStateW.searchData[i]["costPerPost"]}",
                          currency:
                              "${findCampStateW.searchData[i]["currency"]["code"]}",
                          platforms: platformUrls(
                              findCampStateW.searchData[i]["platforms"]),
                        ),
                      ],
                    ],
                  ),
                )
              ],
            ),
          )
        : Container();
  }
}

class BrandList extends HookConsumerWidget {
  const BrandList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final findBrandStateW = ref.watch(findBrandState);

    return findBrandStateW.isSearch
        ? Container(
            width: width,
            margin: const EdgeInsets.symmetric(horizontal: 25),
            padding: const EdgeInsets.symmetric(vertical: 15),
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
                    children: [
                      Text(
                        "Found: ${findBrandStateW.searchData.length} Campaigns",
                        textAlign: TextAlign.left,
                        textScaleFactor: 1,
                        style: const TextStyle(
                            color: blackC,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
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
                      if (findBrandStateW.searchData.isEmpty) ...[
                        Text(
                          "Reach",
                          textAlign: TextAlign.left,
                          textScaleFactor: 1,
                          style: TextStyle(
                              color: blackC.withOpacity(0.85),
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                      for (int i = 0;
                          i < findBrandStateW.searchData.length;
                          i++) ...[
                        HomeCard(
                          imgUrl: findBrandStateW.searchData[i]["logo"],
                          title: findBrandStateW.searchData[i]["name"],
                          btnColor: const Color(0xff80fff9),
                          btnText: "View",
                          btnFunction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BrandInfo(
                                  id: findBrandStateW.searchData[i]["id"]
                                      .toString(),
                                ),
                              ),
                            );
                          },
                          website: findBrandStateW.searchData[i]["email"],
                          category:
                              "Brand Code : ${findBrandStateW.searchData[i]["code"]}",
                          isSocial: false,
                          amount: "3500",
                          currency: "USD",
                          platforms: const [],
                          isHeart: false,
                        ),
                      ],
                    ],
                  ),
                )
              ],
            ),
          )
        : Container();
  }
}

class AdvanceInfSearch extends HookConsumerWidget {
  const AdvanceInfSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    CusApiReq apiReq = CusApiReq();
    // final findCampStateW = ref.watch(findCampState);
    final findInfStateW = ref.watch(findInfState);
    void init() async {
      final req1 = {};
      List platforms =
          await apiReq.postApi(jsonEncode(req1), path: "/api/getplatform");

      final req3 = {};
      List category =
          await apiReq.postApi(jsonEncode(req3), path: "api/getcategory");

      final req4 = {};
      List city = await apiReq.postApi(jsonEncode(req4), path: "api/getcity");

      if (platforms[0]["status"] &&
          category[0]["status"] &&
          city[0]["status"]) {
        findInfStateW.setPlatforms(platforms[0]["data"]);

        findInfStateW.setCmp(category[0]["data"]);
        findInfStateW.setCity(city[0]["data"]);
      } else {
        erroralert(context, "error", "No Record Fount");
      }
    }

    useEffect(() {
      init();
      return null;
    }, []);
    return Container(
      width: width,
      margin: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: whiteC,
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
          // Row(
          //   children: [
          //     const Spacer(),
          //     ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: backgroundC,
          //         elevation: 0,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //       ),
          //       onPressed: () {
          //         comingalert(context);
          //       },
          //       child: const Text(
          //         "Save filter",
          //         textAlign: TextAlign.center,
          //         textScaleFactor: 1,
          //         style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.w500,
          //           color: blackC,
          //         ),
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     DropdownButtonHideUnderline(
          //       child: DropdownButton2<String>(
          //         hint: const Text(
          //           "Saved filter",
          //           textScaleFactor: 1,
          //           style: TextStyle(
          //               fontSize: 16,
          //               color: blackC,
          //               fontWeight: FontWeight.w500),
          //         ),
          //         buttonDecoration: BoxDecoration(
          //           boxShadow: const [],
          //           borderRadius: BorderRadius.circular(10),
          //           color: backgroundC,
          //         ),
          //         itemPadding: const EdgeInsets.only(left: 5, right: 5),
          //         buttonPadding: const EdgeInsets.only(left: 5, right: 5),
          //         style: const TextStyle(
          //             fontSize: 18, fontWeight: FontWeight.w400),
          //         value: filtervalue.value,
          //         icon: const Icon(
          //           Icons.arrow_drop_down,
          //           color: Colors.black,
          //         ),
          //         items: filterlist.value.map((String item) {
          //           return DropdownMenuItem(
          //               value: item,
          //               child: Text(
          //                 item,
          //                 textScaleFactor: 1,
          //                 style: const TextStyle(
          //                     color: Colors.black, fontSize: 18),
          //               ));
          //         }).toList(),
          //         onChanged: (newval) {
          //           filtervalue.value = newval;
          //         },
          //         buttonElevation: 2,
          //         itemHeight: 40,
          //         dropdownMaxHeight: 200,
          //         dropdownPadding: null,
          //         isDense: false,
          //         dropdownElevation: 8,
          //         scrollbarRadius: const Radius.circular(40),
          //         scrollbarThickness: 6,
          //         scrollbarAlwaysShow: true,
          //         offset: const Offset(0, 0),
          //         dropdownDecoration: BoxDecoration(
          //           color: whiteC,
          //           borderRadius: BorderRadius.circular(5),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Select",
              textScaleFactor: 1,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w500, color: secondaryC),
            ),
          ),
          if (findInfStateW.cmpList.isEmpty) ...[
            const CircularProgressIndicator(),
          ] else ...[
            SizedBox(
              width: width,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  hint: const Text(
                    "Category",
                    textScaleFactor: 1,
                    style: TextStyle(
                        fontSize: 16,
                        color: blackC,
                        fontWeight: FontWeight.w400),
                  ),
                  buttonDecoration: BoxDecoration(
                    boxShadow: const [],
                    borderRadius: BorderRadius.circular(10),
                    color: backgroundC,
                  ),
                  itemPadding: const EdgeInsets.only(left: 20, right: 5),
                  buttonPadding: const EdgeInsets.only(left: 20, right: 5),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400),
                  value: findInfStateW.cmpValue,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  items: [
                    for (int i = 0; i < findInfStateW.cmpList.length; i++) ...[
                      DropdownMenuItem(
                        onTap: () {
                          findInfStateW.setCmpId(i);
                        },
                        value: findInfStateW.cmpList[i]["categoryName"],
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: blackC.withOpacity(0.25),
                              ),
                            ),
                          ),
                          width: 220,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "[${findInfStateW.cmpList[i]["categoryCode"]}] ${findInfStateW.cmpList[i]["categoryName"]}",
                            textScaleFactor: 1,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ]
                  ],
                  onChanged: (newval) {
                    findInfStateW.setCmpValue(newval!);
                  },
                  buttonElevation: 2,
                  itemHeight: 40,
                  dropdownMaxHeight: 250,
                  dropdownPadding: null,
                  isDense: false,
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(40),
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                  offset: const Offset(0, 0),
                  dropdownDecoration: BoxDecoration(
                      color: const Color(0xfffbfbfb),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const []),
                ),
              ),
            ),
          ],
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Channels",
              textScaleFactor: 1,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w500, color: secondaryC),
            ),
          ),
          if (findInfStateW.platforms.isEmpty ||
              findInfStateW.selectedPlatfomrs.isEmpty) ...[
            const CircularProgressIndicator()
          ] else ...[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < findInfStateW.platforms.length; i++) ...[
                    GestureDetector(
                      onTap: () {
                        findInfStateW.togglePlatfroms(i);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 5),
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: whiteC,
                          shape: BoxShape.circle,
                          border: findInfStateW.selectedPlatfomrs[i]
                              ? Border.all(color: Colors.blue, width: 2)
                              : Border.all(color: Colors.transparent, width: 2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: SizedBox(
                            width: 35,
                            height: 35,
                            child: CachedNetworkImage(
                              imageUrl: findInfStateW.platforms[i]
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
          ],
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "City",
              textScaleFactor: 1,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w500, color: secondaryC),
            ),
          ),
          if (findInfStateW.cityList.isEmpty) ...[
            const CircularProgressIndicator(),
          ] else ...[
            SizedBox(
              width: width,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  hint: const Text(
                    "City",
                    textScaleFactor: 1,
                    style: TextStyle(
                        fontSize: 16,
                        color: blackC,
                        fontWeight: FontWeight.w400),
                  ),
                  buttonDecoration: BoxDecoration(
                    boxShadow: const [],
                    borderRadius: BorderRadius.circular(10),
                    color: backgroundC,
                  ),
                  itemPadding: const EdgeInsets.only(left: 20, right: 5),
                  buttonPadding: const EdgeInsets.only(left: 20, right: 5),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400),
                  value: findInfStateW.cityValue,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  items: [
                    for (int i = 0; i < findInfStateW.cityList.length; i++) ...[
                      DropdownMenuItem(
                        onTap: () {
                          findInfStateW.setCityId(i);
                        },
                        value: findInfStateW.cityList[i]["cityName"],
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: blackC.withOpacity(0.25),
                              ),
                            ),
                          ),
                          width: 220,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "[${findInfStateW.cityList[i]["cityCode"]}] ${findInfStateW.cityList[i]["cityName"]}",
                            textScaleFactor: 1,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ]
                  ],
                  onChanged: (newval) {
                    findInfStateW.setCityValue(newval!);
                  },
                  buttonElevation: 2,
                  itemHeight: 40,
                  dropdownMaxHeight: 250,
                  dropdownPadding: null,
                  isDense: false,
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(40),
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                  offset: const Offset(0, 0),
                  dropdownDecoration: BoxDecoration(
                      color: const Color(0xfffbfbfb),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const []),
                ),
              ),
            ),
          ],
          const SizedBox(
            height: 20,
          ),

          Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  findInfStateW.setIsAdvance(false);
                  // comingalert(context);
                },
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: secondaryC,
                ),
                label: const Text(
                  "Text Search",
                  textScaleFactor: 1,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: secondaryC,
                    fontSize: 16,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  findInfStateW.clear();
                },
                child: const Icon(
                  Icons.delete,
                  color: secondaryC,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryC,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  final data = await findInfStateW.startSeatch(context);
                  if (data[0] != false) {
                    findInfStateW.setIsSearch(true);
                    findInfStateW.setSearchData(jsonDecode(data[0]));
                  }
                },
                child: const Text(
                  "Search",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: whiteC,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserList extends HookConsumerWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    final findInfStateW = ref.watch(findInfState);

    return findInfStateW.isSearch
        ? Container(
            width: width,
            margin: const EdgeInsets.symmetric(horizontal: 25),
            padding: const EdgeInsets.symmetric(vertical: 15),
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
                    children: [
                      Text(
                        "Found: ${findInfStateW.searchData.length} Campaigns",
                        textAlign: TextAlign.left,
                        textScaleFactor: 1,
                        style: const TextStyle(
                            color: blackC,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            comingalert(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: backgroundC,
                            elevation: 0,
                          ),
                          icon: const Icon(
                            Icons.sort,
                            color: blackC,
                          ),
                          label: Text(
                            "Reach",
                            textAlign: TextAlign.left,
                            textScaleFactor: 1,
                            style: TextStyle(
                                color: blackC.withOpacity(0.55),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
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
                      if (findInfStateW.searchData.isEmpty) ...[
                        Text(
                          "Reach",
                          textAlign: TextAlign.left,
                          textScaleFactor: 1,
                          style: TextStyle(
                              color: blackC.withOpacity(0.85),
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                      for (int i = 0;
                          i < findInfStateW.searchData.length;
                          i++) ...[
                        HomeCard(
                          imgUrl: findInfStateW.searchData[i]["pic"],
                          title: findInfStateW.searchData[i]["userName"],
                          btnColor: const Color(0xff80fff9),
                          btnText: "View Profile",
                          btnFunction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserInfo(
                                  id: findInfStateW.searchData[i]["id"]
                                      .toString(),
                                ),
                              ),
                            );
                          },
                          website: findInfStateW.searchData[i]["email"],
                          category:
                              "Rating: ${findInfStateW.searchData[i]["rating"]}",
                          isSocial: false,
                          amount: "3500",
                          currency: "USD",
                          platforms: const [],
                          isHeart: false,
                        ),

                        // HomeCard(
                        //   imgUrl: findCampStateW.searchData[i]["brand"]["logo"],
                        //   title:
                        //       "${findCampStateW.searchData[i]["campaignName"]}",
                        //   btnColor: const Color(0xfffbc98e),
                        //   btnText: "Learn more & apply",
                        //   btnFunction: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => ChampignInfopage(
                        //           id: findCampStateW.searchData[i]["id"],
                        //         ),
                        //       ),
                        //     );
                        //     // ref.read(pageIndex.state).state = 21;
                        //   },
                        //   website:
                        //       "Min Eligible Rating : ${findCampStateW.searchData[i]["minEligibleRating"]} ",
                        //   category: "Category: Consumer Electronics",
                        //   isHeart: false,
                        //   amount:
                        //       "${findCampStateW.searchData[i]["costPerPost"]}",
                        //   currency:
                        //       "${findCampStateW.searchData[i]["currency"]["code"]}",
                        //   platforms: platformUrls(
                        //       findCampStateW.searchData[i]["platforms"]),
                        // ),
                      ],
                    ],
                  ),
                )
              ],
            ),
          )
        : Container();
  }
}
