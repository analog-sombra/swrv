// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../services/apirequest.dart';
import '../../state/brand/createbrandstate.dart';
import '../../state/userstate.dart';
import '../../utils/alerts.dart';
import '../../utils/utilthemes.dart';
import '../../widgets/componets.dart';
import '../../widgets/buttons.dart';

class CreateBrandPage extends HookConsumerWidget {
  const CreateBrandPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    TextEditingController name = useTextEditingController();
    TextEditingController code = useTextEditingController();
    TextEditingController address = useTextEditingController();
    TextEditingController email = useTextEditingController();
    TextEditingController contact = useTextEditingController();
    TextEditingController info = useTextEditingController();

    ValueNotifier<String> userId = useState("0");

    final createBrandSW = ref.watch(createBrandState);
    final userStateW = ref.watch(userState);

    CusApiReq apiReq = CusApiReq();

    void init() async {
      userId.value = await userStateW.getUserId();
      final req4 = {};
      List city = await apiReq.postApi(jsonEncode(req4), path: "api/getcity");

      if (city[0]["status"]) {
        createBrandSW.setCity(city[0]["data"]);
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
                  "Create brand",
                  textScaleFactor: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600, color: blackC),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 25, top: 10),
                child: Text(
                  "Here you can create brand that you are like.",
                  textScaleFactor: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400, color: blackC),
                ),
              ),
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
                      cusTitle("Brand name"),
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
                      cusTitle("Brand code"),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: TextField(
                            controller: code,
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
                      cusTitle("Brand address"),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: TextField(
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
                      cusTitle("Brand email"),
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
                      // cusTitle("Brand logo"),
                      // Container(
                      //   margin: const EdgeInsets.symmetric(vertical: 10),
                      //   padding: const EdgeInsets.all(10),
                      //   decoration: BoxDecoration(
                      //     color: const Color(0xffe5e7eb),
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         flex: 1,
                      //         child: ClipRRect(
                      //           borderRadius: BorderRadius.circular(10),
                      //           child: SizedBox(
                      //             width: 80,
                      //             height: 80,
                      //             child: (imageFile.value == null)
                      //                 ? Image.asset("assets/images/user.png")
                      //                 : Image.file(
                      //                     imageFile.value!,
                      //                     fit: BoxFit.cover,
                      //                   ),
                      //           ),
                      //         ),
                      //       ),
                      //       Expanded(
                      //         flex: 3,
                      //         child: Container(
                      //           padding: const EdgeInsets.all(10),
                      //           child: Column(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               ElevatedButton(
                      //                 style: ElevatedButton.styleFrom(
                      //                   minimumSize: const Size.fromHeight(40),
                      //                   shape: RoundedRectangleBorder(
                      //                     borderRadius: BorderRadius.circular(10),
                      //                   ),
                      //                   elevation: 0,
                      //                   backgroundColor: const Color(0xff9ca3af),
                      //                 ),
                      //                 onPressed: () async {
                      //                   // pickImage();

                      //                   await pickImage();
                      //                   if (imageFile.value == null) {
                      //                     erroralert(context, "Logo",
                      //                         "Please Upload Logo");
                      //                   } else {
                      //                     await createBrandSW.uploadLogo(
                      //                       context,
                      //                       imageFile.value!.path,
                      //                     );
                      //                   }
                      //                 },
                      //                 child: const Text(
                      //                   "Upload",
                      //                   textAlign: TextAlign.center,
                      //                   textScaleFactor: 1,
                      //                   style: TextStyle(
                      //                       color: Colors.white,
                      //                       fontSize: 16,
                      //                       fontWeight: FontWeight.w500),
                      //                 ),
                      //               ),
                      //               Padding(
                      //                 padding: const EdgeInsets.only(top: 5),
                      //                 child: Text(
                      //                   "Upload brand photo here.",
                      //                   textScaleFactor: 1,
                      //                   style: TextStyle(
                      //                     color: Colors.black.withOpacity(0.5),
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.w500,
                      //                   ),
                      //                 ),
                      //               ),
                      //               Padding(
                      //                 padding: const EdgeInsets.only(top: 2),
                      //                 child: Text(
                      //                   "The image should either be jpg or jpeg or png format and be a maximum seixe of 10 MB.",
                      //                   textScaleFactor: 1,
                      //                   style: TextStyle(
                      //                     color: Colors.black.withOpacity(0.5),
                      //                     fontSize: 10,
                      //                     fontWeight: FontWeight.w400,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      cusTitle("Brand Contact"),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: TextField(
                            controller: contact,
                            keyboardType: TextInputType.number,
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
                      cusTitle("Brand info"),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: TextField(
                            controller: info,
                            maxLines: 8,
                            minLines: 4,
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
                      cusTitle("Brand city"),
                      if (createBrandSW.cityList.isEmpty) ...[
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
                              value: createBrandSW.cityValue,
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                              items: [
                                for (int i = 0;
                                    i < createBrandSW.cityList.length;
                                    i++) ...[
                                  DropdownMenuItem(
                                    onTap: () {
                                      createBrandSW.setCityId(i);
                                    },
                                    value: createBrandSW.cityList[i]
                                        ["cityName"],
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
                                        "[${createBrandSW.cityList[i]["cityCode"]}] ${createBrandSW.cityList[i]["cityName"]}",
                                        textScaleFactor: 1,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ]
                              ],
                              onChanged: (newval) {
                                createBrandSW.setCityValue(newval!);
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
                          btnText: "Create Brand",
                          textSize: 18,
                          btnFunction: () async {
                            final response = await createBrandSW.createBrand(
                              context,
                              [
                                name.text,
                                code.text,
                                address.text,
                                email.text,
                                contact.text,
                                info.text,
                              ],
                              userId.value,
                            );

                            if (response) {
                              Navigator.pop(context);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => const BrandInput(),
                              //     ));
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const HomePage(),
                              //   ),
                              // );
                            } else {
                              erroralert(
                                  context, "Error", "Unable to add brand");
                            }
                          }),
                    ]),
              )
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
