// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swrv/components/header.dart';
import 'package:swrv/utils/utilthemes.dart';

import '../../state/userinputstate.dart';
import '../../widgets/cuswidgets.dart';

class BrandInput extends HookConsumerWidget {
  const BrandInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SharedPreferences prefs;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;

    ValueNotifier<String?> name = useState(null);

    final userInputStateW = ref.watch(userInputState);

    void init() async {
      prefs = await SharedPreferences.getInstance();
      String? user = prefs.getString('user');
      name.value = jsonDecode(user!)["userName"];
    }

    useEffect(() {
      init();
      return null;
    }, []);

    List inputs = [
      const BInput1(),
      const BInput1(),
      const BInput1(),
      const BInput1(),
      const BInput1(),
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
                            "Brand input Welcome",
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
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  color: (userInputStateW.curInput >= 4)
                                      ? Colors.pink
                                      : const Color(0xffe5e7eb),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "05",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: (userInputStateW.curInput >= 4)
                                        ? Colors.white
                                        : Colors.black.withOpacity(0.6),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  color: (userInputStateW.curInput >= 5)
                                      ? Colors.pink
                                      : const Color(0xffe5e7eb),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "06",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: (userInputStateW.curInput >= 5)
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

class BInput1 extends HookConsumerWidget {
  const BInput1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController website = useTextEditingController();
    TextEditingController name = useTextEditingController();
    TextEditingController brand = useTextEditingController();
    TextEditingController info = useTextEditingController();

    ValueNotifier<File?> imageFile = useState(null);

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
                        ? Image.asset("assets/images/user.png")
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
            "Company name",
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
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(
            "website",
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
              controller: website,
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
            "Brand",
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
              controller: brand,
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
            "Company info",
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
        const SizedBox(
          height: 15,
        ),
        CusBtn(
            btnColor: primaryC,
            btnText: "Next",
            textSize: 18,
            btnFunction: () async {}),
      ],
    );
  }
}



// class UInput2 extends HookConsumerWidget {
//   const UInput2({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final userInputStateW = ref.watch(userInputState);

//     TextEditingController account = useTextEditingController();
//     TextEditingController category = useTextEditingController();
//     TextEditingController languages = useTextEditingController();

//     CusApiReq apiReq = CusApiReq();
//     void init() async {
//       final req1 = {};
//       List accountRes =
//           await apiReq.postApi(jsonEncode(req1), path: "/api/getcurrency");

//       final req2 = {};
//       List categoryRes =
//           await apiReq.postApi(jsonEncode(req2), path: "/api/getcategory");
//       final req3 = {};
//       List languagesRes =
//           await apiReq.postApi(jsonEncode(req3), path: "/api/getlanguage");

//       if (accountRes[0]["status"] &&
//           categoryRes[0]["status"] &&
//           languagesRes[0]["status"]) {
//         userInputStateW.setCurrencyList(accountRes[0]["data"]);
//         userInputStateW.setCategoryList(categoryRes[0]["data"]);
//         userInputStateW.setLanguageList(languagesRes[0]["data"]);
//       } else {
//         erroralert(context, "error", "No Record Fount");
//       }
//     }

//     useEffect(() {
//       init();
//       return;
//     }, []);

//     void accountBox() {
//       showModalBottomSheet(
//         backgroundColor: whiteC,
//         isDismissible: false,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
//         context: context,
//         builder: (context) => StatefulBuilder(builder: (context, setState) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 margin: const EdgeInsets.symmetric(vertical: 10),
//                 child: Center(
//                     child: Text(
//                   "Account Currency",
//                   textScaleFactor: 1,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black.withOpacity(0.85),
//                   ),
//                 )),
//               ),
//               const Divider(),
//               Expanded(
//                   child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     for (int i = 0;
//                         i < userInputStateW.currencyList.length;
//                         i++) ...[
//                       CheckboxListTile(
//                         value: userInputStateW.selectedCurrency[i],
//                         onChanged: (val) {
//                           userInputStateW.setCurrency(i, val!);

