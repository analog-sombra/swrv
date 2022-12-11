// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:swrv/state/userstate.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/view/home/home.dart';

import '../../services/apirequest.dart';
import '../../state/brandinputstate.dart';
import '../../utils/alerts.dart';
import '../../widgets/componets.dart';
import '../../widgets/buttons.dart';

class BrandInput extends HookConsumerWidget {
  const BrandInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;

    ValueNotifier<String?> name = useState(null);

    final brandInputStateW = ref.watch(brandInputState);
    final userStateW = ref.watch(userState);

    void init() async {
      name.value = await userStateW.getUserName();
    }

    useEffect(() {
      init();
      return null;
    }, []);

    List inputs = [
      const BInput1(),
      const BInput2(),
      const BInput3(),
      const BInput4(),
      const BInput5(),
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
                height: 40,
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
                child: Stack(
                  children: [
                    Container(
                      width: (brandInputStateW.curInput == 0)
                          ? ((width - 60) * 0)
                          : (brandInputStateW.curInput == 1)
                              ? ((width - 60) * 0.2)
                              : (brandInputStateW.curInput == 2)
                                  ? ((width - 60) * 0.4)
                                  : (brandInputStateW.curInput == 3)
                                      ? ((width - 60) * 0.6)
                                      : (brandInputStateW.curInput == 4)
                                          ? ((width - 60) * 0.8)
                                          : ((width - 60)),
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            (brandInputStateW.curInput == 0)
                                ? "0% Completed"
                                : (brandInputStateW.curInput == 1)
                                    ? "20% Completed"
                                    : (brandInputStateW.curInput == 2)
                                        ? "40% Completed"
                                        : (brandInputStateW.curInput == 3)
                                            ? "60% Completed"
                                            : (brandInputStateW.curInput == 4)
                                                ? "80% Completed"
                                                : "100% Completed",
                            textScaleFactor: 1,
                            style: const TextStyle(
                              fontSize: 16,
                              color: secondaryC,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                                  color: (brandInputStateW.curInput >= 0)
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
                                    color: (brandInputStateW.curInput >= 0)
                                        ? Colors.white
                                        : Colors.black.withOpacity(0.6),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  color: (brandInputStateW.curInput >= 1)
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
                                    color: (brandInputStateW.curInput >= 1)
                                        ? Colors.white
                                        : Colors.black.withOpacity(0.6),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  color: (brandInputStateW.curInput >= 2)
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
                                    color: (brandInputStateW.curInput >= 2)
                                        ? Colors.white
                                        : Colors.black.withOpacity(0.6),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  color: (brandInputStateW.curInput >= 3)
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
                                    color: (brandInputStateW.curInput >= 3)
                                        ? Colors.white
                                        : Colors.black.withOpacity(0.6),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  color: (brandInputStateW.curInput >= 4)
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
                                    color: (brandInputStateW.curInput >= 4)
                                        ? Colors.white
                                        : Colors.black.withOpacity(0.6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        inputs[brandInputStateW.curInput],
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
    TextEditingController dob = useTextEditingController();
    TextEditingController info = useTextEditingController();

    final brandInputStateW = ref.watch(brandInputState);
    final userStateW = ref.watch(userState);

    ValueNotifier<String> userId = useState("0");

    void init() async {
      final havebrand = await userStateW.isBrandAdded();

      if (havebrand) {
        final name = await userStateW.getBrandName();
        final code = await userStateW.getBrandCode();
      }

      userId.value = await userStateW.getUserId();

      // final userdata = await userStateW.getUserData(context);
    }

    useEffect(() {
      init();
      return null;
    }, []);

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
                    child: (brandInputStateW.imageFile == null)
                        ? Image.asset("assets/images/user.png")
                        : Image.file(
                            brandInputStateW.imageFile!,
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
                          await brandInputStateW.pickImage(context);
                          final res = await brandInputStateW.uloadAvatar(
                              context,
                              brandInputStateW.imageFile!.path,
                              userId.value);

                          final response = await userStateW.setNewUserData(
                              context, userId.value);

                          if (res && response) {
                            susalert(context, "Uploaded",
                                "Successfully updated profile image");
                          } else {
                            erroralert(context, "Error",
                                "Unable to set image try again");
                          }
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
            "Website",
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
        // const Padding(
        //   padding: EdgeInsets.only(top: 16),
        //   child: Text(
        //     "Brand",
        //     textScaleFactor: 1,
        //     style: TextStyle(
        //       color: Colors.black,
        //       fontSize: 18,
        //       fontWeight: FontWeight.w400,
        //     ),
        //   ),
        // ),
        // InkWell(
        //   onTap: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: ((context) => const CreateBrandPage()),
        //       ),
        //     );
        //   },
        //   child: Padding(
        //     padding: const EdgeInsets.only(top: 5),
        //     child: ClipRRect(
        //       borderRadius: BorderRadius.circular(10),
        //       child: TextField(
        //         enabled: false,
        //         controller: brand,
        //         decoration: const InputDecoration(
        //           filled: true,
        //           fillColor: Color(0xfff3f4f6),
        //           border: InputBorder.none,
        //           focusedBorder: InputBorder.none,
        //           enabledBorder: InputBorder.none,
        //           errorBorder: InputBorder.none,
        //           disabledBorder: InputBorder.none,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
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
              maxLines: 6,
              minLines: 4,
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
            btnFunction: () async {
              if (brandInputStateW.imageFile == null) {
                erroralert(context, "Image", "Please select one image");
              } else {
                final result = await brandInputStateW.userUpdate1(
                  context,
                  [name.text, website.text, info.text, dob.text],
                  userId.value,
                );

                if (result) {
                  brandInputStateW.setCurInput(brandInputStateW.curInput + 1);
                }
              }
            }),
      ],
    );
  }
}

// class BInput2 extends HookConsumerWidget {
//   const BInput2({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     TextEditingController targeted = useTextEditingController();
//     TextEditingController markets = useTextEditingController();
//     TextEditingController age = useTextEditingController();
//     TextEditingController gender = useTextEditingController();
//     TextEditingController category = useTextEditingController();
//     TextEditingController languages = useTextEditingController();

//     final brandInputStateW = ref.watch(brandInputState);

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const Padding(
//           padding: EdgeInsets.only(top: 16),
//           child: Text(
//             "Targeted marked",
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
//               readOnly: true,
//               controller: targeted,
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
//             "Other makets",
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
//               controller: markets,
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
//         Row(
//           children: [
//             Expanded(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.only(top: 16),
//                     child: Text(
//                       "Age",
//                       textScaleFactor: 1,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 5),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: TextField(
//                         controller: category,
//                         decoration: const InputDecoration(
//                           filled: true,
//                           fillColor: Color(0xfff3f4f6),
//                           border: InputBorder.none,
//                           focusedBorder: InputBorder.none,
//                           enabledBorder: InputBorder.none,
//                           errorBorder: InputBorder.none,
//                           disabledBorder: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               width: 20,
//             ),
//             Expanded(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.only(top: 16),
//                     child: Text(
//                       "Gender",
//                       textScaleFactor: 1,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 5),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: TextField(
//                         controller: category,
//                         decoration: const InputDecoration(
//                           filled: true,
//                           fillColor: Color(0xfff3f4f6),
//                           border: InputBorder.none,
//                           focusedBorder: InputBorder.none,
//                           enabledBorder: InputBorder.none,
//                           errorBorder: InputBorder.none,
//                           disabledBorder: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
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
//                   brandInputStateW.setCurInput(brandInputStateW.curInput - 1);
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
//                 btnFunction: () async {
//                   brandInputStateW.setCurInput(brandInputStateW.curInput + 1);
//                 },
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }

// class BInput3 extends HookConsumerWidget {
//   const BInput3({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     TextEditingController city = useTextEditingController();
//     TextEditingController phone = useTextEditingController();

//     final userInputStateW = ref.watch(brandInputState);

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
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
//             "Phone Number",
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
//               controller: phone,
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
//                 btnFunction: () async {
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

class BInput2 extends HookConsumerWidget {
  const BInput2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandInputStateW = ref.watch(brandInputState);
    final userStateW = ref.watch(userState);

    ValueNotifier<String> userId = useState("0");

    TextEditingController mainmarket = useTextEditingController();
    TextEditingController othermarket = useTextEditingController();

    TextEditingController account = useTextEditingController();
    TextEditingController category = useTextEditingController();
    TextEditingController languages = useTextEditingController();

    CusApiReq apiReq = CusApiReq();
    void init() async {
      userId.value = await userStateW.getUserId();

      final req1 = {};
      List accountRes =
          await apiReq.postApi(jsonEncode(req1), path: "/api/getcurrency");

      final req2 = {};
      List categoryRes =
          await apiReq.postApi(jsonEncode(req2), path: "/api/getcategory");
      final req3 = {};
      List languagesRes =
          await apiReq.postApi(jsonEncode(req3), path: "/api/getlanguage");

      final req4 = {};
      List mainmarketRes =
          await apiReq.postApi(jsonEncode(req4), path: "/api/get-market");

      final req5 = {};
      List othermarketRes =
          await apiReq.postApi(jsonEncode(req5), path: "/api/get-market");

      if (accountRes[0]["status"] &&
          categoryRes[0]["status"] &&
          languagesRes[0]["status"] &&
          mainmarketRes[0]["status"] &&
          othermarketRes[0]["status"]) {
        brandInputStateW.setCurrencyList(accountRes[0]["data"]);
        brandInputStateW.setCategoryList(categoryRes[0]["data"]);
        brandInputStateW.setLanguageList(languagesRes[0]["data"]);
        brandInputStateW.setMainmarketList(mainmarketRes[0]["data"]);
        brandInputStateW.setOthermarketList(othermarketRes[0]["data"]);
      } else {
        erroralert(context, "error", "No Record Fount");
      }
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
                        i < brandInputStateW.mainmarketList.length;
                        i++) ...[
                      CheckboxListTile(
                        value: brandInputStateW.selectedMainmarket[i],
                        onChanged: (val) {
                          brandInputStateW.setMainmarket(i, val!);

                          setState(() {});
                        },
                        title: Text(
                            '${brandInputStateW.mainmarketList[i]["name"]}   [ ${brandInputStateW.mainmarketList[i]["code"]} ]'),
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
                          if (brandInputStateW.mainmarketVal.isNotEmpty) {
                            mainmarket.text =
                                "${brandInputStateW.mainmarketVal[0]["name"]} [${brandInputStateW.mainmarketVal[0]["code"]}]";
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
                        i < brandInputStateW.othermarketList.length;
                        i++) ...[
                      CheckboxListTile(
                        value: brandInputStateW.selectedOthermarket[i],
                        onChanged: (val) {
                          brandInputStateW.setOthermarket(i, val!);
                          setState(() {});
                        },
                        title: Text(
                            '${brandInputStateW.othermarketList[i]["name"]}   [ ${brandInputStateW.othermarketList[i]["code"]} ]'),
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
                          if (brandInputStateW.othermarketVal.isNotEmpty) {
                            othermarket.text =
                                brandInputStateW.getOthermarketValue();
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
                        i < brandInputStateW.currencyList.length;
                        i++) ...[
                      CheckboxListTile(
                        value: brandInputStateW.selectedCurrency[i],
                        onChanged: (val) {
                          brandInputStateW.setCurrency(i, val!);

                          setState(() {});
                        },
                        title: Text(
                            '${brandInputStateW.currencyList[i]["currencyName"]}   [ ${brandInputStateW.currencyList[i]["currencyCode"]} ]'),
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
                          if (brandInputStateW.currencyVal.isNotEmpty) {
                            account.text =
                                "${brandInputStateW.currencyVal[0]["currencyName"]} [${brandInputStateW.currencyVal[0]["currencyCode"]}]";
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
                        i < brandInputStateW.categoryList.length;
                        i++) ...[
                      CheckboxListTile(
                        value: brandInputStateW.selectedCategory[i],
                        onChanged: (val) {
                          brandInputStateW.setCategory(i, val!);
                          setState(() {});
                        },
                        title: Text(
                            '${brandInputStateW.categoryList[i]["categoryName"]}   [ ${brandInputStateW.categoryList[i]["categoryCode"]} ]'),
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
                          if (brandInputStateW.categoryVal.isNotEmpty) {
                            category.text = brandInputStateW.getCatValue();
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
                        i < brandInputStateW.languageList.length;
                        i++) ...[
                      CheckboxListTile(
                        value: brandInputStateW.selectedLanguage[i],
                        onChanged: (val) {
                          brandInputStateW.setLanguage(i, val!);
                          setState(() {});
                        },
                        title: Text(
                            '${brandInputStateW.languageList[i]["languageName"]}   [ ${brandInputStateW.languageList[i]["languageCode"]} ]'),
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
                          if (brandInputStateW.languageVal.isNotEmpty) {
                            languages.text = brandInputStateW.getlangValue();
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

    return Column(
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
                  brandInputStateW.setCurInput(brandInputStateW.curInput - 1);
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
                  final restult = await brandInputStateW.userUpdate2(
                    context,
                    userId.value,
                  );

                  if (restult) {
                    brandInputStateW.setCurInput(brandInputStateW.curInput + 1);
                  }
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}

class BInput3 extends HookConsumerWidget {
  const BInput3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandInputStateW = ref.watch(brandInputState);

    CusApiReq apiReq = CusApiReq();

    void init() async {
      final req = {};
      List data =
          await apiReq.postApi(jsonEncode(req), path: "/api/getplatform");
      brandInputStateW.setPlatforms(data[0]["data"]);

      if (data[0]["status"] == false) {
        erroralert(
            context, "Error", "Oops something went wrong please try again");
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < brandInputStateW.platforms.length; i++) ...[
                GestureDetector(
                  onTap: () {
                    brandInputStateW.setSelectPlatform(i);
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: (brandInputStateW.selectedPlatform == i)
                            ? Colors.pink
                            : Colors.transparent,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2), blurRadius: 3)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: brandInputStateW.platforms[i]
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
            if (brandInputStateW.cont.isEmpty) {
              if (brandInputStateW.selectedPlatform != null) {
                brandInputStateW.addControler();
                brandInputStateW.addIsCompleted(false);
                brandInputStateW.addImgUrl(brandInputStateW
                        .platforms[brandInputStateW.selectedPlatform!]
                    ["platformLogoUrl"]);
                brandInputStateW.setNullPlatform();
              } else {
                erroralert(
                    context, "Error", "Please select any platform first");
              }
            } else if (brandInputStateW.cont.last.text == "") {
              erroralert(context, "Error", "Please fill the last field first");
            } else {
              if (brandInputStateW.selectedPlatform != null) {
                brandInputStateW.addControler();

                // cont.value = [...cont.value, TextEditingController()];
                brandInputStateW.addIsCompleted(false);
                brandInputStateW.addImgUrl(brandInputStateW
                        .platforms[brandInputStateW.selectedPlatform!]
                    ["platformLogoUrl"]);
                brandInputStateW.setNullPlatform();
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
        for (int i = 0; i < brandInputStateW.cont.length; i++) ...[
          CusFiels(
            cont: brandInputStateW.cont[i],
            index: i,
            imgUrl: brandInputStateW.imgUrls[i],
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
                  brandInputStateW.setCurInput(brandInputStateW.curInput - 1);
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
                  if (brandInputStateW.imgUrls.isEmpty) {
                    erroralert(context, "Error", "Atleast add one platform");
                  } else {
                    brandInputStateW.setCurInput(brandInputStateW.curInput + 1);
                  }
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
    final brandInputStateW = ref.watch(brandInputState);
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
                  readOnly: brandInputStateW.isCompleted[index],
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
            if (!brandInputStateW.isCompleted[index]) ...[
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
                  onPressed: () async {
                    if (brandInputStateW.cont[index].text == "") {
                      erroralert(context, "Error", "Field can't be empty");
                    } else {
                      final res = await brandInputStateW.addHandal(
                          context,
                          userId.value,
                          brandInputStateW.platforms[index]["id"],
                          brandInputStateW.cont[index].text);
                      if (res) {
                        brandInputStateW.setIsComplted(index, true);
                      }

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

class BInput4 extends HookConsumerWidget {
  const BInput4({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandInputStateW = ref.watch(brandInputState);
    final userStateW = ref.watch(userState);
    ValueNotifier<String> userId = useState("0");

    TextEditingController country = useTextEditingController();
    TextEditingController number = useTextEditingController();
    TextEditingController gender = useTextEditingController();
    TextEditingController city = useTextEditingController();
    TextEditingController address = useTextEditingController();

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
        brandInputStateW.setCountryList(countryRes[0]["data"]);
        brandInputStateW.setCityList(cityRes[0]["data"]);
        log(countryRes.toString());
      } else {
        erroralert(context, "error", "No Record Fount");
      }
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
                        i < brandInputStateW.countryList.length;
                        i++) ...[
                      CheckboxListTile(
                        value: brandInputStateW.selectedCountry[i],
                        onChanged: (val) {
                          brandInputStateW.setCountry(i, val!);
                          setState(() {});
                        },
                        title: Text(
                            '${brandInputStateW.countryList[i]["id"]} ${brandInputStateW.countryList[i]["name"]}   [ ${brandInputStateW.countryList[i]["code"]} ]'),
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
                          if (brandInputStateW.countryVal.isNotEmpty) {
                            country.text =
                                "${brandInputStateW.countryVal[0]["code"]} [${brandInputStateW.countryVal[0]["name"]}]";
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
                        i < brandInputStateW.genderList.length;
                        i++) ...[
                      CheckboxListTile(
                        value: brandInputStateW.selectedGender[i],
                        onChanged: (val) {
                          brandInputStateW.setGender(i, val!);
                          setState(() {});
                        },
                        title: Text('${brandInputStateW.genderList[i]}'),
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
                          gender.clear();
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
                          if (brandInputStateW.genderVal.isNotEmpty) {
                            gender.text = "${brandInputStateW.genderVal[0]}";
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
                    for (int i = 0;
                        i < brandInputStateW.cityList.length;
                        i++) ...[
                      CheckboxListTile(
                        value: brandInputStateW.selectedCity[i],
                        onChanged: (val) {
                          brandInputStateW.setCity(i, val!);
                          setState(() {});
                        },
                        title: Text(
                            '${brandInputStateW.cityList[i]["id"]} ${brandInputStateW.cityList[i]["name"]}   [ ${brandInputStateW.cityList[i]["code"]} ]'),
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
                          city.clear();
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
                          if (brandInputStateW.cityVal.isNotEmpty) {
                            city.text =
                                "${brandInputStateW.cityVal[0]["name"]} [${brandInputStateW.cityVal[0]["code"]}]";
                          } else {
                            city.clear();
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
              decoration: InputDecoration(
                prefixText:  brandInputStateW.countryVal.isEmpty? "0 - ": "${brandInputStateW.countryVal[0]["isd"]} - ",
                prefixStyle: const TextStyle(color: blackC, fontSize: 16),
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
            child: TextField(
              keyboardType: TextInputType.text,
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
                  // userInputStateW.clear();

                  brandInputStateW.setCurInput(brandInputStateW.curInput - 1);
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
                  final result = await brandInputStateW.userUpdate4(
                    context,
                    userId.value,
                    [number.text, gender.text, address.text],
                  );

                  if (result) {
                    brandInputStateW.setCurInput(brandInputStateW.curInput + 1);
                  }
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}

class BInput5 extends HookConsumerWidget {
  const BInput5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController name = useTextEditingController();
    TextEditingController email = useTextEditingController();
    ValueNotifier<String> userId = useState("0");

    final brandInputStateW = ref.watch(brandInputState);
    final userStateW = ref.watch(userState);

    void init() async {
      userId.value = await userStateW.getUserId();
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
            "Name",
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
        const SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            width: 80,
            child: CusBtn(
                btnColor: primaryC,
                btnText: "Invite",
                textSize: 18,
                btnFunction: () {}),
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
                  brandInputStateW.setCurInput(brandInputStateW.curInput - 1);
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
                btnText: "Submit",
                textSize: 18,
                btnFunction: () async {
                  userStateW.clearUserData();

                  final newuser =
                      await userStateW.setNewUserData(context, userId.value);

                  if (newuser) {
                    brandInputStateW.setCurInput(0);

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  }
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
