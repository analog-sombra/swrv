// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swrv/services/apirequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:swrv/view/register.dart';
import 'package:swrv/view/user/profile.dart';
import 'package:swrv/view/user/userinput.dart';

class Login extends HookWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<SharedPreferences?> prefs = useState(null);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;

    ValueNotifier<bool> isPassShow = useState(false);
    ValueNotifier<bool> isChecked = useState(false);

    TextEditingController email = useTextEditingController();
    TextEditingController password = useTextEditingController();

    CusApiReq apiReq = CusApiReq();

    void init() async {
      prefs.value = await SharedPreferences.getInstance();
      bool? isLogin = prefs.value?.getBool("isLogin");
      if (isLogin != null) {
        if (isLogin) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Profile()));
        }
      }
    }

    useEffect(() {
      init();

      return;
    }, []);

    return Scaffold(
      backgroundColor: const Color(0xfff3f4f6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: height - statusBarHeight,
            child: Stack(
              fit: StackFit.loose,
              children: [
                Positioned(
                  top: 100,
                  left: -10,
                  child: Container(
                    decoration: const BoxDecoration(),
                    child: Center(
                      child: Text(
                        "Welcome",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 100,
                            fontWeight: FontWeight.w900,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..color = Colors.black.withOpacity(0.6)
                              ..strokeWidth = 2),
                      ),
                    ),
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
                                  controller: password,
                                  obscureText: isPassShow.value ? false : true,
                                  decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        isPassShow.value = !isPassShow.value;
                                      },
                                      child: Icon(
                                        isPassShow.value
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Colors.black.withOpacity(0.7),
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
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size.fromHeight(40),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        elevation: 0,
                                        backgroundColor: Colors.pink,
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
                                        } else if (password.text == "") {
                                          var snackBar = SnackBar(
                                            elevation: 0,
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            content: AwesomeSnackbarContent(
                                              title: 'Empty Field',
                                              message:
                                                  'Please fill the password!',
                                              contentType: ContentType.failure,
                                            ),
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } else {
                                          List data = await apiReq.postReq(
                                              '{\r\n    "f": "validate_login",\r\n    "username": "${email.text}",\r\n    "password": "${password.text}"\r\n}');

                                          if (data[0] == false) {
                                            var snackBar = SnackBar(
                                              elevation: 0,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              backgroundColor:
                                                  Colors.transparent,
                                              content: AwesomeSnackbarContent(
                                                title: 'Error',
                                                message:
                                                    'Something Whet Wrong try again',
                                                contentType:
                                                    ContentType.failure,
                                              ),
                                            );

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          } else if (data[0]["status"] ==
                                              false) {
                                            var snackBar = SnackBar(
                                              elevation: 0,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              backgroundColor:
                                                  Colors.transparent,
                                              content: AwesomeSnackbarContent(
                                                title: 'Error',
                                                message: data[0]["message"]
                                                    .toString(),
                                                contentType:
                                                    ContentType.failure,
                                              ),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          } else {
                                            if (isChecked.value) {
                                              await prefs.value
                                                  ?.setBool("isLogin", true);
                                              await prefs.value?.setStringList(
                                                  "userdata",
                                                  [email.text, password.text]);
                                            }

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => UserInput(
                                                  name: data[0]["data"]
                                                          ["userName"]
                                                      .toString()
                                                      .split("@")[0]
                                                      .toString(),
                                                ),
                                              ),
                                            );
                                          }
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
                                  const SizedBox(
                                    width: 20,
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Checkbox(
                                    value: isChecked.value,
                                    onChanged: (value) {
                                      isChecked.value = value!;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Keep me Logined in.',
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
                                    text: ' RERSTORE PASSWORD',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 5),
                              child: Text("Don't have an account?"),
                            ),
                            Container(
                              width: 145,
                              padding: const EdgeInsets.only(),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: const Color(0xff03125e),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Register(),
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