//                           setState(() {});
//                         },
//                         title: Text(
//                             '${userInputStateW.currencyList[i]["currencyName"]}   [ ${userInputStateW.currencyList[i]["currencyCode"]} ]'),
//                       )
//                     ]
//                   ],
//                 ),
//               )),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           elevation: 0,
//                           backgroundColor: const Color(0xffef4444),
//                         ),
//                         onPressed: () {
//                           account.clear();
//                           Navigator.pop(context);
//                         },
//                         child: const Text(
//                           "Clear",
//                           textAlign: TextAlign.center,
//                           textScaleFactor: 1,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 15),
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             elevation: 0,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             backgroundColor: const Color(0xff22c55e)),
//                         onPressed: () {
//                           if (userInputStateW.currencyVal.isNotEmpty) {
//                             account.text =
//                                 "${userInputStateW.currencyVal[0]["currencyName"]} [${userInputStateW.currencyVal[0]["currencyCode"]}]";
//                           } else {
//                             account.clear();
//                           }
//                           setState(() {});
//                           Navigator.pop(context);
//                         },
//                         child: const Text(
//                           "Conform",
//                           textAlign: TextAlign.center,
//                           textScaleFactor: 1,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         }),
//       );
//     }

//     void categoryBox() {
//       showModalBottomSheet(
//         backgroundColor: whiteC,
//         isDismissible: false,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
//         context: context,
//         builder: (context) => StatefulBuilder(builder: (context, setState) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 margin: const EdgeInsets.symmetric(vertical: 10),
//                 child: Center(
//                     child: Text(
//                   "Category",
//                   textScaleFactor: 1,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black.withOpacity(0.85),
//                   ),
//                 )),
//               ),
//               const Divider(),
//               Expanded(
//                   child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     for (int i = 0;
//                         i < userInputStateW.categoryList.length;
//                         i++) ...[
//                       CheckboxListTile(
//                         value: userInputStateW.selectedCategory[i],
//                         onChanged: (val) {
//                           userInputStateW.setCategory(i, val!);
//                           setState(() {});
//                         },
//                         title: Text(
//                             '${userInputStateW.categoryList[i]["categoryName"]}   [ ${userInputStateW.categoryList[i]["categoryCode"]} ]'),
//                       )
//                     ]
//                   ],
//                 ),
//               )),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           elevation: 0,
//                           backgroundColor: const Color(0xffef4444),
//                         ),
//                         onPressed: () {
//                           category.clear();
//                           Navigator.pop(context);
//                         },
//                         child: const Text(
//                           "Clear",
//                           textAlign: TextAlign.center,
//                           textScaleFactor: 1,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 15),
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             elevation: 0,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             backgroundColor: const Color(0xff22c55e)),
//                         onPressed: () {
//                           if (userInputStateW.categoryVal.isNotEmpty) {
//                             category.text = userInputStateW.getCatValue();
//                           } else {
//                             category.clear();
//                           }
//                           Navigator.pop(context);
//                         },
//                         child: const Text(
//                           "Conform",
//                           textAlign: TextAlign.center,
//                           textScaleFactor: 1,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           );
//         }),
//       );
//     }

