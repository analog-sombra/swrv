// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart';
import 'package:swrv/services/apirequest.dart';
import 'package:swrv/state/userstate.dart';
import 'package:swrv/utils/alerts.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/view/home/home.dart';

import '../../state/influencerinputstate.dart';
import '../../widgets/componets.dart';
import '../../widgets/buttons.dart';

class InfluencerInput extends HookConsumerWidget {
  const InfluencerInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;

    final userInputStateW = ref.watch(influencerInputState);

    List inputs = [
      const UInput1(),
      const UInput2(),
      const UInput3(),
      const UInput4(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xfff1f5f9),
      body: SafeArea(
        child: SizedBox(
          height: height - statusBarHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Header(),
              const SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 5,
                    )
                  ],
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.topLeft,
                child: Container(
                  width: (userInputStateW.curInput == 0)
                      ? ((width - 60) / 4)
                      : (userInputStateW.curInput == 1)
                          ? ((width - 60) / 2)
                          : (userInputStateW.curInput == 2)
                              ? (width - 60) - (((width - 60) / 2) / 2)
                              : ((width - 60) / 1),
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      (userInputStateW.curInput == 0)
                          ? "25% Completed"
                          : (userInputStateW.curInput == 1)
                              ? "50% Completed"
                              : (userInputStateW.curInput == 2)
                                  ? "75% Completed"
                                  : "100% Completed",
                      textScaleFactor: 1,
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 15, bottom: 10),
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "Welcome",
                            textScaleFactor: 1,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "Thank you for the confirmation, Login with your account and start searching\nfor the brands.",
                            textScaleFactor: 1,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  color: (userInputStateW.curInput >= 0)
                                      ? Colors.pink
                                      : const Color(0xffe5e7eb),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "01",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: (userInputStateW.curInput >= 0)
                                        ? Colors.white
                                        : Colors.black.withOpacity(0.6),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  color: (userInputStateW.curInput >= 1)
                                      ? Colors.pink
                                      : const Color(0xffe5e7eb),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "02",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: (userInputStateW.curInput >= 1)
                                        ? Colors.white
                                        : Colors.black.withOpacity(0.6),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  color: (userInputStateW.curInput >= 2)
                                      ? Colors.pink
                                      : const Color(0xffe5e7eb),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "03",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: (userInputStateW.curInput >= 2)
                                        ? Colors.white
                                        : Colors.black.withOpacity(0.6),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  color: (userInputStateW.curInput >= 3)
                                      ? Colors.pink
                                      : const Color(0xffe5e7eb),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "04",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: (userInputStateW.curInput >= 3)
                                        ? Colors.white
                                        : Colors.black.withOpacity(0.6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        inputs[userInputStateW.curInput],
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UInput1 extends HookConsumerWidget {
  const UInput1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey =
        useMemoized(() => GlobalKey<FormState>());
    ValueNotifier<bool> isLoading = useState(true);

    TextEditingController email = useTextEditingController();
    TextEditingController username = useTextEditingController();
    TextEditingController nickname = useTextEditingController();
    TextEditingController dob = useTextEditingController();
    TextEditingController bio = useTextEditingController();

    final userInputStateW = ref.watch(influencerInputState);
    final userStateW = ref.watch(userState);

    void init() async {
      username.text = await userStateW.getUserName();

      email.text = await userStateW.getUserEmail();
      isLoading.value = false;
    }

    useEffect(() {
      init();
      return null;
    }, []);

    return isLoading.value
        ? const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          )
        : Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xffe5e7eb),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            child: (userInputStateW.imageFile == null)
                                ? Image.asset("assets/images/user.png")
                                : Image.file(
                                    userInputStateW.imageFile!,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                  backgroundColor: const Color(0xff9ca3af),
                                ),
                                onPressed: () async {
                                  userInputStateW.pickImage(context);
                                },
                                child: const Text(
                                  "Upload",
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  "Upload profile photo here.",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                  "The image should either be jpg or jpeg or png format and be a maximum seixe of 4 MB.",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    "Email",
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
                        if (value == null || value.isEmpty || value == "") {
                          return "Please enter the email";
                        }
                        return null;
                      },
                      readOnly: true,
                      controller: email,
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
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    "Username",
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
                        if (value == null || value.isEmpty || value == "") {
                          return "Please enter the username";
                        }
                        return null;
                      },
                      controller: username,
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
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    "Nickname",
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
                        if (value == null || value.isEmpty || value == "") {
                          return "Please enter the nickname";
                        }
                        return null;
                      },
                      controller: nickname,
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
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    "Date of birth",
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
                        if (value == null || value.isEmpty || value == "") {
                          return "Please select the date of birth";
                        }
                        return null;
                      },
                      readOnly: true,
                      controller: dob,
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
                          initialDate: DateTime(DateTime.now().year - 18,
                              DateTime.now().month, DateTime.now().day),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(DateTime.now().year - 18,
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
                        dob.text = DateFormat("dd-MM-yyyy").format(date!);
                      },
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    "Bio",
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
                        if (value == null || value.isEmpty || value == "") {
                          return "Please enter the bio";
                        }
                        return null;
                      },
                      minLines: 4,
                      maxLines: 8,
                      controller: bio,
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
                CusBtn(
                    btnColor: primaryC,
                    btnText: "Next",
                    textSize: 18,
                    btnFunction: () async {
                      isLoading.value = true;

                      if (userInputStateW.imageFile == null) {
                        erroralert(context, "Image", "Please select one image");
                      } else if (formKey.currentState!.validate()) {
                        final result = await userInputStateW.userUpdate1(
                          context,
                          [
                            email.text,
                            username.text,
                            nickname.text,
                            dob.text,
                            bio.text
                          ],
                        );

                        if (result) {
                          userInputStateW
                              .setCurInput(userInputStateW.curInput + 1);
                        }
                      }

                      isLoading.value = false;
                    }),
              ],
            ),
          );
  }
}

