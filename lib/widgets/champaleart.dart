// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/compaign/campaigninfostate.dart';
import '../utils/utilthemes.dart';
import 'buttons.dart';

void champAccecptInvite(
    BuildContext context, WidgetRef ref, String id, String champId) {
  showDialog(
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
                "Accept",
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: blackC, fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Are you sure you want to accept this?',
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
                      btnText: "Accept",
                      textSize: 18,
                      btnFunction: () async {
                        await ref
                            .watch(campaignInfoState)
                            .acceptCamp(context, id);
                        await ref
                            .watch(campaignInfoState)
                            .setAcceptRequest(context, champId);
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

void champRejectInvite(BuildContext context, WidgetRef ref,
    TextEditingController reason, String id, String champId) {
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
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Reject Request",
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
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty || value == "") {
                          return 'Please enter rejection reason.';
                        }
                        return null;
                      },
                      controller: reason,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xfff3f4f6),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Enter the reason of rejection.",
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
                        btnText: "Reject",
                        textSize: 18,
                        btnFunction: () async {
                          if (formKey.currentState!.validate()) {
                            await ref
                                .watch(campaignInfoState)
                                .rejectCamp(context, id, reason.text);
                            await ref
                                .watch(campaignInfoState)
                                .setAcceptRequest(context, champId);
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

void champAccecptDraft(
    BuildContext context, WidgetRef ref, String id, String champId) {
  showDialog(
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
                "Accept",
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: blackC, fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Are you sure you want to accept this?',
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
                      btnText: "Accept",
                      textSize: 18,
                      btnFunction: () async {
                        await ref
                            .watch(campaignInfoState)
                            .acceptDraft(context, id);
                        await ref
                            .watch(campaignInfoState)
                            .setDraftRequest(context, champId);
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

void champRejectDraft(BuildContext context, WidgetRef ref,
    TextEditingController reason, String id, String champId) {
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
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Reject Request",
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
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty || value == "") {
                          return 'Please enter rejection reason.';
                        }
                        return null;
                      },
                      controller: reason,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xfff3f4f6),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Enter the reason of rejection.",
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
                        btnText: "Reject",
                        textSize: 18,
                        btnFunction: () async {
                          if (formKey.currentState!.validate()) {
                            await ref
                                .watch(campaignInfoState)
                                .rejectDraft(context, id, reason.text);
                            await ref
                                .watch(campaignInfoState)
                                .setDraftRequest(context, champId);
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
