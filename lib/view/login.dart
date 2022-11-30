// ignore_for_file: use_build_context_synchronously

import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:swrv/state/navstate.dart';

import '../state/loginstate.dart';
import '../widgets/alerts.dart';
import 'navigation/bottomnavbar.dart';
import 'register.dart';

class Login extends HookConsumerWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController email = useTextEditingController();
    TextEditingController password = useTextEditingController();
    ValueNotifier<bool> isLoading = useState(true);

    final loginStateW = ref.watch(loginStatus);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;

    void init() async {
      bool isLogin = await loginStateW.isLogin();
      if (isLogin) {
        ref.watch(pageIndex.state).state = 0;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Bottomnav()));
      }
      isLoading.value = false;
    }

    useEffect(() {
      init();
      return;
    }, []);

    return WillPopScope(
      onWillPop: () async {
        exitAlert(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xfff3f4f6),
        body: SafeArea(
          child: isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: SizedBox(
                    width: width,
                    child: Center(
                      child: Column(
                        children: [
                          Transform.translate(
                            offset: const Offset(0, 80),
                            child: SizedBox(
                              width: width,
                              child: Center(
                                child: Text(
                                  "WELCOME",
                                  style: GoogleFonts.londrinaShadow(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: width / 3.2),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
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
                                  const Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      "Log in",
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
                                              color: Colors.black
                                                  .withOpacity(0.5)),
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
                                        controller: password,
                                        obscureText: loginStateW.isPassword
                                            ? false
                                            : true,
                                        decoration: InputDecoration(
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              loginStateW.togglePassword();
                                            },
                                            child: Icon(
                                              loginStateW.isPassword
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                      .visibility_off_outlined,
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: const Color(0xfff3f4f6),
                                          hintText: "8 characters",
                                          hintStyle: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.5)),
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
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              minimumSize:
                                                  const Size.fromHeight(40),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              elevation: 0,
                                              backgroundColor: Colors.pink,
                                            ),
                                            onPressed: () async {
                                              final res =
                                                  await loginStateW.login(
                                                      context,
                                                      email.text,
                                                      password.text);
                                              if (res) {
                                                ref
                                                    .watch(pageIndex.state)
                                                    .state = 0;

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Bottomnav(),
                                                  ),
                                                );
                                              }
                                            },
                                            child: const Text(
                                              "Login",
                                              textAlign: TextAlign.center,
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            // log("facebook");
                                            // try {
                                            //   await signInWithFacebook();
                                            // } catch (e) {
                                            //   log(e.toString());
                                            // }
                                          },
                                          child: SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: Image.asset(
                                                "assets/images/facebook.png"),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            // try {
                                            //   await signInWithGoogle();
                                            // } catch (e) {
                                            //   log(e.toString());
                                            // }
                                          },
                                          child: SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: Image.asset(
                                                "assets/images/google.png"),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        )
                                      ],
                                    ),
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
                                          value: loginStateW.isChecked,
                                          onChanged: (value) {
                                            loginStateW.toggleCheck();
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'Keep me Logged in.',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(fontSize: 14),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  RichText(
                                    text: const TextSpan(
                                      text: "CAN'T LOGIN REGISTER",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' RESTORE PASSWORD',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 5),
                                    child: Text("Don't have an account?"),
                                  ),
                                  Container(
                                    width: 145,
                                    padding: const EdgeInsets.only(),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size.fromHeight(40),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        backgroundColor:
                                            const Color(0xff03125e),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const Register(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "Join",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
