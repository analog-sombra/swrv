// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:swrv/components/header.dart';
import 'package:swrv/utils/utilthemes.dart';

class EditProfile extends HookWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    // ValueNotifier<SharedPreferences?> prefs = useState(null);
    TextEditingController dob = useTextEditingController();

    // void init() async {
    //   prefs.value = await SharedPreferences.getInstance();
    // }

    useEffect(() {
      // init();
      return;
    });

    return SingleChildScrollView(
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
            margin:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
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
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          width: 100,
                          height: 100,
                          child: Image.asset("assets/images/avatar.png"),
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
                                  ))),
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
                      const Text(
                        "Analog Sombra",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Junior Developer",
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
                    child: const TextField(
                      readOnly: true,
                      decoration: InputDecoration(
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
                    "Lastname",
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
                    child: const TextField(
                      decoration: InputDecoration(
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
                    child: const TextField(
                      decoration: InputDecoration(
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
                    child: const TextField(
                      decoration: InputDecoration(
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
                    child: const TextField(
                      minLines: 4,
                      maxLines: 6,
                      decoration: InputDecoration(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 0,
                                backgroundColor: backgroundC,
                              ),
                              onPressed: () {},
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
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                  backgroundColor: secondaryC),
                              onPressed: () {},
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
                        ]),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 80,
          )
        ],
      ),
    );
  }
}
