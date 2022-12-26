import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/brandinputstate.dart';
import '../../utils/utilthemes.dart';
import '../../widgets/buttons.dart';
import '../../widgets/componets.dart';
import '../navigation/bottomnavbar.dart';
import '../navigation/drawer.dart';

class InviteToBrand extends HookConsumerWidget {
  const InviteToBrand({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());
    final GlobalKey<FormState> formKey =
        useMemoized(() => GlobalKey<FormState>());
    final brandInputStateW = ref.watch(brandInputState);

    TextEditingController name = useTextEditingController();
    TextEditingController email = useTextEditingController();
    TextEditingController number = useTextEditingController();
    final width = MediaQuery.of(context).size.width;
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Header(),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 5,
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(
                            "Invite user to in your company",
                            textScaleFactor: 1,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                      const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text(
                          "Name",
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
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == "") {
                                return "Please enter the name";
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
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == "") {
                                return "Please enter the email";
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
                      const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text(
                          "Number",
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
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == "") {
                                return "Please enter the name";
                              } else if (value.length < 10) {
                                return "Please enter 10 degit mobile number";
                              }
                              return null;
                            },
                            maxLength: 10,
                            controller: number,
                            decoration: const InputDecoration(
                              filled: true,
                              counterText: "",
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
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: SizedBox(
                          width: 80,
                          child: CusBtn(
                            btnColor: primaryC,
                            btnText: "Invite",
                            textSize: 18,
                            btnFunction: () async {
                              if (formKey.currentState!.validate()) {
                                await brandInputStateW.inviteUser(context,
                                    name.text, email.text, number.text);

                                name.clear();
                                email.clear();
                                number.clear();
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
