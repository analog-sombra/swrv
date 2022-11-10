// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:swrv/components/header.dart';
import 'package:swrv/state/compaign/createcampaignstate.dart';
import 'package:swrv/state/navstate.dart';
import 'package:swrv/utils/alerts.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/widgets/cuswidgets.dart';

import '../../services/apirequest.dart';

class CreateCampaignsPage extends HookConsumerWidget {
  const CreateCampaignsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createCmpSW = ref.watch(createCampState);
    CusApiReq apiReq = CusApiReq();

    void init() async {
      final req3 = {};
      List category =
          await apiReq.postApi(jsonEncode(req3), path: "api/get-campaign-type");

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Header(),
            Container(
                width: width,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: whiteC,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                        color: shadowC, blurRadius: 5, offset: Offset(0, 6))
                  ],
                ),
                padding: const EdgeInsets.all(15),
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
                                    ref.watch(pageIndex.state).state = 24;
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
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 300,
                          ),
                          itemCount: createCmpSW.categoryList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                createCmpSW.setCategoryId(index);
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
                                          color: blackC.withOpacity(0.65),
                                          width: 2.5)
                                      : Border.all(
                                          color: Colors.transparent, width: 0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(8)),
                                      child: Container(
                                        color: Colors.red,
                                        height: 150,
                                        child: Image.asset(
                                          "assets/images/post1.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Don't miss out on Early Access sale of EOSS for members only...."
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
                            );
                          },
                        )
                      ],
                    ]))
          ],
        ),
      ),
    );
  }
}

class CreateCampaings extends HookConsumerWidget {
  const CreateCampaings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    final createCmpSW = ref.watch(createCampState);

    ValueNotifier<bool> isBrand = useState(false);

    CusApiReq apiReq = CusApiReq();

    TextEditingController name = useTextEditingController();
    TextEditingController info = useTextEditingController();
    TextEditingController startDate = useTextEditingController();
    TextEditingController endDate = useTextEditingController();

    TextEditingController maxReach = useTextEditingController();
    TextEditingController minReach = useTextEditingController();
    TextEditingController costPerPage = useTextEditingController();
    TextEditingController totalBaudget = useTextEditingController();

    void init() async {
      final req1 = {};
      List platforms =
          await apiReq.postApi(jsonEncode(req1), path: "/api/getplatform");

      final req2 = {};
      List currency =
          await apiReq.postApi(jsonEncode(req2), path: "/api/getcurrency");

      final req3 = {};
      List category =
          await apiReq.postApi(jsonEncode(req3), path: "api/getcategory");

      final req4 = {};
      List city = await apiReq.postApi(jsonEncode(req4), path: "api/getcity");

      if (platforms[0]["status"] &&
          currency[0]["status"] &&
          category[0]["status"] &&
          city[0]["status"]) {
        createCmpSW.setPlatforms(platforms[0]["data"]);
        createCmpSW.setCurrecny(currency[0]["data"]);
        createCmpSW.setCmp(category[0]["data"]);
        createCmpSW.setCity(city[0]["data"]);
      } else {
        erroralert(context, "error", "No Record Fount");
      }
    }