//     void languagesBox() {
//       showModalBottomSheet(
//         backgroundColor: whiteC,
//         isDismissible: false,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
//         context: context,
//         builder: (context) => StatefulBuilder(builder: (context, setState) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 margin: const EdgeInsets.symmetric(vertical: 10),
//                 child: Center(
//                     child: Text(
//                   "Languages",
//                   textScaleFactor: 1,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black.withOpacity(0.85),
//                   ),
//                 )),
//               ),
//               const Divider(),
//               Expanded(
//                   child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     for (int i = 0;
//                         i < userInputStateW.languageList.length;
//                         i++) ...[
//                       CheckboxListTile(
//                         value: userInputStateW.selectedLanguage[i],
//                         onChanged: (val) {
//                           userInputStateW.setLanguage(i, val!);
//                           setState(() {});
//                         },
//                         title: Text(
//                             '${userInputStateW.languageList[i]["languageName"]}   [ ${userInputStateW.languageList[i]["languageCode"]} ]'),
//                       )
//                     ]
//                   ],
//                 ),
//               )),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           elevation: 0,
//                           backgroundColor: const Color(0xffef4444),
//                         ),
//                         onPressed: () {
//                           languages.clear();
//                           Navigator.pop(context);
//                         },
//                         child: const Text(
//                           "Clear",
//                           textAlign: TextAlign.center,
//                           textScaleFactor: 1,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 15),
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             elevation: 0,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             backgroundColor: const Color(0xff22c55e)),
//                         onPressed: () {
//                           if (userInputStateW.languageVal.isNotEmpty) {
//                             languages.text =
//                                 "${userInputStateW.languageVal[0]["languageName"]} [${userInputStateW.languageVal[0]["languageCode"]}]";
//                           } else {
//                             languages.clear();
//                           }
//                           setState(() {});
//                           Navigator.pop(context);
//                         },
//                         child: const Text(
//                           "Conform",
//                           textAlign: TextAlign.center,
//                           textScaleFactor: 1,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           );
//         }),
//       );
//     }

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const Padding(
//           padding: EdgeInsets.only(top: 16),
//           child: Text(
//             "Account currency",
//             textScaleFactor: 1,
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 18,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 5),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: TextField(
//               controller: account,
//               readOnly: true,
//               onTap: () {
//                 accountBox();
//               },
//               decoration: InputDecoration(
//                 suffixIcon: Icon(
//                   Icons.arrow_drop_down,
//                   color: Colors.black.withOpacity(0.8),
//                 ),
//                 filled: true,
//                 fillColor: const Color(0xfff3f4f6),
//                 border: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//                 enabledBorder: InputBorder.none,
//                 errorBorder: InputBorder.none,
//                 disabledBorder: InputBorder.none,
//               ),
//             ),
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.only(top: 16),
//           child: Text(
//             "Category",
//             textScaleFactor: 1,
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 18,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 5),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: TextField(
//               controller: category,
//               readOnly: true,
//               onTap: () {
//                 categoryBox();
//               },
//               decoration: InputDecoration(
//                 suffixIcon: Icon(
//                   Icons.arrow_drop_down,
//                   color: Colors.black.withOpacity(0.8),
//                 ),
//                 filled: true,
//                 fillColor: const Color(0xfff3f4f6),
//                 border: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//                 enabledBorder: InputBorder.none,
//                 errorBorder: InputBorder.none,
//                 disabledBorder: InputBorder.none,
//               ),
//             ),
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.only(top: 16),
//           child: Text(
//             "Languages",
//             textScaleFactor: 1,
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 18,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 5),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: TextField(
//               controller: languages,
//               readOnly: true,
//               onTap: () {
//                 languagesBox();
//               },
//               decoration: InputDecoration(
//                 suffixIcon: Icon(
//                   Icons.arrow_drop_down,
//                   color: Colors.black.withOpacity(0.8),
//                 ),
//                 filled: true,
//                 fillColor: const Color(0xfff3f4f6),
//                 border: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//                 enabledBorder: InputBorder.none,
//                 errorBorder: InputBorder.none,
//                 disabledBorder: InputBorder.none,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 15,
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: CusBtn(
//                 btnColor: backgroundC,
//                 btnText: "Back",
//                 textSize: 18,
//                 btnFunction: () {
//                   userInputStateW.setCurInput(userInputStateW.curInput - 1);
//                 },
//                 textColor: blackC,
//               ),
//             ),
//             const SizedBox(
//               width: 20,
//             ),
//             Expanded(
//               child: CusBtn(
//                 btnColor: primaryC,
//                 btnText: "Next",
//                 textSize: 18,
//                 btnFunction: () {
//                   userInputStateW.setCurInput(userInputStateW.curInput + 1);
//                 },
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }

// class UInput3 extends HookConsumerWidget {
//   const UInput3({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final userInputStateW = ref.watch(userInputState);

//     CusApiReq apiReq = CusApiReq();

//     void init() async {
//       try {
//         final req = {};
//         List data =
//             await apiReq.postApi(jsonEncode(req), path: "/api/getplatform");
//         userInputStateW.setPlatforms(data[0]["data"]);

//         if (data[0]["status"] == false) {
//           erroralert(
//               context, "Error", "Oops something went wrong please try again");
//         }
//       } catch (e) {
//         log(e.toString());
//       }
//     }

//     useEffect(() {
//       init();
//       return;
//     }, []);

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const Padding(
//           padding: EdgeInsets.only(top: 16),
//           child: Text(
//             "Channels",
//             textScaleFactor: 1,
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 15,
//         ),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               for (int i = 0; i < userInputStateW.platforms.length; i++) ...[
//                 GestureDetector(
//                   onTap: () {
//                     userInputStateW.setSelectPlatform(i);
//                   },
//                   child: Container(
//                     margin:
//                         const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: (userInputStateW.selectedPlatform == i)
//                             ? Colors.pink
//                             : Colors.transparent,
//                         width: 2,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                             color: Colors.black.withOpacity(0.2), blurRadius: 3)
//                       ],
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     width: 50,
//                     height: 50,
//                     padding: const EdgeInsets.all(10),
//                     child: Center(
//                       child: CachedNetworkImage(
//                         imageUrl: userInputStateW.platforms[i]
//                             ["platformLogoUrl"],
//                         placeholder: (context, url) =>
//                             const CircularProgressIndicator(),
//                         errorWidget: (context, url, error) =>
//                             const Icon(Icons.error),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             minimumSize: const Size.fromHeight(40),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             elevation: 0,
//             backgroundColor: Colors.pink,
//           ),
//           onPressed: () {
//             if (userInputStateW.cont.isEmpty) {
//               if (userInputStateW.selectedPlatform != null) {
//                 userInputStateW.addControler();
//                 userInputStateW.addIsCompleted(false);
//                 userInputStateW.addImgUrl(
//                     userInputStateW.platforms[userInputStateW.selectedPlatform!]
//                         ["platformLogoUrl"]);
//                 userInputStateW.setNullPlatform();
//               } else {
//                 erroralert(
//                     context, "Error", "Please select any platform first");
//               }
//             } else if (userInputStateW.cont.last.text == "") {
//               erroralert(context, "Error", "Please fill the last field first");
//             } else {
//               if (userInputStateW.selectedPlatform != null) {
//                 userInputStateW.addControler();

//                 // cont.value = [...cont.value, TextEditingController()];
//                 userInputStateW.addIsCompleted(false);
//                 userInputStateW.addImgUrl(
//                     userInputStateW.platforms[userInputStateW.selectedPlatform!]
//                         ["platformLogoUrl"]);
//                 userInputStateW.setNullPlatform();
//               } else {
//                 erroralert(
//                     context, "Error", "Please select any platform first");
//               }
//             }
//           },
//           child: const Text(
//             "Add new Channel",
//             textScaleFactor: 1,
//             style: TextStyle(fontSize: 18, color: Colors.white),
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         for (int i = 0; i < userInputStateW.cont.length; i++) ...[
//           CusFiels(
//             cont: userInputStateW.cont[i],
//             index: i,
//             imgUrl: userInputStateW.imgUrls[i],
//           )
//         ],
//         const SizedBox(
//           height: 15,
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: CusBtn(
//                 btnColor: backgroundC,
//                 btnText: "Back",
//                 textSize: 18,
//                 btnFunction: () {
//                   userInputStateW.setCurInput(userInputStateW.curInput - 1);
//                 },
//                 textColor: blackC,
//               ),
//             ),
//             const SizedBox(
//               width: 20,
//             ),
//             Expanded(
//               child: CusBtn(
//                 btnColor: primaryC,
//                 btnText: "Next",
//                 textSize: 18,
//                 btnFunction: () {
//                   userInputStateW.setCurInput(userInputStateW.curInput + 1);
//                 },
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }

// class CusFiels extends HookConsumerWidget {
//   final TextEditingController cont;
//   // final ValueNotifier<List<bool>> isCom;
//   final int index;
//   final String imgUrl;
//   const CusFiels({
//     Key? key,
//     required this.cont,
//     // required this.isCom,
//     required this.index,
//     required this.imgUrl,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final userInputStateW = ref.watch(userInputState);

//     return StatefulBuilder(builder: (context, setStat) {
//       return Container(
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 5),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.transparent,
//                   width: 2,
//                 ),
//                 boxShadow: [
//                   BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)
//                 ],
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               width: 40,
//               height: 40,
//               padding: const EdgeInsets.all(10),
//               child: Center(
//                 child: Image.network(
//                   imgUrl,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: TextField(
//                   controller: cont,
//                   readOnly: userInputStateW.isCompleted[index],
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: const Color(0xfff3f4f6),
//                     border: InputBorder.none,
//                     focusedBorder: InputBorder.none,
//                     enabledBorder: InputBorder.none,
//                     errorBorder: InputBorder.none,
//                     disabledBorder: InputBorder.none,
//                     hintText: "Enter your username",
//                     hintStyle: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.black.withOpacity(0.65),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             if (!userInputStateW.isCompleted[index]) ...[
//               Container(
//                 margin: const EdgeInsets.only(left: 10),
//                 width: 80,
//                 height: 45,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     elevation: 0,
//                     backgroundColor: Colors.pink,
//                   ),
//                   onPressed: () {
//                     userInputStateW.setIsComplted(index, true);
//                     // isCom.value[index] = true;
//                     setStat(() {});
//                   },
//                   child: const Text(
//                     "Done",
//                     textScaleFactor: 1,
//                     style: TextStyle(fontSize: 20, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       );
//     });
//   }
// }

// class UInput4 extends HookConsumerWidget {
//   const UInput4({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final userInputStateW = ref.watch(userInputState);

//     TextEditingController country = useTextEditingController();
//     TextEditingController number = useTextEditingController();
//     TextEditingController gender = useTextEditingController();
//     TextEditingController city = useTextEditingController();

//     ValueNotifier<bool> isMale = useState(true);

//     CusApiReq apiReq = CusApiReq();
//     void init() async {
//       final req1 = {};
//       List countryRes =
//           await apiReq.postApi(jsonEncode(req1), path: "/api/getcountry");

//       final req2 = {};
//       List cityRes =
//           await apiReq.postApi(jsonEncode(req2), path: "/api/getcity");

//       if (countryRes[0]["status"] && cityRes[0]["status"]) {
//         userInputStateW.setCountryList(countryRes[0]["data"]);
//         userInputStateW.setCityList(cityRes[0]["data"]);
//       } else {
//         erroralert(context, "error", "No Record Fount");
//       }
//     }

//     useEffect(() {
//       init();
//       return;
//     }, []);

//     void countryBox() {
//       showModalBottomSheet(
//         backgroundColor: whiteC,
//         isDismissible: false,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
//         context: context,
//         builder: (context) => StatefulBuilder(builder: (context, setState) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 margin: const EdgeInsets.symmetric(vertical: 10),
//                 child: Center(
//                     child: Text(
//                   "Country",
//                   textScaleFactor: 1,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black.withOpacity(0.85),
//                   ),
//                 )),
//               ),
//               const Divider(),
//               Expanded(
//                   child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     for (int i = 0;
//                         i < userInputStateW.countryList.length;
//                         i++) ...[
//                       CheckboxListTile(
//                         value: userInputStateW.selectedCountry[i],
//                         onChanged: (val) {
//                           userInputStateW.setCountry(i, val!);
//                           setState(() {});
//                         },
//                         title: Text(
//                             '${userInputStateW.countryList[i]["id"]} ${userInputStateW.countryList[i]["countryName"]}   [ ${userInputStateW.countryList[i]["countryCode"]} ]'),
//                       )
//                     ]
//                   ],
//                 ),
//               )),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           elevation: 0,
//                           backgroundColor: const Color(0xffef4444),
//                         ),
//                         onPressed: () {
//                           country.clear();
//                           Navigator.pop(context);
//                         },
//                         child: const Text(
//                           "Clear",
//                           textAlign: TextAlign.center,
//                           textScaleFactor: 1,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 15),
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             elevation: 0,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             backgroundColor: const Color(0xff22c55e)),
//                         onPressed: () {
//                           if (userInputStateW.countryVal.isNotEmpty) {
//                             country.text =
//                                 "${userInputStateW.countryVal[0]["countryName"]} [${userInputStateW.countryVal[0]["countryCode"]}]";
//                           } else {
//                             country.clear();
//                           }
//                           setState(() {});
//                           Navigator.pop(context);
//                         },
//                         child: const Text(
//                           "Conform",
//                           textAlign: TextAlign.center,
//                           textScaleFactor: 1,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           );
//         }),
//       );
//     }

//     void genderBox() {
//       showModalBottomSheet(
//         backgroundColor: whiteC,
//         isDismissible: false,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
//         context: context,
//         builder: (context) => StatefulBuilder(builder: (context, setState) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 margin: const EdgeInsets.symmetric(vertical: 10),
//                 child: Center(
//                     child: Text(
//                   "Country",
//                   textScaleFactor: 1,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black.withOpacity(0.85),
//                   ),
//                 )),
//               ),
//               const Divider(),
//               Expanded(
//                   child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     CheckboxListTile(
//                       value: isMale.value,
//                       onChanged: (val) {
//                         isMale.value = true;
//                         setState(() {});
//                       },
//                       title: const Text("Male"),
//                     ),
//                     CheckboxListTile(
//                       value: !isMale.value,
//                       onChanged: (val) {
//                         isMale.value = false;
//                         setState(() {});
//                       },
//                       title: const Text("Female"),
//                     ),
//                   ],
//                 ),
//               )),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           elevation: 0,
//                           backgroundColor: const Color(0xffef4444),
//                         ),
//                         onPressed: () {
//                           gender.clear();
//                           Navigator.pop(context);
//                         },
//                         child: const Text(
//                           "Clear",
//                           textAlign: TextAlign.center,
//                           textScaleFactor: 1,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 15),
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             elevation: 0,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             backgroundColor: const Color(0xff22c55e)),
//                         onPressed: () {
//                           gender.text = (isMale.value) ? "Male" : "Female";
//                           setState(() {});
//                           Navigator.pop(context);
//                         },
//                         child: const Text(
//                           "Conform",
//                           textAlign: TextAlign.center,
//                           textScaleFactor: 1,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           );
//         }),
//       );
//     }

