// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:swrv/services/apirequest.dart';
import 'package:swrv/view/login.dart';

class Register extends HookWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;

    ValueNotifier<bool> isBrand = useState(false);
    ValueNotifier<bool> isShowPass1 = useState(false);
    ValueNotifier<bool> isShowPass2 = useState(false);

    ValueNotifier<bool> isCheck1 = useState(false);
    ValueNotifier<bool> isCheck2 = useState(false);

    TextEditingController email = useTextEditingController();
    TextEditingController pass = useTextEditingController();
    TextEditingController coPass = useTextEditingController();

    CusApiReq apiReq = CusApiReq();

    return Scaffold(
      backgroundColor: const Color(0xfff3f4f6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: height - statusBarHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  top: -(width / 2),
                  left: -(width / 2) / 2,
                  child: Container(
                    width: (width + (width / 2)),
                    height: (width + (width / 2)),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xff03125e)),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.all(25),
                        padding: const EdgeInsets.all(35),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10)
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
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
                                      backgroundColor: isBrand.value
                                          ? const Color(0xfff3f4f6)
                                          : Colors.pink,
                                    ),
                                    onPressed: () {
                                      isBrand.value = false;
                                    },
                                    child: Text(
                                      "Influencer",
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          color: isBrand.value
                                              ? const Color(0xff03125e)
                                              : Colors.white,
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor: isBrand.value
                                          ? Colors.pink
                                          : const Color(0xfff3f4f6),
                                    ),
                                    onPressed: () {
                                      isBrand.value = true;
                                    },
                                    child: Text(
                                      "Brand",
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          color: isBrand.value
                                              ? Colors.white
                                              : const Color(0xff03125e),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                "join",
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
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xfff3f4f6),
                                    hintText: "example@email.com",
                                    hintStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.5)),
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
                                "Password",
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
                                  controller: pass,
                                  obscureText: isShowPass1.value ? false : true,
                                  decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        isShowPass1.value = !isShowPass1.value;
                                      },
                                      child: Icon(
                                        isShowPass1.value
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xfff3f4f6),
                                    hintText: "8 characters",
                                    hintStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.5)),
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
                                "Confirm password",
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
                                  controller: coPass,
                                  obscureText: isShowPass2.value ? false : true,
                                  decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        isShowPass2.value = !isShowPass2.value;
                                      },
                                      child: Icon(
                                        isShowPass2.value
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xfff3f4f6),
                                    hintText: "8 characters",
                                    hintStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.5)),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child:
                                        Image.asset("assets/images/apple.png"),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child:
                                        Image.asset("assets/images/google.png"),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff03125e),
                                  minimumSize: const Size.fromHeight(40),
                                ),
                                onPressed: () async {
                                  if (email.text == "") {
                                    var snackBar = SnackBar(
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'Empty Field',
                                        message: 'Please fill the email!',
                                        contentType: ContentType.failure,
                                      ),
                                    );

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else if (pass.text == "") {
                                    var snackBar = SnackBar(
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'Empty Field',
                                        message: 'Please fill the password!',
                                        contentType: ContentType.failure,
                                      ),
                                    );

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else if (coPass.text == "") {
                                    var snackBar = SnackBar(
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'Empty Field',
                                        message: 'Please fill the Re-Password!',
                                        contentType: ContentType.failure,
                                      ),
                                    );

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else if (pass.text != coPass.text) {
                                    var snackBar = SnackBar(
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'Empty Field',
                                        message:
                                            'Password and Re-Password should be same.',
                                        contentType: ContentType.failure,
                                      ),
                                    );

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else if (!isCheck1.value ||
                                      !isCheck2.value) {
                                    var snackBar = SnackBar(
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'Cehck The box',
                                        message:
                                            'In order to proceed check all the box.',
                                        contentType: ContentType.failure,
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    List data;
                                    if (isBrand.value) {
                                      data = await apiReq.postReq(
                                          '{\r\n    "f": "add_brand",\r\n    "email": "${email.text}",\r\n    "password": "${pass.text}"\r\n}');
                                    } else {
                                      data = await apiReq.postReq(
                                          '{\r\n    "f": "add_influencer",\r\n    "email": "${email.text}",\r\n    "password": "${pass.text}"\r\n}');
                                    }

                                    if (data[0] == false) {
                                      var snackBar = SnackBar(
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: AwesomeSnackbarContent(
                                          title: 'Error',
                                          message:
                                              'Something Whet Wrong try again',
                                          contentType: ContentType.failure,
                                        ),
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else if (data[0]["status"] == false) {
                                      var snackBar = SnackBar(
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: AwesomeSnackbarContent(
                                          title: 'Error',
                                          message:
                                              data[0]["message"].toString(),
                                          contentType: ContentType.failure,
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Login(),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: const Text(
                                  "Create account",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Checkbox(
                                    value: isCheck1.value,
                                    onChanged: (value) {
                                      isCheck1.value = value!;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'I agree with Terms of use and acknowledge that my \npersonal data is begin collected and processed in.',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 11),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Checkbox(
                                    value: isCheck2.value,
                                    onChanged: (value) {
                                      isCheck2.value = value!;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Also i conform i am of eligible to age.',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 11),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "I am alredy registered ",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Login()),
                                    );
                                  },
                                  child: const Text(
                                    "Let me Login ",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
