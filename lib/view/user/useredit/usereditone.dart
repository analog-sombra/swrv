// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:swrv/state/userstate.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/view/user/useredit/useredittwo.dart';

import '../../../state/user/influenceredit.dart';
import '../../../widgets/componets.dart';
import '../../navigation/bottomnavbar.dart';
import '../../navigation/drawer.dart';

class UserEditOne extends HookConsumerWidget {
  const UserEditOne({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());

    final GlobalKey<FormState> formKey =
        useMemoized(() => GlobalKey<FormState>());

    ValueNotifier<bool> isLoading = useState(true);

    TextEditingController email = useTextEditingController();
    TextEditingController userName = useTextEditingController();
    TextEditingController nickName = useTextEditingController();
    TextEditingController dob = useTextEditingController();
    TextEditingController gender = useTextEditingController();
    TextEditingController bio = useTextEditingController();

    ValueNotifier<String> userAvatar = useState("");

    final userStateW = ref.watch(userState);
    final userProfileEditW = ref.watch(userProfileEditState);

    void init() async {
      await userProfileEditW.initSectionOne(context);
      userAvatar.value = await userStateW.getUserAvatar();
      email.text = userProfileEditW.email!;
      userName.text = userProfileEditW.username!;
      nickName.text = userProfileEditW.nickname!;
      dob.text = userProfileEditW.dob!;
      gender.text = userProfileEditW.genderVal[0];
      bio.text = userProfileEditW.bio!;
      isLoading.value = false;
    }

    useEffect(() {
      init();
      return;
    }, []);

    void showGenderSelection() {
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
                            Center(
                              child: Stack(
                                fit: StackFit.loose,
                                children: [
                                  Align(
                                    child: InkWell(
                                      onTap: () {
                                        userProfileEditW.uploadImage(context);
                                      },
                                      child: SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: (userProfileEditW.imageFile ==
                                                  null)
                                              ? CachedNetworkImage(
                                                  imageUrl: userAvatar.value,
                                                  progressIndicatorBuilder: (context,
                                                          url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Image.asset(
                                                          "assets/images/user.png"),
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.file(
                                                  userProfileEditW.imageFile!,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    child: SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: const BoxDecoration(
                                            color: secondaryC,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.edit,
                                            color: whiteC,
                                            size: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    userName.text,
                                    textScaleFactor: 1,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    nickName.text,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black.withOpacity(0.75)),
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
                                  controller: email,
                                  readOnly: true,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == "") {
                                      return 'Please enter the email.';
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
                                "UserName",
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
                                  controller: userName,
                                  onChanged: (value) {
                                    userProfileEditW.setUserName(value);
                                  },
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == "") {
                                      return 'Please enter the username.';
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
                                "Know As",
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
                                  controller: nickName,
                                  onChanged: (value) {
                                    userProfileEditW.setNickName(value);
                                  },
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == "") {
                                      return 'Please enter the email.';
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
                                  readOnly: true,
                                  controller: dob,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == "") {
                                      return 'Please select the date of birth.';
                                    }
                                    return null;
                                  },
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
                                      initialDate: DateTime(
                                          DateTime.now().year - 18,
                                          DateTime.now().month,
                                          DateTime.now().day),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(
                                          DateTime.now().year - 18,
                                          DateTime.now().month,
                                          DateTime.now().day),
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme:
                                                const ColorScheme.light(
                                              primary: Colors.pink,
                                              onSurface: Colors.pink,
                                            ),
                                            textButtonTheme:
                                                TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.pink,
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );
                                    dob.text =
                                        DateFormat("dd-MM-yyyy").format(date!);
                                    userProfileEditW.setDob(dob.text);
                                  },
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
                                  readOnly: true,
                                  controller: gender,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == "") {
                                      return 'Please select the gender.';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    showGenderSelection();
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
                                  minLines: 4,
                                  maxLines: 6,
                                  controller: bio,
                                  onChanged: (value) {
                                    userProfileEditW.setBio(value);
                                  },
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == "") {
                                      return 'Please enter the bio.';
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
                                            final res = await userProfileEditW
                                                .sectionOneUpdate(context);

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const UserEditTwo()),
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
