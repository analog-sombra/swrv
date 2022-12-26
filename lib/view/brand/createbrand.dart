// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

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
    TextEditingController citySearch = useTextEditingController();

    ValueNotifier<bool> isLoading = useState(true);

    final createBrandSW = ref.watch(createBrandState);

    CusApiReq apiReq = CusApiReq();

    void init() async {
      isLoading.value = false;
    }

    useEffect(() {
      init();
      return null;
    }, []);

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
                            i < createBrandSW.cityList.length;
                            i++) ...[
                          CheckboxListTile(
                            value: createBrandSW.selectedCity[i],
                            onChanged: (val) {
                              createBrandSW.setCity(i, val!);
                              createBrandSW.setCountryCode(i);
                              setState(() {});
                            },
                            title: Text(
                              '${createBrandSW.cityList[i]["name"]}   [ ${createBrandSW.cityList[i]["code"]} ]',
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
                            if (createBrandSW.cityVal.isNotEmpty) {
                              createBrandSW.setCityValue(
                                  "${createBrandSW.cityVal[0]["name"]} [${createBrandSW.cityVal[0]["code"]}]");
                            } else {
                              createBrandSW.setCityValue(null);
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
                                              "The image should either be jpg or jpeg or png format and be a maximum seixe of 4 MB.",
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
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
                                          createBrandSW.resetCitySelection();
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
                                            createBrandSW
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                createBrandSW.cityValue ??
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
