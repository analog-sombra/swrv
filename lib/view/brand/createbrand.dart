// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/view/home/home.dart';

import '../../services/apirequest.dart';
import '../../state/brand/createbrandstate.dart';
import '../../utils/alerts.dart';
import '../../utils/utilthemes.dart';
import '../../widgets/buttons.dart';

class CreateBrandPage extends HookConsumerWidget {
  const CreateBrandPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey =
        useMemoized(() => GlobalKey<FormState>());

    final width = MediaQuery.of(context).size.width;

    TextEditingController name = useTextEditingController();
    TextEditingController code = useTextEditingController();
    TextEditingController web = useTextEditingController();
    TextEditingController address = useTextEditingController();
    TextEditingController email = useTextEditingController();
    TextEditingController contact = useTextEditingController();
    TextEditingController binfo = useTextEditingController();
    TextEditingController cinfo = useTextEditingController();

    ValueNotifier<bool> isLoading = useState(true);

    final createBrandSW = ref.watch(createBrandState);

    CusApiReq apiReq = CusApiReq();

    void init() async {
      final req4 = {};
      List city = await apiReq.postApi(jsonEncode(req4), path: "api/getcity");

      if (city[0]["status"]) {
        createBrandSW.setCity(city[0]["data"]);
      } else {
        erroralert(context, "error", "No Record Fount");
      }
      isLoading.value = false;
    }

    useEffect(() {
      init();
      return null;
    }, []);

    return Scaffold(
      backgroundColor: backgroundC,
      body: SafeArea(
        child: isLoading.value
            ? const Padding(
                padding: EdgeInsets.all(15),
                child: Center(
                  child: CircularProgressIndicator(),
                ))
            : SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          width: 120,
                          child: Image.asset(
                            "assets/images/logo.png",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Center(
                        child: Text(
                          "Create brand",
                          textScaleFactor: 1,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: blackC),
                        ),
                      ),
                      const Center(
                        child: Text(
                          "Here you can create brand that you are like.",
                          textScaleFactor: 1,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: blackC),
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
                                color: shadowC,
                                blurRadius: 5,
                                offset: Offset(0, 6))
                          ],
                        ),
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Fill the details",
                              textScaleFactor: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: blackC,
                              ),
                            ),
                            const Divider(),
                            cusTitle("Brand logo"),
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
                                        child: (createBrandSW.imageFile == null)
                                            ? Image.asset(
                                                "assets/images/user.png")
                                            : Image.file(
                                                createBrandSW.imageFile!,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              minimumSize:
                                                  const Size.fromHeight(40),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              elevation: 0,
                                              backgroundColor:
                                                  const Color(0xff9ca3af),
                                            ),
                                            onPressed: () async {
                                              // pickImage();
                                              await createBrandSW
                                                  .uploadImage(context);
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
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Text(
                                              "Upload brand photo here.",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: Text(
                                              "The image should either be jpg or jpeg or png format and be a maximum seixe of 10 MB.",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5),
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
                            cusTitle("Brand name"),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == "") {
                                      return "Please fill the name";
                                    }
                                    return null;
                                  },
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
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == "") {
                                      return "Please fill the brand code";
                                    }
                                    return null;
                                  },
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
                            cusTitle("Brand website"),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == "") {
                                      return "Please fill the website";
                                    }
                                    return null;
                                  },
                                  controller: web,
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
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == "") {
                                      return "Please fill the brand address";
                                    }
                                    return null;
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
                                    itemPadding: const EdgeInsets.only(
                                        left: 20, right: 5),
                                    buttonPadding: const EdgeInsets.only(
                                        left: 20, right: 5),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
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
                                            createBrandSW.setCountryCode(i);
                                            createBrandSW.setCityId(i);
                                          },
                                          value: createBrandSW.cityList[i]
                                              ["name"],
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color:
                                                      blackC.withOpacity(0.25),
                                                ),
                                              ),
                                            ),
                                            width: 220,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Text(
                                              "[${createBrandSW.cityList[i]["code"]}] ${createBrandSW.cityList[i]["name"]}",
                                              textScaleFactor: 1,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
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
                            cusTitle("Support Email"),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == "") {
                                      return "Please fill the email";
                                    }
                                    return null;
                                  },
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
                            cusTitle("Support Contact"),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == "") {
                                      return "Please fill the support contact";
                                    } else if (value.length > 10) {
                                      return "Please enter a 10 deigt phone number";
                                    }
                                    return null;
                                  },
                                  maxLength: 10,
                                  controller: contact,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    prefixText:
                                        (createBrandSW.countryCode == null)
                                            ? "0 - "
                                            : "${createBrandSW.countryCode} - ",
                                    prefixStyle: const TextStyle(
                                        color: blackC, fontSize: 16),
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
                            cusTitle("Brand info"),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == "") {
                                      return "Please fill the brand info";
                                    }
                                    return null;
                                  },
                                  controller: binfo,
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
                            cusTitle("Company info"),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == "") {
                                      return "Please fill the company info";
                                    }
                                    return null;
                                  },
                                  controller: cinfo,
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
                            const SizedBox(
                              height: 10,
                            ),
                            CusBtn(
                              btnColor: primaryC,
                              btnText: "Create Brand",
                              textSize: 18,
                              btnFunction: () async {
                                if (createBrandSW.imageFile == null) {
                                  erroralert(
                                    context,
                                    "Empty Image",
                                    "Please select the image",
                                  );
                                } else if (formKey.currentState!.validate()) {
                                  isLoading.value = true;
                                  final response =
                                      await createBrandSW.createBrand(
                                    context,
                                    [
                                      name.text,
                                      code.text,
                                      web.text,
                                      address.text,
                                      email.text,
                                      contact.text,
                                      binfo.text,
                                      cinfo.text
                                    ],
                                  );

                                  if (response) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HomePage(
                                          isWelcomeAlert: true,
                                        ),
                                      ),
                                      (Route<dynamic> route) => false,
                                    );
                                  } else {
                                    erroralert(context, "Error",
                                        "Unable to add brand");
                                  }
                                  isLoading.value = false;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