//     void cityBox() {
//       showModalBottomSheet(
//         backgroundColor: whiteC,
//         isDismissible: false,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
//         context: context,
//         builder: (context) => StatefulBuilder(builder: (context, setState) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 margin: const EdgeInsets.symmetric(vertical: 10),
//                 child: Center(
//                     child: Text(
//                   "City",
//                   textScaleFactor: 1,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black.withOpacity(0.85),
//                   ),
//                 )),
//               ),
//               const Divider(),
//               Expanded(
//                   child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     for (int i = 0;
//                         i < userInputStateW.cityList.length;
//                         i++) ...[
//                       CheckboxListTile(
//                         value: userInputStateW.selectedCity[i],
//                         onChanged: (val) {
//                           userInputStateW.setCity(i, val!);
//                           setState(() {});
//                         },
//                         title: Text(
//                             '${userInputStateW.cityList[i]["id"]} ${userInputStateW.cityList[i]["cityName"]}   [ ${userInputStateW.cityList[i]["cityCode"]} ]'),
//                       )
//                     ]
//                   ],
//                 ),
//               )),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           elevation: 0,
//                           backgroundColor: const Color(0xffef4444),
//                         ),
//                         onPressed: () {
//                           city.clear();
//                           Navigator.pop(context);
//                         },
//                         child: const Text(
//                           "Clear",
//                           textAlign: TextAlign.center,
//                           textScaleFactor: 1,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 15),
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             elevation: 0,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             backgroundColor: const Color(0xff22c55e)),
//                         onPressed: () {
//                           if (userInputStateW.cityVal.isNotEmpty) {
//                             city.text =
//                                 "${userInputStateW.cityVal[0]["cityName"]} [${userInputStateW.cityVal[0]["cityCode"]}]";
//                           } else {
//                             city.clear();
//                           }