    useEffect(() {
      init();
      return null;
    }, []);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Header(),
            const Padding(
              padding: EdgeInsets.only(left: 25, top: 20),
              child: Text(
                "Create campaign",
                textScaleFactor: 1,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w600, color: blackC),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25, top: 10),
              child: Text(
                "Here you can create campaigns that you are like.",
                textScaleFactor: 1,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w400, color: blackC),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                        backgroundColor:
                            isBrand.value ? whiteC : const Color(0xff01fff4),
                      ),
                      onPressed: () {
                        isBrand.value = false;
                      },
                      child: Text(
                        "Campaign",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1,
                        style: TextStyle(
                            color: isBrand.value
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
                        backgroundColor:
                            isBrand.value ? const Color(0xff01fff4) : whiteC,
                      ),
                      onPressed: () {
                        isBrand.value = true;
                      },
                      child: Text(
                        "Brand",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1,
                        style: TextStyle(
                            color: isBrand.value
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
            Container(
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
                  cusTitle("Campaign name"),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextField(
                        controller: name,
                        decoration: const InputDecoration(
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
                  cusTitle("Campaign info"),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextField(
                        minLines: 4,
                        maxLines: 7,
                        controller: info,
                        decoration: const InputDecoration(
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
                  cusTitle("Campaign Start date"),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextField(
                        readOnly: true,
                        controller: startDate,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xfff3f4f6),
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
                            lastDate: DateTime(DateTime.now().year + 100,
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
                          startDate.text =
                              DateFormat("dd-MM-yyyy").format(date!);
                        },
                      ),
                    ),
                  ),
                  cusTitle("Campaign end date"),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextField(
                        readOnly: true,
                        controller: endDate,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xfff3f4f6),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        onTap: () async {
                          if (startDate.text == "") {
                            erroralert(context, "Date Error",
                                "Please select Starting date first");
                          } else {
                            var date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(DateTime.now().year + 100,
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
                            final dt1 = DateTime.parse(
                                "${startDate.text.split("-")[2]}-${startDate.text.split("-")[1]}-${startDate.text.split("-")[0]}");
                            final dt2 = DateTime.parse(
                                DateFormat("yyyy-MM-dd").format(date!));

                            if (dt1.compareTo(dt2) > 0) {
                              erroralert(context, "Date Error",
                                  "End date should be bigger then staring date");
                            } else {
                              endDate.text =
                                  DateFormat("dd-MM-yyyy").format(date);
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  cusTitle("Campaign Min Reach"),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: minReach,
                        decoration: const InputDecoration(
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
                  cusTitle("Campaign Max Reach"),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: maxReach,
                        decoration: const InputDecoration(
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
                  cusTitle("Campaign Cost Per Page"),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: costPerPage,
                        decoration: const InputDecoration(
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
                  cusTitle("Campaign Total Budget"),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: totalBaudget,
                        decoration: const InputDecoration(
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
                  cusTitle("Campaign Eligible Rating"),
                  RatingBar.builder(
                    initialRating: createCmpSW.rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      createCmpSW.setRating(rating);
                    },
                  ),
                  cusTitle("Category"),
                  if (createCmpSW.cmpList.isEmpty) ...[
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
                          itemPadding:
                              const EdgeInsets.only(left: 20, right: 5),
                          buttonPadding:
                              const EdgeInsets.only(left: 20, right: 5),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                          value: createCmpSW.cmpValue,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          items: [
                            for (int i = 0;
                                i < createCmpSW.cmpList.length;
                                i++) ...[
                              DropdownMenuItem(
                                onTap: () {
                                  createCmpSW.setCmpId(i);
                   
                                },
                                value: createCmpSW.cmpList[i]
                                    ["categoryName"],
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: blackC.withOpacity(0.25),
                                      ),
                                    ),
                                  ),
                                  width: 220,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    "[${createCmpSW.cmpList[i]["categoryCode"]}] ${createCmpSW.cmpList[i]["categoryName"]}",
                                    textScaleFactor: 1,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                              ),
                            ]
                          ],
                          onChanged: (newval) {
                            createCmpSW.setCmpValue(newval!);
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
                  cusTitle("Select Platforms"),
                  if (createCmpSW.platforms.isEmpty ||
                      createCmpSW.selectedPlatfomrs.isEmpty) ...[
                    const CircularProgressIndicator()
                  ] else ...[
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int i = 0;
                              i < createCmpSW.platforms.length;
                              i++) ...[
                            GestureDetector(
                              onTap: () {
                                createCmpSW.togglePlatfroms(i);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 5),
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: whiteC,
                                  shape: BoxShape.circle,
                                  border: createCmpSW.selectedPlatfomrs[i]
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
                                      imageUrl: createCmpSW.platforms[i]
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
                  cusTitle("Select Currency"),
                  if (createCmpSW.categoryList.isEmpty) ...[
                    const CircularProgressIndicator(),
                  ] else ...[
                    SizedBox(
                      width: width,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          hint: const Text(
                            "Currency",
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
                          itemPadding:
                              const EdgeInsets.only(left: 20, right: 5),
                          buttonPadding:
                              const EdgeInsets.only(left: 20, right: 5),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                          value: createCmpSW.currencyValue,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          items: [
                            for (int i = 0;
                                i < createCmpSW.currencyList.length;
                                i++) ...[
                              DropdownMenuItem(
                                onTap: () {
                                  createCmpSW.setCurrencyId(i);
                                },
                                value: createCmpSW.currencyList[i]
                                    ["currencyName"],
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: blackC.withOpacity(0.25),
                                      ),
                                    ),
                                  ),
                                  width: 220,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    "[${createCmpSW.currencyList[i]["currencyCode"]}] ${createCmpSW.currencyList[i]["currencyName"]}",
                                    textScaleFactor: 1,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                              ),
                            ]
                          ],
                          onChanged: (newval) {
                            createCmpSW.setCurrencyValue(newval!);
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
                  cusTitle("Select City"),
                  if (createCmpSW.cityList.isEmpty) ...[
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
                          itemPadding:
                              const EdgeInsets.only(left: 20, right: 5),
                          buttonPadding:
                              const EdgeInsets.only(left: 20, right: 5),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                          value: createCmpSW.cityValue,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          items: [
                            for (int i = 0;
                                i < createCmpSW.cityList.length;
                                i++) ...[
                              DropdownMenuItem(
                                onTap: () {
                                  createCmpSW.setCityId(i);
                                },
                                value: createCmpSW.cityList[i]["cityName"],
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: blackC.withOpacity(0.25),
                                      ),
                                    ),
                                  ),
                                  width: 220,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    "[${createCmpSW.cityList[i]["cityCode"]}] ${createCmpSW.cityList[i]["cityName"]}",
                                    textScaleFactor: 1,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                              ),
                            ]
                          ],
                          onChanged: (newval) {
                            createCmpSW.setCityValue(newval!);
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
                  CusBtn(
                      btnColor: primaryC,
                      btnText: "Create",
                      textSize: 18,
                      btnFunction: () async {
                        // createCmpSW.setCampData([
                        //   name.text,
                        //   info.text,
                        //   startDate.text,
                        //   endDate.text,
                        //   minReach.text,
                        //   maxReach.text,
                        //   costPerPage.text,
                        //   totalBaudget.text,
                        // ]);

                        ref.watch(pageIndex.state).state = 0;

                        try {
                          final res = await createCmpSW.createCamp(context, [
                            name.text,
                            info.text,
                            startDate.text,
                            endDate.text,
                            minReach.text,
                            maxReach.text,
                            costPerPage.text,
                            totalBaudget.text,
                          ]);
                          if (res) {
                            ref.watch(pageIndex.state).state = 0;
                          }
                        } catch (e) {
                          log(e.toString());
                        }
                      }),
                ],
              ),
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }

  Widget cusTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        textScaleFactor: 1,
        textAlign: TextAlign.left,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: secondaryC),
      ),
    );
  }
}
