import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:swrv/utils/alerts.dart';
import 'package:swrv/widgets/buttons.dart';

import '../../../state/compaign/createcampaignstate.dart';
import '../../../utils/utilthemes.dart';
import '../../../widgets/alerts.dart';
import '../../../widgets/componets.dart';
import '../../navigation/bottomnavbar.dart';
import '../../navigation/drawer.dart';
import 'createcampthree.dart';

class CreateCampTwo extends HookConsumerWidget {
  const CreateCampTwo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());
    final GlobalKey<FormState> formKey =
        useMemoized(() => GlobalKey<FormState>());
    final width = MediaQuery.of(context).size.width;

    TextEditingController audienceLocation = useTextEditingController();
    TextEditingController tillDate = useTextEditingController();
    TextEditingController minInf = useTextEditingController();

    TextEditingController cashText = useTextEditingController();
    TextEditingController productText = useTextEditingController();
    TextEditingController revenueText = useTextEditingController();
    TextEditingController discountText = useTextEditingController();

    final createCmpSW = ref.watch(createCampState);
    void init() async {
      tillDate.text = createCmpSW.tillDate ?? "";
      minInf.text = createCmpSW.minInf ?? "";
      cashText.text = createCmpSW.cashText ?? "";
      productText.text = createCmpSW.productText ?? "";
      revenueText.text = createCmpSW.revenueText ?? "";
      discountText.text = createCmpSW.discountText ?? "";
      await createCmpSW.setCmp();
      await createCmpSW.setCurrecny();
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
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      cusTitle("Audience & demeography"),
                      const Divider(
                        color: Colors.black,
                      ),
                      cusTitle("Audience location"),
                      InkWell(
                        onTap: () {
                          addAudienceLocation(context, audienceLocation, ref);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: backgroundC,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(children: [
                                    for (int i = 0;
                                        i < createCmpSW.audienceLocation.length;
                                        i++) ...[
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: whiteC,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              "@${createCmpSW.audienceLocation[i]}",
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
                                            InkWell(
                                              onTap: () {
                                                createCmpSW
                                                    .removeAudienceLocation(
                                                  createCmpSW
                                                      .audienceLocation[i],
                                                );
                                              },
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ]),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {
                                    addAudienceLocation(
                                        context, audienceLocation, ref);
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: blackC,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      cusTitle("Influencer category"),
                      if (createCmpSW.cmpList.isEmpty) ...[
                        const CircularProgressIndicator(),
                      ] else ...[
                        SizedBox(
                          width: width,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              hint: const Text(
                                "Influencer category",
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
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
                        height: 15,
                      ),
                      cusTitle(
                          "Maximum no of influencers that can join the campaign"),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null ||
                                  value == "" ||
                                  value.isEmpty) {
                                return "Please Select the min influencer";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              createCmpSW.setMinInf(value);
                            },
                            controller: minInf,
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
                      const SizedBox(
                        height: 15,
                      ),
                      cusTitle(
                          "Geo restriction ( Optional only applicable for influencer filtering ) radius in kilometers"),
                      InkWell(
                        onTap: () {
                          comingalert(context);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "https://www.thestatesman.com/wp-content/uploads/2020/04/googl_ED.jpg",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
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
                      const SizedBox(
                        height: 15,
                      ),
                      cusTitle("Remuneration"),
                      SizedBox(
                        width: width,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            hint: const Text(
                              "Select remuneration type",
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
                            value: createCmpSW.remunerationValue,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            items: [
                              for (int i = 0;
                                  i < createCmpSW.remuneration.length;
                                  i++) ...[
                                DropdownMenuItem(
                                  onTap: () {
                                    createCmpSW.setRevVal(i);
                                  },
                                  value: createCmpSW.remuneration[i],
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
                                      createCmpSW.remuneration[i],
                                      textScaleFactor: 1,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ]
                            ],
                            onChanged: (newval) {
                              createCmpSW.setRemuneration(newval!);
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
                              // boxShadow: const [],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (createCmpSW.revType == RevType.cash) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null ||
                                    value == "" ||
                                    value.isEmpty) {
                                  return "This field can't be empty";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                createCmpSW.setCashText(value);
                              },
                              controller: cashText,
                              decoration: InputDecoration(
                                suffixText: createCmpSW.currencyValue ?? "",
                                suffixStyle: const TextStyle(
                                    color: blackC,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                                filled: true,
                                fillColor: const Color(0xfff3f4f6),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ] else if (createCmpSW.revType == RevType.product) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null ||
                                    value == "" ||
                                    value.isEmpty) {
                                  return "This field can't be empty";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                createCmpSW.setProductText(value);
                              },
                              controller: productText,
                              decoration: const InputDecoration(
                                hintText: "Product details",
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
                      ] else if (createCmpSW.revType == RevType.revenue) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null ||
                                    value == "" ||
                                    value.isEmpty) {
                                  return "This field can't be empty";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                createCmpSW.setRevenueText(value);
                              },
                              controller: revenueText,
                              decoration: const InputDecoration(
                                suffixText: "% Per Sale",
                                suffixStyle: TextStyle(
                                    color: blackC,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
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
                      ] else if (createCmpSW.revType == RevType.discount) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null ||
                                    value == "" ||
                                    value.isEmpty) {
                                  return "This field can't be empty";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                createCmpSW.setDiscountText(value);
                              },
                              controller: discountText,
                              decoration: const InputDecoration(
                                hintText: "Coupons",
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
                      ],
                      const SizedBox(
                        height: 15,
                      ),
                      cusTitle("Accept participation / invite till"),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: TextFormField(
                            readOnly: true,
                            controller: tillDate,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == "") {
                                return 'Please select the date.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.calendar_month,
                                color: Colors.black.withOpacity(0.8),
                              ),
                              filled: true,
                              fillColor: const Color(0xfff3f4f6),
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
                                lastDate: DateTime(DateTime.now().year + 2,
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
                              tillDate.text =
                                  DateFormat("dd-MM-yyyy").format(date!);
                              createCmpSW.setTillDate(tillDate.text);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CusBtn(
                              btnColor: backgroundC,
                              btnText: "Back",
                              textSize: 18,
                              btnFunction: () {
                                Navigator.pop(context);
                              },
                              textColor: blackC,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: CusBtn(
                              btnColor: secondaryC,
                              btnText: "Next",
                              textSize: 18,
                              btnFunction: () {
                                if (createCmpSW.audienceLocation.isEmpty) {
                                  erroralert(context, "Error",
                                      "Add some audience location");
                                } else if (createCmpSW.cmpId == null) {
                                  erroralert(
                                      context, "Error", "Select one category");
                                } else if (createCmpSW.currencyId == null) {
                                  erroralert(context, "Error",
                                      "Select one currenty type");
                                } else if (createCmpSW.remunerationValue ==
                                    null) {
                                  erroralert(context, "Error",
                                      "Select one remunerration type");
                                } else if (formKey.currentState!.validate()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CreateCampThree(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cusTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 15),
      child: Text(
        title,
        textScaleFactor: 1,
        textAlign: TextAlign.left,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: secondaryC),
      ),
    );
  }
}
