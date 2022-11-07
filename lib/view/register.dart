// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/view/login.dart';

import '../state/registerstate.dart';
import '../widgets/alerts.dart';

class Register extends HookConsumerWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;

    final registerStateW = ref.watch(registerState);

    TextEditingController email = useTextEditingController();
    TextEditingController pass = useTextEditingController();
    TextEditingController coPass = useTextEditingController();

    return WillPopScope(
      onWillPop: () async {
        exitAlert(context);
        return false;
      },
      child: Scaffold(
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
                          child: SingleChildScrollView(
                            child: Column(
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
                                          backgroundColor:
                                              registerStateW.isBrand
                                                  ? const Color(0xfff3f4f6)
                                                  : Colors.pink,
                                        ),
                                        onPressed: () {
                                          registerStateW.setBrand(false);
                                          registerStateW.setCheck1(false);
                                          registerStateW.setCheck2(false);
                                        },
                                        child: Text(
                                          "Influencer",
                                          textAlign: TextAlign.center,
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              color: registerStateW.isBrand
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          backgroundColor:
                                              registerStateW.isBrand
                                                  ? Colors.pink
                                                  : const Color(0xfff3f4f6),
                                        ),
                                        onPressed: () {
                                          registerStateW.setBrand(true);
                                          registerStateW.setCheck1(false);
                                          registerStateW.setCheck2(true);
                                        },
                                        child: Text(
                                          "Brand",
                                          textAlign: TextAlign.center,
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              color: registerStateW.isBrand
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
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    registerStateW.isBrand
                                        ? "Business Email"
                                        : "Email",
                                    textScaleFactor: 1,
                                    style: const TextStyle(
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
                                            color:
                                                Colors.black.withOpacity(0.5)),
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
                                      obscureText: registerStateW.isShowPass1
                                          ? false
                                          : true,
                                      decoration: InputDecoration(
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            registerStateW.togglePass1();
                                          },
                                          child: Icon(
                                            registerStateW.isShowPass1
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color:
                                                Colors.black.withOpacity(0.8),
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xfff3f4f6),
                                        hintText: "8 characters",
                                        hintStyle: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5)),
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
                                      obscureText: registerStateW.isShowPass2
                                          ? false
                                          : true,
                                      decoration: InputDecoration(
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            registerStateW.togglePass2();
                                          },
                                          child: Icon(
                                            registerStateW.isShowPass2
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color:
                                                Colors.black.withOpacity(0.8),
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xfff3f4f6),
                                        hintText: "8 characters",
                                        hintStyle: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5)),
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
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Image.asset(
                                            "assets/images/apple.png"),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Image.asset(
                                            "assets/images/google.png"),
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
                                      final res = await registerStateW.register(
                                          context, email, pass, coPass);
                                      if (res) {
                                        registerStateW.clear();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const Login(),
                                          ),
                                        );
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
                                        value: registerStateW.isCheck1,
                                        onChanged: (value) {
                                          registerStateW
                                              .setCheck1(value ?? false);
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
                                if (!registerStateW.isBrand) ...[
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Checkbox(
                                          value: registerStateW.isCheck2,
                                          onChanged: (value) {
                                            registerStateW
                                                .setCheck2(value ?? false);
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
                                ],
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
                                        registerStateW.clear();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Login()),
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