//                           Navigator.pop(context);
//                         },
//                         child: const Text(
//                           "Conform",
//                           textAlign: TextAlign.center,
//                           textScaleFactor: 1,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           );
//         }),
//       );
//     }

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const Padding(
//           padding: EdgeInsets.only(top: 16),
//           child: Text(
//             "Country",
//             textScaleFactor: 1,
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 18,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 5),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: TextField(
//               controller: country,
//               readOnly: true,
//               onTap: () {
//                 countryBox();
//               },
//               decoration: InputDecoration(
//                 suffixIcon: Icon(
//                   Icons.arrow_drop_down,
//                   color: Colors.black.withOpacity(0.8),
//                 ),
//                 filled: true,
//                 fillColor: const Color(0xfff3f4f6),
//                 border: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//                 enabledBorder: InputBorder.none,
//                 errorBorder: InputBorder.none,
//                 disabledBorder: InputBorder.none,
//               ),
//             ),
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.only(top: 16),
//           child: Text(
//             "Phone number",
//             textScaleFactor: 1,
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 18,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 5),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: TextField(
//               keyboardType: TextInputType.number,
//               controller: number,
//               decoration: const InputDecoration(
//                 filled: true,
//                 fillColor: Color(0xfff3f4f6),
//                 border: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//                 enabledBorder: InputBorder.none,
//                 errorBorder: InputBorder.none,
//                 disabledBorder: InputBorder.none,
//               ),
//             ),
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.only(top: 16),
//           child: Text(
//             "Gender",
//             textScaleFactor: 1,
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 18,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 5),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: TextField(
//               onTap: () {
//                 genderBox();
//               },
//               readOnly: true,
//               controller: gender,
//               decoration: InputDecoration(
//                 suffixIcon: Icon(
//                   Icons.arrow_drop_down,
//                   color: Colors.black.withOpacity(0.8),
//                 ),
//                 filled: true,
//                 fillColor: const Color(0xfff3f4f6),
//                 border: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//                 enabledBorder: InputBorder.none,
//                 errorBorder: InputBorder.none,
//                 disabledBorder: InputBorder.none,
//               ),
//             ),
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.only(top: 16),
//           child: Text(
//             "City",
//             textScaleFactor: 1,
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 18,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 5),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: TextField(
//               controller: city,
//               readOnly: true,
//               onTap: () {
//                 cityBox();
//               },
//               decoration: InputDecoration(
//                 suffixIcon: Icon(
//                   Icons.arrow_drop_down,
//                   color: Colors.black.withOpacity(0.8),
//                 ),
//                 filled: true,
//                 fillColor: const Color(0xfff3f4f6),
//                 border: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//                 enabledBorder: InputBorder.none,
//                 errorBorder: InputBorder.none,
//                 disabledBorder: InputBorder.none,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 15,
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: CusBtn(
//                 btnColor: backgroundC,
//                 btnText: "Back",
//                 textSize: 18,
//                 btnFunction: () {
//                   userInputStateW.setCurInput(userInputStateW.curInput - 1);
//                 },
//                 textColor: blackC,
//               ),
//             ),
//             const SizedBox(
//               width: 20,
//             ),
//             Expanded(
//               child: CusBtn(
//                 btnColor: primaryC,
//                 btnText: "Next",
//                 textSize: 18,
//                 btnFunction: () {
//                   // userInputStateW.setCurInput(userInputStateW.curInput + 1);
//                 },
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }