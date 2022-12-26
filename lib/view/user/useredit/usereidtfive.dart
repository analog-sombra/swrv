// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/state/userstate.dart';
import 'package:swrv/utils/utilthemes.dart';

import '../../../services/apirequest.dart';
import '../../../state/user/influenceredit.dart';
import '../../../utils/alerts.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/componets.dart';
import '../../home/home.dart';
import '../../navigation/bottomnavbar.dart';
import '../../navigation/drawer.dart';

class UserEditFive extends HookConsumerWidget {
  const UserEditFive({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileEditW = ref.watch(userProfileEditState);

    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());

    final GlobalKey<FormState> formKey =
        useMemoized(() => GlobalKey<FormState>());

    final userStateW = ref.watch(userState);
    ValueNotifier<String> userId = useState("0");

    TextEditingController country = useTextEditingController();
    TextEditingController number = useTextEditingController();
    TextEditingController gender = useTextEditingController();
    TextEditingController city = useTextEditingController();
    TextEditingController address = useTextEditingController();
    TextEditingController citySearch = useTextEditingController();

    ValueNotifier<bool> isLoading = useState(true);

    CusApiReq apiReq = CusApiReq();
    void init() async {
      userId.value = await userStateW.getUserId();

      List countryRes =
          await apiReq.postApi(jsonEncode({}), path: "/api/getcountry");

      if (countryRes[0]["status"]) {
        userProfileEditW.setCountryList(countryRes[0]["data"]);
      } else {
        erroralert(context, "error", "No Record Fount");
      }
      isLoading.value = false;
    }

    useEffect(() {
      init();
      return;
    }, []);

    void countryBox() {
      showModalBottomSheet(
        backgroundColor: whiteC,
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                    child: Text(
                  "Country",
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.85),
                  ),
                )),
              ),
              const Divider(),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0;
                        i < userProfileEditW.countryList.length;
                        i++) ...[
                      CheckboxListTile(
                        value: userProfileEditW.selectedCountry[i],
                        onChanged: (val) {
                          userProfileEditW.setCountry(i, val!);
                          setState(() {});
                        },
                        title: Text(
                            '${userProfileEditW.countryList[i]["id"]} ${userProfileEditW.countryList[i]["name"]}   [ ${userProfileEditW.countryList[i]["code"]} ]'),
                      )
                    ]
                  ],
                ),
              )),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          elevation: 0,
                          backgroundColor: const Color(0xffef4444),
                        ),
                        onPressed: () {
                          country.clear();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Clear",
                          textAlign: TextAlign.center,
                          textScaleFactor: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            backgroundColor: const Color(0xff22c55e)),
                        onPressed: () {
                          if (userProfileEditW.countryVal.isNotEmpty) {
                            country.text =
                                "${userProfileEditW.countryVal[0]["name"]} [${userProfileEditW.countryVal[0]["code"]}]";
                          } else {
                            country.clear();
                          }
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "confirm",
                          textAlign: TextAlign.center,
                          textScaleFactor: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }),
      );
    }

    void genderBox() {
      showModalBottomSheet(
        backgroundColor: whiteC,
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                    child: Text(
                  "Gender",
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.85),
                  ),
                )),
              ),
              const Divider(),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0;
                        i < userProfileEditW.genderList.length;
                        i++) ...[
                      CheckboxListTile(
                        value: userProfileEditW.selectedGender[i],
                        onChanged: (val) {
                          userProfileEditW.setGender(i, val!);
                          setState(() {});
                        },
                        title: Text(userProfileEditW.genderList[i]),
                      )
                    ]
                  ],
                ),
              )),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          elevation: 0,
                          backgroundColor: const Color(0xffef4444),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cencel",
                          textAlign: TextAlign.center,
                          textScaleFactor: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            backgroundColor: const Color(0xff22c55e)),
                        onPressed: () {
                          if (userProfileEditW.genderVal.isNotEmpty) {
                            gender.text = userProfileEditW.genderVal[0];
                          } else {
                            gender.clear();
                          }
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "confirm",
                          textAlign: TextAlign.center,
                          textScaleFactor: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }),
      );
    }

    void cityBox() {
      showModalBottomSheet(
        backgroundColor: whiteC,
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                      child: Text(
                    "City",
                    textScaleFactor: 1,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.85),
                    ),
                  )),
                ),
                const Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int i = 0;
                            i < userProfileEditW.cityList.length;
                            i++) ...[
                          CheckboxListTile(
                            value: userProfileEditW.selectedCity[i],
                            onChanged: (val) {
                              userProfileEditW.setCity(i, val!);
                              setState(() {});
                            },
                            title: Text(
                              '${userProfileEditW.cityList[i]["name"]}   [ ${userProfileEditW.cityList[i]["code"]} ]',
                            ),
                          )
                        ]
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            elevation: 0,
                            backgroundColor: const Color(0xffef4444),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Clear",
                            textAlign: TextAlign.center,
                            textScaleFactor: 1,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: const Color(0xff22c55e)),
                          onPressed: () {
                            if (userProfileEditW.cityVal.isNotEmpty) {
                              userProfileEditW.setCityValue(
                                  "${userProfileEditW.cityVal[0]["name"]} [${userProfileEditW.cityVal[0]["code"]}]");
                            } else {
                              userProfileEditW.setCityValue(null);
                            }

                            Navigator.pop(context);
                          },
                          child: const Text(
                            "confirm",
                            textAlign: TextAlign.center,
                            textScaleFactor: 1,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      );
    }

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
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Form(
                  key: formKey,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Edit Profile",
                                textAlign: TextAlign.center,
                                textScaleFactor: 1,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text(
                                  "Country",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null ||
                                          value == "" ||
                                          value.isEmpty) {
                                        return "Fill this field";
                                      }
                                      return null;
                                    },
                                    controller: country,
                                    readOnly: true,
                                    onTap: () {
                                      countryBox();
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.arrow_drop_down,
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
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text(
                                  "Phone number",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null ||
                                          value == "" ||
                                          value.isEmpty) {
                                        return "Fill the mobile number";
                                      } else if (value.length != 10) {
                                        return "Enter a valid 10 deigt phone number";
                                      }
                                      return null;
                                    },
                                    maxLength: 10,
                                    onChanged: (value) {
                                      userProfileEditW.setNumber(value);
                                    },
                                    keyboardType: TextInputType.number,
                                    controller: number,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xfff3f4f6),
                                      counterText: "",
                                      prefixText: userProfileEditW
                                              .countryVal.isEmpty
                                          ? "0 - "
                                          : "${userProfileEditW.countryVal[0]["isd"]} - ",
                                      prefixStyle: const TextStyle(
                                          color: blackC, fontSize: 16),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text(
                                  "Gender",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null ||
                                          value == "" ||
                                          value.isEmpty) {
                                        return "Fill this field";
                                      }
                                      return null;
                                    },
                                    onTap: () {
                                      genderBox();
                                    },
                                    readOnly: true,
                                    controller: gender,
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.arrow_drop_down,
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
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text(
                                  "City",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: TextField(
                                    controller: citySearch,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: blackC.withOpacity(0.65),
                                      ),
                                      suffixIcon: InkWell(
                                        onTap: () async {
                                          if (citySearch.text.isEmpty ||
                                              citySearch.text == "") {
                                            erroralert(context, "Error",
                                                "Please fill this filed before searching");
                                          } else {
                                            userProfileEditW
                                                .resetCitySelection();
                                            final req = {
                                              "search": citySearch.text
                                            };
                                            List city = await apiReq.postApi(
                                                jsonEncode(req),
                                                path: "api/get-city");
                                            if (city[0]["status"] == false) {
                                              erroralert(context, "Error",
                                                  "No city found with this name");
                                            } else {
                                              userProfileEditW
                                                  .setCityList(city[0]["data"]);
                                              cityBox();
                                            }
                                          }
                                        },
                                        child: const Icon(
                                          Icons.arrow_forward,
                                          size: 25,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: backgroundC,
                                      errorBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  userProfileEditW.cityValue ??
                                      "city is not selected",
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: blackC.withOpacity(
                                      0.75,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text(
                                  "Address",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null ||
                                          value == "" ||
                                          value.isEmpty) {
                                        return "Fill the address";
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      userProfileEditW.setAddress(value);
                                    },
                                    controller: address,
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
                                      btnText: "Save",
                                      textSize: 18,
                                      btnFunction: () async {
                                        isLoading.value = true;
                                        if (formKey.currentState!.validate()) {
                                          await userProfileEditW
                                              .sectionFiveUpdate(context);

                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePage(),
                                            ),
                                            (Route<dynamic> route) => false,
                                          );
                                        }
                                        isLoading.value = false;
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                      const SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
