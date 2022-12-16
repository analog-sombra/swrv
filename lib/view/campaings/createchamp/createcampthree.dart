// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:swrv/state/compaign/createcampaignstate.dart';
import 'package:swrv/utils/alerts.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/view/campaings/createchamp/campaignpreview.dart';
import 'package:swrv/widgets/buttons.dart';

import '../../../services/apirequest.dart';
import '../../../widgets/componets.dart';
import '../../navigation/bottomnavbar.dart';
import '../../navigation/drawer.dart';

class CreateCampaings extends HookConsumerWidget {
  const CreateCampaings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());
    final width = MediaQuery.of(context).size.width;

    final createCmpSW = ref.watch(createCampState);

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
      final req2 = {};
      List currency =
          await apiReq.postApi(jsonEncode(req2), path: "/api/getcurrency");

      final req3 = {};
      List category =
          await apiReq.postApi(jsonEncode(req3), path: "api/getcategory");

      final req4 = {};
      List city = await apiReq.postApi(jsonEncode(req4), path: "api/getcity");

      if (currency[0]["status"] && category[0]["status"] && city[0]["status"]) {
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
                margin: const EdgeInsets.all(25),
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
                                  value: createCmpSW.cmpList[i]["categoryName"],
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
                                  value: createCmpSW.cityList[i]["name"],
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
                                      "[${createCmpSW.cityList[i]["code"]}] ${createCmpSW.cityList[i]["name"]}",
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
                    cusTitle("Mood boards"),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: backgroundC,
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 6),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 0;
                                i < createCmpSW.images.length;
                                i++) ...[
                              Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 8),
                                      decoration: BoxDecoration(boxShadow: [
                                        BoxShadow(
                                            color: blackC.withOpacity(0.15),
                                            blurRadius: 5)
                                      ]),
                                      width: 80,
                                      height: 80,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          createCmpSW.images[i],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      onTap: () {
                                        createCmpSW
                                            .removeImage(createCmpSW.images[i]);
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: whiteC,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () async {
                                  await createCmpSW.addImage(context);
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  decoration: BoxDecoration(
                                    color: whiteC,
                                    boxShadow: [
                                      BoxShadow(
                                        color: blackC.withOpacity(0.15),
                                      )
                                    ],
                                  ),
                                  width: 80,
                                  height: 80,
                                  child: const Center(
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CusBtn(
                      btnColor: primaryC,
                      btnText: "Preview",
                      textSize: 18,
                      btnFunction: () async {
                        createCmpSW.setdata([
                          name.text,
                          info.text,
                          startDate.text,
                          endDate.text,
                          minReach.text,
                          maxReach.text,
                          costPerPage.text,
                          totalBaudget.text,
                        ]);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CampaignsPreview(),
                          ),
                        );
                      },
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
