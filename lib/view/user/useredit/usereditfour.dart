// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:swrv/state/userstate.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/view/user/useredit/usereidtfive.dart';

import '../../../services/apirequest.dart';
import '../../../state/user/influenceredit.dart';
import '../../../utils/alerts.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/componets.dart';
import '../../navigation/bottomnavbar.dart';
import '../../navigation/drawer.dart';

class UserEditFour extends HookConsumerWidget {
  const UserEditFour({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileEditW = ref.watch(userProfileEditState);
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());

    final GlobalKey<FormState> formKey =
        useMemoized(() => GlobalKey<FormState>());

    final userStateW = ref.watch(userState);
    ValueNotifier<bool> isLoading = useState(true);

    ValueNotifier<String> userId = useState("0");

    TextEditingController mainmarket = useTextEditingController();
    TextEditingController othermarket = useTextEditingController();

    TextEditingController account = useTextEditingController();
    TextEditingController category = useTextEditingController();
    TextEditingController languages = useTextEditingController();

    CusApiReq apiReq = CusApiReq();
    void init() async {
      userId.value = await userStateW.getUserId();

      List accountRes =
          await apiReq.postApi(jsonEncode({}), path: "/api/getcurrency");

      List categoryRes =
          await apiReq.postApi(jsonEncode({}), path: "/api/getcategory");

      List languagesRes =
          await apiReq.postApi(jsonEncode({}), path: "/api/getlanguage");

      List mainmarketRes =
          await apiReq.postApi(jsonEncode({}), path: "/api/get-market");

      List othermarketRes =
          await apiReq.postApi(jsonEncode({}), path: "/api/get-market");

      if (accountRes[0]["status"] &&
          categoryRes[0]["status"] &&
          languagesRes[0]["status"] &&
          mainmarketRes[0]["status"] &&
          othermarketRes[0]["status"]) {
        userProfileEditW.setCurrencyList(accountRes[0]["data"]);
        userProfileEditW.setCategoryList(categoryRes[0]["data"]);
        userProfileEditW.setLanguageList(languagesRes[0]["data"]);
        userProfileEditW.setMainmarketList(mainmarketRes[0]["data"]);
        userProfileEditW.setOthermarketList(othermarketRes[0]["data"]);
      } else {
        erroralert(context, "error", "No Record Fount");
      }

      isLoading.value = false;
    }

    useEffect(() {
      init();
      return;
    }, []);

    void mainMarketBox() {
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
                  "Main Market",
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
                        i < userProfileEditW.mainmarketList.length;
                        i++) ...[
                      CheckboxListTile(
                        value: userProfileEditW.selectedMainmarket[i],
                        onChanged: (val) {
                          userProfileEditW.setMainmarket(i, val!);

                          setState(() {});
                        },
                        title: Text(
                            '${userProfileEditW.mainmarketList[i]["name"]}   [ ${userProfileEditW.mainmarketList[i]["code"]} ]'),
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
                          account.clear();
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
                          if (userProfileEditW.mainmarketVal.isNotEmpty) {
                            mainmarket.text =
                                "${userProfileEditW.mainmarketVal[0]["name"]} [${userProfileEditW.mainmarketVal[0]["code"]}]";
                          } else {
                            mainmarket.clear();
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
              ),
            ],
          );
        }),
      );
    }

    void othermarketBox() {
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
                    "Other Market",
                    textScaleFactor: 1,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.85),
                    ),
                  ),
                ),
              ),
              const Divider(),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0;
                        i < userProfileEditW.othermarketList.length;
                        i++) ...[
                      CheckboxListTile(
                        value: userProfileEditW.selectedOthermarket[i],
                        onChanged: (val) {
                          userProfileEditW.setOthermarket(i, val!);
                          setState(() {});
                        },
                        title: Text(
                            '${userProfileEditW.othermarketList[i]["name"]}   [ ${userProfileEditW.othermarketList[i]["code"]} ]'),
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
                          othermarket.clear();
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
                          if (userProfileEditW.othermarketVal.isNotEmpty) {
                            othermarket.text =
                                userProfileEditW.getOthermarketValue();
                          } else {
                            othermarket.clear();
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
          );
        }),
      );
    }

    void accountBox() {
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
                  "Account Currency",
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
                        i < userProfileEditW.currencyList.length;
                        i++) ...[
                      CheckboxListTile(
                        value: userProfileEditW.selectedCurrency[i],
                        onChanged: (val) {
                          userProfileEditW.setCurrency(i, val!);

                          setState(() {});
                        },
                        title: Text(
                            '${userProfileEditW.currencyList[i]["currencyCode"]} ${HtmlUnescape().convert(userProfileEditW.currencyList[i]["currencyAsciiSymbol"])} ${userProfileEditW.currencyList[i]["currencyName"]}'),
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
                          account.clear();
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
                          if (userProfileEditW.currencyVal.isNotEmpty) {
                            account.text =
                                "${userProfileEditW.currencyVal[0]["currencyName"]} [${userProfileEditW.currencyVal[0]["currencyCode"]}]";
                          } else {
                            account.clear();
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
              ),
            ],
          );
        }),
      );
    }

    void categoryBox() {
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
                  "Category",
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
                        i < userProfileEditW.categoryList.length;
                        i++) ...[
                      CheckboxListTile(
                        value: userProfileEditW.selectedCategory[i],
                        onChanged: (val) {
                          userProfileEditW.setCategory(i, val!);
                          setState(() {});
                        },
                        title: Text(
                            '${userProfileEditW.categoryList[i]["categoryName"]}   [ ${userProfileEditW.categoryList[i]["categoryCode"]} ]'),
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
                          category.clear();
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
                          if (userProfileEditW.categoryVal.isNotEmpty) {
                            category.text = userProfileEditW.getCatValue();
                          } else {
                            category.clear();
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
          );
        }),
      );
    }

    void languagesBox() {
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
                  "Languages",
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
                        i < userProfileEditW.languageList.length;
                        i++) ...[
                      CheckboxListTile(
                        value: userProfileEditW.selectedLanguage[i],
                        onChanged: (val) {
                          userProfileEditW.setLanguage(i, val!);
                          setState(() {});
                        },
                        title: Text(
                            '${userProfileEditW.languageList[i]["languageCode"]} ${userProfileEditW.languageList[i]["languageAsciiSymbol"]} ${userProfileEditW.languageList[i]["languageName"]} '),
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
                          languages.clear();
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
                          if (userProfileEditW.languageVal.isNotEmpty) {
                            languages.text = userProfileEditW.getlangValue();
                          } else {
                            languages.clear();
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
                                  "Main Market",
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
                                    controller: mainmarket,
                                    readOnly: true,
                                    onTap: () {
                                      mainMarketBox();
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
                                  "Other Market",
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
                                    controller: othermarket,
                                    readOnly: true,
                                    onTap: () {
                                      othermarketBox();
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
                                  "Account currency",
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
                                    controller: account,
                                    readOnly: true,
                                    onTap: () {
                                      accountBox();
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
                                  "Category",
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
                                    controller: category,
                                    readOnly: true,
                                    onTap: () {
                                      categoryBox();
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
                                  "Languages",
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
                                    controller: languages,
                                    readOnly: true,
                                    onTap: () {
                                      languagesBox();
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
                                              .sectionFourUpdate(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const UserEditFive(),
                                            ),
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
