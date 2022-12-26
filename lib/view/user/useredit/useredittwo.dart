// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/view/user/useredit/usereditthree.dart';

import '../../../state/user/influenceredit.dart';
import '../../../widgets/componets.dart';
import '../../navigation/bottomnavbar.dart';
import '../../navigation/drawer.dart';

class UserEditTwo extends HookConsumerWidget {
  const UserEditTwo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());

    final GlobalKey<FormState> formKey =
        useMemoized(() => GlobalKey<FormState>());

    ValueNotifier<bool> isLoading = useState(true);

    TextEditingController personalHistory = useTextEditingController();
    TextEditingController careerHistory = useTextEditingController();
    TextEditingController website = useTextEditingController();

    final userProfileEditW = ref.watch(userProfileEditState);

    void init() async {
      await userProfileEditW.initSectionTwo(context);
      personalHistory.text = userProfileEditW.personalHistory!;
      careerHistory.text = userProfileEditW.careerHistory!;
      website.text = userProfileEditW.website!;

      isLoading.value = false;
    }

    useEffect(() {
      init();
      return;
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
        child: isLoading.value
            ? const Padding(
                padding: EdgeInsets.all(20),
                child: Center(
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
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Edit Profile",
                              textAlign: TextAlign.center,
                              textScaleFactor: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text(
                                "Personal History",
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
                                  controller: personalHistory,
                                  onChanged: (value) {
                                    userProfileEditW.setPersonalHistory(value);
                                  },
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == "") {
                                      return 'Please enter somethign special about yourself.';
                                    }
                                    return null;
                                  },
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
                                "Career History",
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
                                  controller: careerHistory,
                                  onChanged: (value) {
                                    userProfileEditW.setCareerHistory(value);
                                  },
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == "") {
                                      return 'Tell me something about your Career History.';
                                    }
                                    return null;
                                  },
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
                                child: TextFormField(
                                  controller: website,
                                  onChanged: (value) {
                                    userProfileEditW.setWebsite(value);
                                  },
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == "") {
                                      return 'Enter your website url.';
                                    }
                                    return null;
                                  },
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          elevation: 0,
                                          backgroundColor: backgroundC,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Back",
                                          textAlign: TextAlign.center,
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          elevation: 0,
                                          backgroundColor: secondaryC,
                                        ),
                                        onPressed: () async {
                                          isLoading.value = true;
                                          if (formKey.currentState!
                                              .validate()) {
                                            await userProfileEditW
                                                .sectionTwoUpdate(context);

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const UserEditThree()),
                                            );
                                          }
                                          isLoading.value = false;
                                        },
                                        child: const Text(
                                          "Save",
                                          textAlign: TextAlign.center,
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              color: whiteC,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
