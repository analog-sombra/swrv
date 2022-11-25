import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/utils/utilthemes.dart';

import '../../widgets/componets.dart';

class ForgetPassInfo extends HookConsumerWidget {
  const ForgetPassInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Header(),
          Container(
            width: width,
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            decoration: BoxDecoration(
              color: whiteC,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: shadowC, blurRadius: 5, offset: Offset(0, 6))
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "How to reset a lost or forgotten password",
                  textScaleFactor: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w500, color: blackC),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "To reset your password, you’ll need access to the phone number or email associated with your SWRV account. This verification information helps ensure your account is only accessible to you. If you can’t access your phone or email, you won’t be able to recover your password, and may need to sign up for a new account.",
                  textScaleFactor: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: blackC.withOpacity(0.55)),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "What you’ll need to change your password on SWRV",
                  textScaleFactor: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700, color: blackC),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "An accurate and up-to-date email address, and/or phone number ensure you never lose access to your SWRV account. There are a few ways to change your password, and keeping this information up to date simplifies resetting your account or password.",
                  textScaleFactor: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: blackC.withOpacity(0.55)),
                ),
                const SizedBox(
                  height: 10,
                ),
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
