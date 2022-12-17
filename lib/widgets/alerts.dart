// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swrv/database/models/favoritebrand.dart';
import 'package:swrv/database/models/favoritechamp.dart';
import 'package:swrv/state/loginstate.dart';
import 'package:swrv/utils/alerts.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/view/home/home.dart';
import 'package:swrv/widgets/buttons.dart';

import '../database/database.dart';
import '../state/compaign/campaigninfostate.dart';
import '../state/compaign/createcampaignstate.dart';
import '../state/compaign/findcompaignstate.dart';
import '../state/influencer/findinfluencerstate.dart';
import '../view/login.dart';

void welcomeAlert(BuildContext context, String email) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        contentPadding: const EdgeInsets.all(5),
        backgroundColor: secondaryC,
        content: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const FaIcon(
                      FontAwesomeIcons.xmark,
                      color: whiteC,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset("assets/images/confetti.png"),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Congratulatons!",
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: whiteC, fontSize: 22, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: RichText(
                  text: TextSpan(
                    text:
                        'Your account has been created and confirmation link was sent to an email ',
                    style: const TextStyle(
                      color: whiteC,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: email,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                  textScaleFactor: 1,
                  selectionRegistrar: SelectionContainer.maybeOf(context),
                  selectionColor: const Color(0xAF6694e8),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: RichText(
                  text: const TextSpan(
                    text: "Can't find a confirmation email ",
                    style: TextStyle(
                      color: whiteC,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: "Please resend the link",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                  textScaleFactor: 1,
                  selectionRegistrar: SelectionContainer.maybeOf(context),
                  selectionColor: const Color(0xAF6694e8),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void cusAlertTwo(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        contentPadding: const EdgeInsets.all(5),
        backgroundColor: whiteC,
        content: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.xmark,
                      color: blackC.withOpacity(0.65),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset("assets/images/sad.png"),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Sorry!",
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: blackC, fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Thank you for expressing interest in SWRV. While we were impressed with your profile, unfortunately, your profile dosent meet the minimum criteria which we need in this platform',
                  style: TextStyle(
                    color: blackC.withOpacity(0.55),
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'We sincerely appreciate your interest and hope that you’ll stay in touch. Please don’t hesitate to reach out if you disagree with our decision.',
                  style: TextStyle(
                    color: blackC.withOpacity(0.55),
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void connectAlert(BuildContext context, WidgetRef ref,
    TextEditingController msg, String champId, String toUserId) {
  final formKey = GlobalKey<FormState>();
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        contentPadding: const EdgeInsets.all(5),
        backgroundColor: whiteC,
        content: Container(
          width: MediaQuery.of(context).size.width - 50,
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: FaIcon(
                        FontAwesomeIcons.xmark,
                        color: blackC.withOpacity(0.65),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Connect",
                  textScaleFactor: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: secondaryC,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  child: Text(
                    "Subject - Apply for campaign",
                    textScaleFactor: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: blackC,
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
                        if (value == null || value.isEmpty || value == "") {
                          return 'Enter some messages..';
                        }
                        return null;
                      },
                      controller: msg,
                      minLines: 5,
                      maxLines: 5,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xfff3f4f6),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Message",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.45),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: 100,
                      child: CusBtn(
                        btnColor: secondaryC,
                        btnText: "sent",
                        textSize: 16,
                        textColor: whiteC,
                        btnFunction: () async {
                          if (formKey.currentState!.validate()) {
                            await ref.watch(campaignInfoState).applyForChamp(
                                context, msg.text, champId, toUserId);
                            msg.clear();
                          }
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

void exitAlert(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        contentPadding: const EdgeInsets.all(5),
        backgroundColor: whiteC,
        content: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Exit!",
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: blackC, fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Are you sure you want to exit the SWRV?',
                  style: TextStyle(
                    color: blackC.withOpacity(0.55),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CusBtn(
                      btnColor: redC,
                      btnText: "Exit",
                      textSize: 18,
                      btnFunction: () {
                        SystemNavigator.pop();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CusBtn(
                      btnColor: greenC,
                      btnText: "Cancel",
                      textSize: 18,
                      btnFunction: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

void addMentionsAlert(
    BuildContext context, TextEditingController mention, WidgetRef ref) {
  final createCmpSW = ref.watch(createCampState);

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        contentPadding: const EdgeInsets.all(5),
        backgroundColor: whiteC,
        content: Container(
          width: MediaQuery.of(context).size.width - 50,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Add Mentions",
                  textScaleFactor: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: secondaryC,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: TextField(
                    controller: mention,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xfff3f4f6),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "mentions",
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.45),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: CusBtn(
                      btnColor: redC,
                      btnText: "Cancel",
                      textSize: 18,
                      btnFunction: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CusBtn(
                      btnColor: greenC,
                      btnText: "Add",
                      textSize: 18,
                      btnFunction: () {
                        if (mention.text.isEmpty) {
                          mention.clear();
                          Navigator.pop(context);
                          erroralert(context, "Error", "Please fill the field");
                        } else if (createCmpSW.mention.contains(mention.text)) {
                          Navigator.pop(context);
                          erroralert(context, "Error",
                              "Alredy exist, Try different one");
                        } else if (mention.text.contains(" ")) {
                          mention.clear();
                          Navigator.pop(context);
                          erroralert(
                              context, "Error", "Please don't use space");
                        } else {
                          createCmpSW.addMention(mention.text);
                          mention.clear();
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

void addHashTagAlert(
    BuildContext context, TextEditingController hashtag, WidgetRef ref) {
  final createCmpSW = ref.watch(createCampState);

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        contentPadding: const EdgeInsets.all(5),
        backgroundColor: whiteC,
        content: Container(
          width: MediaQuery.of(context).size.width - 50,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Add HashTag",
                  textScaleFactor: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: secondaryC,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: TextField(
                    controller: hashtag,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xfff3f4f6),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "hashtag",
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.45),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: CusBtn(
                      btnColor: redC,
                      btnText: "Cancel",
                      textSize: 18,
                      btnFunction: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CusBtn(
                      btnColor: greenC,
                      btnText: "Add",
                      textSize: 18,
                      btnFunction: () {
                        if (hashtag.text.isEmpty) {
                          hashtag.clear();
                          Navigator.pop(context);
                          erroralert(context, "Error", "Please fill the field");
                        } else if (createCmpSW.hashtag.contains(hashtag.text)) {
                          Navigator.pop(context);
                          erroralert(context, "Error",
                              "Alredy exist, Try different one");
                        } else if (hashtag.text.contains(" ")) {
                          hashtag.clear();
                          Navigator.pop(context);
                          erroralert(
                              context, "Error", "Please don't use space");
                        } else {
                          createCmpSW.addHashTag(hashtag.text);
                          hashtag.clear();
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

void addAudienceLocation(BuildContext context,
    TextEditingController audienceLocation, WidgetRef ref) {
  final createCmpSW = ref.watch(createCampState);

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        contentPadding: const EdgeInsets.all(5),
        backgroundColor: whiteC,
        content: Container(
          width: MediaQuery.of(context).size.width - 50,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Add Audience Location",
                  textScaleFactor: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: secondaryC,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: TextField(
                    controller: audienceLocation,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xfff3f4f6),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Audience Location",
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.45),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: CusBtn(
                      btnColor: redC,
                      btnText: "Cancel",
                      textSize: 18,
                      btnFunction: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CusBtn(
                      btnColor: greenC,
                      btnText: "Add",
                      textSize: 18,
                      btnFunction: () {
                        if (audienceLocation.text.isEmpty) {
                          audienceLocation.clear();
                          Navigator.pop(context);
                          erroralert(context, "Error", "Please fill the field");
                        } else if (createCmpSW.audienceLocation
                            .contains(audienceLocation.text)) {
                          Navigator.pop(context);
                          erroralert(context, "Error",
                              "Alredy exist, Try different one");
                        } else if (audienceLocation.text.contains(" ")) {
                          audienceLocation.clear();
                          Navigator.pop(context);
                          erroralert(
                              context, "Error", "Please don't use space");
                        } else {
                          createCmpSW
                              .addAudienceLocation(audienceLocation.text);
                          audienceLocation.clear();
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

void addDosAlert(
    BuildContext context, TextEditingController dos, WidgetRef ref) {
  final createCmpSW = ref.watch(createCampState);

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        contentPadding: const EdgeInsets.all(5),
        backgroundColor: whiteC,
        content: Container(
          width: MediaQuery.of(context).size.width - 50,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Add Do's",
                  textScaleFactor: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: secondaryC,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: TextField(
                    controller: dos,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xfff3f4f6),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Do's",
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.45),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: CusBtn(
                      btnColor: redC,
                      btnText: "Cancel",
                      textSize: 18,
                      btnFunction: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CusBtn(
                      btnColor: greenC,
                      btnText: "Add",
                      textSize: 18,
                      btnFunction: () {
                        if (dos.text.isEmpty) {
                          dos.clear();
                          Navigator.pop(context);
                          erroralert(context, "Error", "Please fill the field");
                        } else if (createCmpSW.dos.contains(dos.text)) {
                          Navigator.pop(context);
                          erroralert(context, "Error",
                              "Alredy exist, Try different one");
                        } else {
                          createCmpSW.addDos(dos.text);
                          dos.clear();
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

void addDontAlert(
    BuildContext context, TextEditingController dont, WidgetRef ref) {
  final createCmpSW = ref.watch(createCampState);

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        contentPadding: const EdgeInsets.all(5),
        backgroundColor: whiteC,
        content: Container(
          width: MediaQuery.of(context).size.width - 50,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Add Don't",
                  textScaleFactor: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: secondaryC,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: TextField(
                    controller: dont,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xfff3f4f6),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Do's",
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.45),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: CusBtn(
                      btnColor: redC,
                      btnText: "Cancel",
                      textSize: 18,
                      btnFunction: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CusBtn(
                      btnColor: greenC,
                      btnText: "Add",
                      textSize: 18,
                      btnFunction: () {
                        if (dont.text.isEmpty) {
                          dont.clear();
                          Navigator.pop(context);
                          erroralert(context, "Error", "Please fill the field");
                        } else if (createCmpSW.dont.contains(dont.text)) {
                          Navigator.pop(context);
                          erroralert(context, "Error",
                              "Alredy exist, Try different one");
                        } else {
                          createCmpSW.addDont(dont.text);
                          dont.clear();
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

void removeFav(BuildContext context, List<int> delfav) async {
  return await showDialog(
    context: context,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        contentPadding: const EdgeInsets.all(5),
        backgroundColor: whiteC,
        content: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Remove",
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: blackC, fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Are you sure you want to remove all Favorite campaign',
                  style: TextStyle(
                    color: blackC.withOpacity(0.55),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CusBtn(
                      btnColor: redC,
                      btnText: "Cancel",
                      textSize: 18,
                      btnFunction: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CusBtn(
                      btnColor: greenC,
                      btnText: "Clear",
                      textSize: 18,
                      btnFunction: () async {
                        await isarDB.writeTxn(() async {
                          await isarDB.favoriteChamps.deleteAll(delfav);
                        });
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

void removeFavBrand(BuildContext context, List<int> delfav) async {
  return await showDialog(
    context: context,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        contentPadding: const EdgeInsets.all(5),
        backgroundColor: whiteC,
        content: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Remove",
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: blackC, fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Are you sure you want to remove all Favorite brand',
                  style: TextStyle(
                    color: blackC.withOpacity(0.55),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CusBtn(
                      btnColor: redC,
                      btnText: "Cancel",
                      textSize: 18,
                      btnFunction: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CusBtn(
                      btnColor: greenC,
                      btnText: "Clear",
                      textSize: 18,
                      btnFunction: () async {
                        await isarDB.writeTxn(() async {
                          await isarDB.favoriteBrands.deleteAll(delfav);
                        });
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

void logoutAlert(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        contentPadding: const EdgeInsets.all(5),
        backgroundColor: whiteC,
        content: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Remove",
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: blackC, fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Are you sure you want to logout?',
                  style: TextStyle(
                    color: blackC.withOpacity(0.55),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CusBtn(
                      btnColor: redC,
                      btnText: "No",
                      textSize: 18,
                      btnFunction: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CusBtn(
                      btnColor: greenC,
                      btnText: "Yes",
                      textSize: 18,
                      btnFunction: () async {
                        final prefs = await SharedPreferences.getInstance();

                        bool? success = await prefs.remove('login');
                        if (success) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

void saveCFilterAlert(
    BuildContext context, TextEditingController filter, WidgetRef ref) async {
  final formKey = GlobalKey<FormState>();
  return await showDialog(
    context: context,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        contentPadding: const EdgeInsets.all(5),
        backgroundColor: whiteC,
        content: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Save Filter",
                  textScaleFactor: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: blackC, fontSize: 25, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Name the filter and save',
                    style: TextStyle(
                      color: blackC.withOpacity(0.55),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TextFormField(
                      controller: filter,
                      validator: (value) {
                        if (value == null || value.isEmpty || value == "") {
                          return 'Please enter name of the filter';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xfff3f4f6),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Filter Name",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.45),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CusBtn(
                        btnColor: redC,
                        btnText: "Cencel",
                        textSize: 18,
                        btnFunction: () {
                          Navigator.pop(context);
                          filter.clear();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: CusBtn(
                        btnColor: greenC,
                        btnText: "Save",
                        textSize: 18,
                        btnFunction: () async {
                          if (formKey.currentState!.validate()) {
                            await ref
                                .watch(findCampState)
                                .saveFilter(context, filter.text);
                            Navigator.pop(context);
                          }
                          filter.clear();
                          await ref.watch(findCampState).loadFilter();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

void saveIFilterAlert(
    BuildContext context, TextEditingController filter, WidgetRef ref) async {
  final formKey = GlobalKey<FormState>();
  return await showDialog(
    context: context,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        contentPadding: const EdgeInsets.all(5),
        backgroundColor: whiteC,
        content: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Save Filter",
                  textScaleFactor: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: blackC, fontSize: 25, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Name the filter and save',
                    style: TextStyle(
                      color: blackC.withOpacity(0.55),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TextFormField(
                      controller: filter,
                      validator: (value) {
                        if (value == null || value.isEmpty || value == "") {
                          return 'Please enter name of the filter';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xfff3f4f6),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Filter Name",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.45),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CusBtn(
                        btnColor: redC,
                        btnText: "Cencel",
                        textSize: 18,
                        btnFunction: () {
                          Navigator.pop(context);
                          filter.clear();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: CusBtn(
                        btnColor: greenC,
                        btnText: "Save",
                        textSize: 18,
                        btnFunction: () async {
                          if (formKey.currentState!.validate()) {
                            await ref
                                .watch(findInfState)
                                .saveFilter(context, filter.text);
                            Navigator.pop(context);
                          }
                          filter.clear();
                          await ref.watch(findInfState).loadFilter();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

void resetPassAlert(
    BuildContext context, TextEditingController email, WidgetRef ref) async {
  final formKey = GlobalKey<FormState>();
  return await showDialog(
    context: context,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        contentPadding: const EdgeInsets.all(5),
        backgroundColor: whiteC,
        content: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Restore Password",
                  textScaleFactor: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: blackC, fontSize: 25, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TextFormField(
                      controller: email,
                      validator: (value) {
                        if (value == null || value.isEmpty || value == "") {
                          return 'Please enter email address';
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                            .hasMatch(value)) {
                          return "Enter a valid email.";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xfff3f4f6),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Enter email..",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.45),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CusBtn(
                        btnColor: redC,
                        btnText: "Cencel",
                        textSize: 18,
                        btnFunction: () {
                          Navigator.pop(context);
                          email.clear();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: CusBtn(
                        btnColor: greenC,
                        btnText: "Send",
                        textSize: 18,
                        btnFunction: () async {
                          if (formKey.currentState!.validate()) {
                            final res = await ref
                                .watch(loginStatus)
                                .forgetPass(context, email.text);
                            Navigator.pop(context);
                            if (res) {
                              susalert(context, "Sent",
                                  "Check your email for further information");
                            } else {
                              erroralert(context, "Error",
                                  "Unable to send email, Try again..");
                            }
                            email.clear();
                          }
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
