// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swrv/components/header.dart';
import 'package:swrv/services/apirequest.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/view/user/profile.dart';

class UserInput extends HookConsumerWidget {
  const UserInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SharedPreferences prefs;
    ValueNotifier<String?> name= useState(null);

    void init() async {
      prefs = await SharedPreferences.getInstance();
      String? user = prefs.getString('user');
      name.value = jsonDecode(user!)["userName"];

    }

    useEffect(() {
      init();
      return null;
    }, []);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;

    ValueNotifier<int> curinput = useState(0);
    List inputs = [
      const UInput1(
        name: "karn",
      ),
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
              Header(name: name.value.toString().split("@")[0]),
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
                  width: (curinput.value == 0)
                      ? ((width - 60) / 4)
                      : (curinput.value == 1)
                          ? ((width - 60) / 2)
                          : (curinput.value == 2)
                              ? (width - 60) - (((width - 60) / 2) / 2)
                              : ((width - 60) / 1),
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      (curinput.value == 0)
                          ? "25% Completed"
                          : (curinput.value == 1)
                              ? "50% Completed"
                              : (curinput.value == 2)
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
                              GestureDetector(
                                onTap: () {
                                  curinput.value = 0;
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: (curinput.value >= 0)
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
                                      color: (curinput.value >= 0)
                                          ? Colors.white
                                          : Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  curinput.value = 1;
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: (curinput.value >= 1)
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
                                      color: (curinput.value >= 1)
                                          ? Colors.white
                                          : Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  curinput.value = 2;
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: (curinput.value >= 2)
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
                                      color: (curinput.value >= 2)
                                          ? Colors.white
                                          : Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  curinput.value = 3;
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: (curinput.value >= 3)
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
                                      color: (curinput.value >= 3)
                                          ? Colors.white
                                          : Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        inputs[curinput.value],
                        const SizedBox(
                          height: 10,
                        ),
                        if (curinput.value == 0) ...[
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
                              if (curinput.value < 3) {
                                curinput.value += 1;
                              }
                            },
                            child: const Text(
                              "Next",
                              textScaleFactor: 1,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ] else ...[
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 0,
                                    backgroundColor: const Color(0xffe5e7eb),
                                  ),
                                  onPressed: () {
                                    curinput.value -= 1;
                                  },
                                  child: Text(
                                    "Back",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 0,
                                    backgroundColor: Colors.pink,
                                  ),
                                  onPressed: () {
                                    if (curinput.value < 3) {
                                      curinput.value += 1;
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Profile()));
                                    }
                                  },
                                  child: const Text(
                                    "Next",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
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

class UInput1 extends HookWidget {
  final String name;
  const UInput1({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController email = useTextEditingController();
    TextEditingController username = useTextEditingController();
    TextEditingController nickname = useTextEditingController();

    TextEditingController dob = useTextEditingController();

    ValueNotifier<File?> imageFile = useState(null);
    useEffect(() {
      email.text = name;
      return null;
    }, []);

    Future pickImage() async {
      try {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return;
        final imageTemp = File(image.path);

        imageFile.value = imageTemp;
      } on PlatformException catch (e) {
        log('Failed to pick image: $e');
      }
    }

    return Column(
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
                    child: (imageFile.value == null)
                        ? Image.asset("assets/images/avatar.png")
                        : Image.file(
                            imageFile.value!,
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
                          pickImage();
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
                          "The image shoudl either be jpg or jpeg or png format and be a maximum seixe of 10 MB.",
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
            child: TextField(
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
            child: TextField(
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
            child: TextField(
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
            child: TextField(
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
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

class UInput2 extends HookWidget {
  const UInput2({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<List> accountList = useState([]);
    ValueNotifier<List> categoryList = useState([]);
    ValueNotifier<List> languagesList = useState([]);

    ValueNotifier<List<bool>> accountVal = useState([]);
    ValueNotifier<List<bool>> categoryVal = useState([]);
    ValueNotifier<List<bool>> languagesVal = useState([]);

    ValueNotifier<List> accountSel = useState([]);
    ValueNotifier<List> categorySel = useState([]);
    ValueNotifier<List> languagesSel = useState([]);

    TextEditingController account = useTextEditingController();
    TextEditingController category = useTextEditingController();
    TextEditingController languages = useTextEditingController();

    CusApiReq apiReq = CusApiReq();
    void init() async {
      List accountRes =
          await apiReq.postReq('{\r\n    "f": "currency_list"\r\n}');
      List categoryRes =
          await apiReq.postReq('{\r\n    "f": "category_list"\r\n}');
      List languagesRes =
          await apiReq.postReq('{\r\n    "f": "language_list"\r\n}');

      if (accountRes[0]["status"] &&
          categoryRes[0]["status"] &&
          languagesRes[0]["status"]) {
        accountList.value = accountRes[0]["data"];
        categoryList.value = categoryRes[0]["data"];
        languagesList.value = languagesRes[0]["data"];
      } else {
        var snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error',
            message: "no Record Found",
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      for (int i = 0; i < accountList.value.length; i++) {
        accountVal.value = [...accountVal.value, false];
      }
      for (int i = 0; i < categoryList.value.length; i++) {
        categoryVal.value = [...categoryVal.value, false];
      }
      for (int i = 0; i < languagesList.value.length; i++) {
        languagesVal.value = [...languagesVal.value, false];
      }
    }

    useEffect(() {
      init();
      return;
    }, []);

    void accountBox() {
      showModalBottomSheet(
        backgroundColor: whiteC,
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
                    for (int i = 0; i < accountVal.value.length; i++) ...[
                      CheckboxListTile(
                        value: accountVal.value[i],
                        onChanged: (val) {
                          for (int i = 0; i < accountVal.value.length; i++) {
                            accountVal.value[i] = false;
                          }
                          accountVal.value[i] = val!;

                          accountSel.value = [
                            i,
                            accountList.value[i]["id"],
                            accountList.value[i]["currencyName"],
                            accountList.value[i]["currencyCode"]
                          ];

                          setState(() {});
                        },
                        title: Text(
                            '${accountList.value[i]["currencyName"]}   [ ${accountList.value[i]["currencyCode"]} ]'),
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
                          "Exit",
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
                          account.text =
                              "${accountSel.value[2]} [${accountSel.value[3]}]";
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Conform",
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

    void categoryBox() {
      showModalBottomSheet(
        backgroundColor: whiteC,
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
                    for (int i = 0; i < categoryVal.value.length; i++) ...[
                      CheckboxListTile(
                        value: categoryVal.value[i],
                        onChanged: (val) {
                          categoryVal.value[i] = val!;
                          setState(() {});
                        },
                        title: Text(
                            '${categoryList.value[i]["categoryName"]}   [ ${categoryList.value[i]["categoryCode"]} ]'),
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
                          "Exit",
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
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Conform",
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
                    for (int i = 0; i < languagesVal.value.length; i++) ...[
                      CheckboxListTile(
                        value: languagesVal.value[i],
                        onChanged: (val) {
                          for (int i = 0; i < languagesVal.value.length; i++) {
                            languagesVal.value[i] = false;
                          }
                          languagesVal.value[i] = val!;

                          languagesSel.value = [
                            i,
                            languagesList.value[i]["id"],
                            languagesList.value[i]["languageName"],
                            languagesList.value[i]["languageCode"]
                          ];

                          setState(() {});
                        },
                        title: Text(
                            '${languagesList.value[i]["languageName"]}   [ ${languagesList.value[i]["languageCode"]} ]'),
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
                          "Exit",
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
                          languages.text =
                              "${languagesSel.value[2]} [${languagesSel.value[3]}]";
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Conform",
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
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
      ],
    );
  }
}

class UInput3 extends HookWidget {
  const UInput3({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<List> socialMedia = useState([]);
    CusApiReq apiReq = CusApiReq();

    ValueNotifier<int?> solSel = useState(null);

    ValueNotifier<List<TextEditingController>> cont = useState([]);
    ValueNotifier<List<bool>> isCompleted = useState([]);
    ValueNotifier<List<String>> imgUrls = useState([]);

    void init() async {
      List socialRes =
          await apiReq.postReq('{\r\n    "f": "platform_list"\r\n}');

      if (socialRes[0]["status"]) {
        socialMedia.value = socialRes[0]["data"];
      } else {
        var snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error',
            message: "no Record Found",
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    useEffect(() {
      init();
      return;
    }, []);

    return Column(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (int i = 0; i < socialMedia.value.length - 1; i++) ...[
              GestureDetector(
                onTap: () {
                  solSel.value = i;
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: (solSel.value == i)
                          ? Colors.pink
                          : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2), blurRadius: 5)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Image.network(
                      socialMedia.value[i]["platformLogoUrl"],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ],
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
            if (solSel.value != null) {
              cont.value = [...cont.value, TextEditingController()];
              isCompleted.value = [...isCompleted.value, false];
              imgUrls.value = [
                ...imgUrls.value,
                socialMedia.value[solSel.value!]["platformLogoUrl"]
              ];
            } else {
              var snackBar = SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Error',
                  message: "Please select any platform first",
                  contentType: ContentType.failure,
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            // isOpen.value = true;
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
        for (int i = 0; i < cont.value.length; i++) ...[
          CusFiels(
            cont: cont.value[i],
            isCom: isCompleted,
            index: i,
            imgUrl: imgUrls.value[i],
          )
        ],
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

class CusFiels extends HookWidget {
  final TextEditingController cont;
  final ValueNotifier<List<bool>> isCom;
  final int index;
  final String imgUrl;
  const CusFiels({
    Key? key,
    required this.cont,
    required this.isCom,
    required this.index,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  readOnly: isCom.value[index],
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
            if (!isCom.value[index]) ...[
              Container(
                margin: const EdgeInsets.only(left: 10),
                width: 100,
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
                    isCom.value[index] = true;
                    setStat(() {});
                  },
                  child: const Text(
                    "Done",
                    textScaleFactor: 1,
                    style: TextStyle(fontSize: 18, color: Colors.white),
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

class UInput4 extends HookWidget {
  const UInput4({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController country = useTextEditingController();
    TextEditingController number = useTextEditingController();
    TextEditingController gender = useTextEditingController();
    TextEditingController city = useTextEditingController();

    ValueNotifier<bool> isMale = useState(true);

    ValueNotifier<List> countryList = useState([]);
    ValueNotifier<List> cityList = useState([]);

    ValueNotifier<List<bool>> countryVal = useState([]);
    ValueNotifier<List<bool>> cityVal = useState([]);

    ValueNotifier<List> countrySel = useState([]);
    ValueNotifier<List> citySel = useState([]);

    CusApiReq apiReq = CusApiReq();
    void init() async {
      List countryRes =
          await apiReq.postReq('{\r\n    "f": "country_list"\r\n}');

      List cityRes = await apiReq.postReq('{\r\n    "f": "city_list"\r\n}');

      if (countryRes[0]["status"] && cityRes[0]["status"]) {
        countryList.value = countryRes[0]["data"];
        cityList.value = cityRes[0]["data"];
      } else {
        var snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error',
            message: "no Record Found",
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      for (int i = 0; i < countryList.value.length; i++) {
        countryVal.value = [...countryVal.value, false];
      }

      for (int i = 0; i < cityList.value.length; i++) {
        cityVal.value = [...cityVal.value, false];
      }
    }

    useEffect(() {
      init();
      return;
    }, []);

    void countryBox() {
      showModalBottomSheet(
        backgroundColor: whiteC,
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
                    for (int i = 0; i < countryVal.value.length; i++) ...[
                      CheckboxListTile(
                        value: countryVal.value[i],
                        onChanged: (val) {
                          for (int i = 0; i < countryVal.value.length; i++) {
                            countryVal.value[i] = false;
                          }
                          countryVal.value[i] = val!;

                          countrySel.value = [
                            i,
                            countryList.value[i]["id"],
                            countryList.value[i]["countryName"],
                            countryList.value[i]["countryCode"]
                          ];
                          setState(() {});
                        },
                        title: Text(
                            '${countryList.value[i]["id"]} ${countryList.value[i]["countryName"]}   [ ${countryList.value[i]["countryCode"]} ]'),
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
                          "Exit",
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
                          country.text =
                              "${countrySel.value[2]} [${countrySel.value[3]}]";
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Conform",
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
                    CheckboxListTile(
                      value: isMale.value,
                      onChanged: (val) {
                        isMale.value = true;
                        setState(() {});
                      },
                      title: const Text("Male"),
                    ),
                    CheckboxListTile(
                      value: !isMale.value,
                      onChanged: (val) {
                        isMale.value = false;
                        setState(() {});
                      },
                      title: const Text("Female"),
                    ),
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
                          "Exit",
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
                          gender.text = (isMale.value) ? "Male" : "Female";
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Conform",
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

    void cityBox() {
      showModalBottomSheet(
        backgroundColor: whiteC,
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
                    for (int i = 0; i < cityVal.value.length; i++) ...[
                      CheckboxListTile(
                        value: cityVal.value[i],
                        onChanged: (val) {
                          for (int i = 0; i < cityVal.value.length; i++) {
                            cityVal.value[i] = false;
                          }
                          cityVal.value[i] = val!;

                          citySel.value = [
                            i,
                            cityList.value[i]["id"],
                            cityList.value[i]["cityName"],
                            cityList.value[i]["cityCode"]
                          ];

                          setState(() {});
                        },
                        title: Text(
                            '${cityList.value[i]["id"]} ${cityList.value[i]["cityName"]}   [ ${cityList.value[i]["cityCode"]} ]'),
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
                          "Exit",
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
                          city.text =
                              "${citySel.value[2]} [${citySel.value[3]}]";
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Conform",
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

    return Column(
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
              keyboardType: TextInputType.number,
              controller: number,
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
              controller: city,
              readOnly: true,
              onTap: () {
                cityBox();
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
      ],
    );
  }
}