class UInput2 extends HookConsumerWidget {
  const UInput2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInputStateW = ref.watch(influencerInputState);
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
        userInputStateW.setCurrencyList(accountRes[0]["data"]);
        userInputStateW.setCategoryList(categoryRes[0]["data"]);
        userInputStateW.setLanguageList(languagesRes[0]["data"]);
        userInputStateW.setMainmarketList(mainmarketRes[0]["data"]);
        userInputStateW.setOthermarketList(othermarketRes[0]["data"]);
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
                        i < userInputStateW.mainmarketList.length;
                        i++) ...[
                      CheckboxListTile(
                        value: userInputStateW.selectedMainmarket[i],
                        onChanged: (val) {
                          userInputStateW.setMainmarket(i, val!);

                          setState(() {});
                        },
                        title: Text(
                            '${userInputStateW.mainmarketList[i]["name"]}   [ ${userInputStateW.mainmarketList[i]["code"]} ]'),
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
                          if (userInputStateW.mainmarketVal.isNotEmpty) {
                            mainmarket.text =
                                "${userInputStateW.mainmarketVal[0]["name"]} [${userInputStateW.mainmarketVal[0]["code"]}]";
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
                        i < userInputStateW.othermarketList.length;
                        i++) ...[
                      CheckboxListTile(
                        value: userInputStateW.selectedOthermarket[i],
                        onChanged: (val) {
                          userInputStateW.setOthermarket(i, val!);
                          setState(() {});
                        },
                        title: Text(
                            '${userInputStateW.othermarketList[i]["name"]}   [ ${userInputStateW.othermarketList[i]["code"]} ]'),
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
                          if (userInputStateW.othermarketVal.isNotEmpty) {
                            othermarket.text =
                                userInputStateW.getOthermarketValue();
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
                        i < userInputStateW.currencyList.length;
                        i++) ...[
                      CheckboxListTile(
                        value: userInputStateW.selectedCurrency[i],
                        onChanged: (val) {
                          userInputStateW.setCurrency(i, val!);

                          setState(() {});
                        },
                        title: Text(
                            '${userInputStateW.currencyList[i]["currencyCode"]} ${HtmlUnescape().convert(userInputStateW.currencyList[i]["currencyAsciiSymbol"])} ${userInputStateW.currencyList[i]["currencyName"]}'),
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
                          if (userInputStateW.currencyVal.isNotEmpty) {
                            account.text =
                                "${userInputStateW.currencyVal[0]["currencyName"]} [${userInputStateW.currencyVal[0]["currencyCode"]}]";
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
                        i < userInputStateW.categoryList.length;
                        i++) ...[
                      CheckboxListTile(
                        value: userInputStateW.selectedCategory[i],
                        onChanged: (val) {
                          userInputStateW.setCategory(i, val!);
                          setState(() {});
                        },
                        title: Text(
                            '${userInputStateW.categoryList[i]["categoryName"]}   [ ${userInputStateW.categoryList[i]["categoryCode"]} ]'),
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
                          if (userInputStateW.categoryVal.isNotEmpty) {
                            category.text = userInputStateW.getCatValue();
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
                        i < userInputStateW.languageList.length;
                        i++) ...[
                      CheckboxListTile(
                        value: userInputStateW.selectedLanguage[i],
                        onChanged: (val) {
                          userInputStateW.setLanguage(i, val!);
                          setState(() {});
                        },
                        title: Text(
                            '${userInputStateW.languageList[i]["languageCode"]} ${userInputStateW.languageList[i]["languageAsciiSymbol"]} ${userInputStateW.languageList[i]["languageName"]} '),
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
                          if (userInputStateW.languageVal.isNotEmpty) {
                            languages.text = userInputStateW.getlangValue();
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

    return isLoading.value
        ? const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
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
                  child: TextField(
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
                  child: TextField(
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
                  child: TextField(
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
                  child: TextField(
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
                  child: TextField(
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
                        // userInputStateW.clear();

                        userInputStateW
                            .setCurInput(userInputStateW.curInput - 1);
                      },
                      textColor: blackC,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CusBtn(
                      btnColor: primaryC,
                      btnText: "Next",
                      textSize: 18,
                      btnFunction: () async {
                        isLoading.value = true;
                        final restult = await userInputStateW.userUpdate2(
                          context,
                          userId.value,
                        );

                        if (restult) {
                          userInputStateW
                              .setCurInput(userInputStateW.curInput + 1);
                        }
                        isLoading.value = false;
                      },
                    ),
                  ),
                ],
              )
            ],
          );
  }
}

class UInput3 extends HookConsumerWidget {
  const UInput3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInputStateW = ref.watch(influencerInputState);

    CusApiReq apiReq = CusApiReq();
    ValueNotifier<bool> isLoading = useState(true);

    void init() async {
      final req = {};
      List data =
          await apiReq.postApi(jsonEncode(req), path: "/api/getplatform");
      userInputStateW.setPlatforms(data[0]["data"]);

      if (data[0]["status"] == false) {
        erroralert(
          context,
          "Error",
          "Oops something went wrong please try again",
        );
      }
      isLoading.value = false;
    }

    useEffect(() {
      init();
      return;
    }, []);

    return isLoading.value
        ? const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
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
                        i < userInputStateW.platforms.length;
                        i++) ...[
                      InkWell(
                        onTap: () {
                          userInputStateW.setSelectPlatform(i);
                          userInputStateW.setPlatfromId(
                              userInputStateW.platforms[i]["id"]);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: (userInputStateW.selectedPlatform == i)
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
                              imageUrl: userInputStateW.platforms[i]
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
                  if (userInputStateW.cont.isEmpty) {
                    if (userInputStateW.selectedPlatform != null) {
                      userInputStateW.addControler();
                      userInputStateW.addIsCompleted(false);
                      userInputStateW.addImgUrl(userInputStateW
                              .platforms[userInputStateW.selectedPlatform!]
                          ["platformLogoUrl"]);
                      userInputStateW.setNullPlatform();
                    } else {
                      erroralert(
                        context,
                        "Error",
                        "Please select any platform first",
                      );
                    }
                  } else if (userInputStateW.cont.last.text == "") {
                    erroralert(
                      context,
                      "Error",
                      "Please fill the last field first",
                    );
                  } else {
                    if (userInputStateW.selectedPlatform != null) {
                      userInputStateW.addControler();

                      userInputStateW.addIsCompleted(false);
                      userInputStateW.addImgUrl(userInputStateW
                              .platforms[userInputStateW.selectedPlatform!]
                          ["platformLogoUrl"]);
                      userInputStateW.setNullPlatform();
                    } else {
                      erroralert(
                          context, "Error", "Please select any platform first");
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
              for (int i = 0; i < userInputStateW.cont.length; i++) ...[
                CusFiels(
                  cont: userInputStateW.cont[i],
                  index: i,
                  imgUrl: userInputStateW.imgUrls[i],
                )
              ],
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
                        userInputStateW
                            .setCurInput(userInputStateW.curInput - 1);
                      },
                      textColor: blackC,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CusBtn(
                      btnColor: primaryC,
                      btnText: "Next",
                      textSize: 18,
                      btnFunction: () async {
                        isLoading.value = true;
                        if (userInputStateW.imgUrls.isEmpty) {
                          erroralert(
                              context, "Error", "Atleast add one platform");
                        } else {
                          // userInputStateW.clear();
                          userInputStateW
                              .setCurInput(userInputStateW.curInput + 1);
                        }
                        isLoading.value = false;
                      },
                    ),
                  ),
                ],
              )
            ],
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
    final userInputStateW = ref.watch(influencerInputState);
    ValueNotifier<String> userId = useState("0");
    final userStateW = ref.watch(userState);
    void init() async {
      userId.value = await userStateW.getUserId();
    }

    useEffect(() {
      init();
      return null;
    }, []);

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
                  readOnly: userInputStateW.isCompleted[index],
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
            if (!userInputStateW.isCompleted[index]) ...[
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
                  onPressed: () {
                    if (userInputStateW.cont[index].text == "") {
                      erroralert(context, "Error", "Field can't be empty");
                    } else {
                      userInputStateW.addHandal(context, userId.value,
                          userInputStateW.cont[index].text);
                      userInputStateW.setIsComplted(index, true);

                      setStat(() {});
                    }
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

class UInput4 extends HookConsumerWidget {
  const UInput4({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInputStateW = ref.watch(influencerInputState);
    final userStateW = ref.watch(userState);
    ValueNotifier<String> userId = useState("0");

    TextEditingController country = useTextEditingController();
    TextEditingController number = useTextEditingController();
    TextEditingController gender = useTextEditingController();
    TextEditingController citySearch = useTextEditingController();
    ValueNotifier<bool> isLoading = useState(true);

    CusApiReq apiReq = CusApiReq();
    void init() async {
      userId.value = await userStateW.getUserId();

      final req1 = {};
      List countryRes =
          await apiReq.postApi(jsonEncode(req1), path: "/api/getcountry");

      final req2 = {};
      List cityRes =
          await apiReq.postApi(jsonEncode(req2), path: "/api/getcity");

      if (countryRes[0]["status"] && cityRes[0]["status"]) {
        userInputStateW.setCountryList(countryRes[0]["data"]);
        userInputStateW.setCityList(cityRes[0]["data"]);
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
                        i < userInputStateW.countryList.length;
                        i++) ...[
                      CheckboxListTile(
                        value: userInputStateW.selectedCountry[i],
                        onChanged: (val) {
                          userInputStateW.setCountry(i, val!);
                          setState(() {});
                        },
                        title: Text(
                            '${userInputStateW.countryList[i]["id"]} ${userInputStateW.countryList[i]["name"]}   [ ${userInputStateW.countryList[i]["code"]} ]'),
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
                          if (userInputStateW.countryVal.isNotEmpty) {
                            country.text =
                                "${userInputStateW.countryVal[0]["name"]} [${userInputStateW.countryVal[0]["code"]}]";
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
                        i < userInputStateW.genderList.length;
                        i++) ...[
                      CheckboxListTile(
                        value: userInputStateW.selectedGender[i],
                        onChanged: (val) {
                          userInputStateW.setGender(i, val!);
                          setState(() {});
                        },
                        title: Text('${userInputStateW.genderList[i]}'),
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
                          if (userInputStateW.genderVal.isNotEmpty) {
                            gender.text = "${userInputStateW.genderVal[0]}";
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
                            i < userInputStateW.cityList.length;
                            i++) ...[
                          CheckboxListTile(
                            value: userInputStateW.selectedCity[i],
                            onChanged: (val) {
                              userInputStateW.setCity(i, val!);
                              setState(() {});
                            },
                            title: Text(
                              '${userInputStateW.cityList[i]["name"]}   [ ${userInputStateW.cityList[i]["code"]} ]',
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
                            if (userInputStateW.cityVal.isNotEmpty) {
                              userInputStateW.setCityValue(
                                  "${userInputStateW.cityVal[0]["name"]} [${userInputStateW.cityVal[0]["code"]}]");
                            } else {
                              userInputStateW.setCityValue(null);
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

    return isLoading.value
        ? const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
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
                  child: TextField(
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
                  child: TextField(
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xfff3f4f6),
                      counterText: "",
                      prefixText: userInputStateW.countryVal.isEmpty
                          ? "0 - "
                          : "${userInputStateW.countryVal[0]["isd"]} - ",
                      prefixStyle: const TextStyle(color: blackC, fontSize: 16),
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
                  child: TextField(
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
                            userInputStateW.resetCitySelection();
                            final req = {"search": citySearch.text};
                            List city = await apiReq.postApi(jsonEncode(req),
                                path: "api/get-city");
                            if (city[0]["status"] == false) {
                              erroralert(context, "Error",
                                  "No city found with this name");
                            } else {
                              userInputStateW.setCityList(city[0]["data"]);
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
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  userInputStateW.cityValue ?? "city is not selected",
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

              // Padding(
              //   padding: const EdgeInsets.only(top: 5),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(10),
              //     child: TextField(
              //       controller: city,
              //       readOnly: true,
              //       onTap: () {
              //         cityBox();
              //       },
              //       decoration: InputDecoration(
              //         suffixIcon: Icon(
              //           Icons.arrow_drop_down,
              //           color: Colors.black.withOpacity(0.8),
              //         ),
              //         filled: true,
              //         fillColor: const Color(0xfff3f4f6),
              //         border: InputBorder.none,
              //         focusedBorder: InputBorder.none,
              //         enabledBorder: InputBorder.none,
              //         errorBorder: InputBorder.none,
              //         disabledBorder: InputBorder.none,
              //       ),
              //     ),
              //   ),
              // ),
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
                        // userInputStateW.clear();

                        userInputStateW
                            .setCurInput(userInputStateW.curInput - 1);
                      },
                      textColor: blackC,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CusBtn(
                      btnColor: primaryC,
                      btnText: "Next",
                      textSize: 18,
                      btnFunction: () async {
                        isLoading.value = true;
                        final result = await userInputStateW.userUpdate4(
                          context,
                          userId.value,
                          [number.text, gender.text],
                        );

                        final newuser = await userStateW.setNewUserData(
                            context, userId.value);

                        if (result && newuser) {
                          userInputStateW.setCurInput(0);

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
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
          );
  }
}
