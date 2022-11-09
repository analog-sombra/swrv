import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/components/header.dart';
import 'package:swrv/state/navstate.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/widgets/cuswidgets.dart';

class Inbox extends HookConsumerWidget {
  const Inbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Header(
    
          ),
          Container(
            width: width,
            margin: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: whiteC,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: shadowC, blurRadius: 5, offset: Offset(0, 6))
              ],
            ),
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_back_ios)),
                    SizedBox(
                      width: 80,
                      child: CusBtn(
                        btnColor: primaryC,
                        btnText: "Info",
                        textSize: 18,
                        btnFunction: () {},
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.favorite, color: Colors.red, size: 40)
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: Image.asset(
                          "assets/images/post3.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Expanded(
                      child: Text(
                        "Adidas Cases",
                        textAlign: TextAlign.left,
                        textScaleFactor: 1,
                        style: TextStyle(
                            color: blackC,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Lulu 50% off - SPORT WEEK",
                  textAlign: TextAlign.left,
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: blackC, fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Category: Consumer Electroinics",
                  textAlign: TextAlign.left,
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: blackC.withOpacity(0.65),
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "www.adidas.co.in",
                  textAlign: TextAlign.left,
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: blackC.withOpacity(0.55),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Campaign Info",
                    textScaleFactor: 1,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: secondaryC),
                  ),
                ),
                const Text(
                  "Don't miss out on Early Access sale of EOSS for members only. Become a Adi club member and get Early access to EOSS from 21st to 23rd June. adidas® Official Shop. Free Shipping. Types: Running Shoes, Running Shorts & Tights, Running Jackets, Tracksuits & Track Pants.Don't miss out on Early Access sale of EOSS for members only. Become a Adi club member and get Early access to EOSS from 21st to 23rd June. adidas® Official Shop. Free Shipping. Types: Running Shoes, Running Shorts & Tights, Running Jackets, Tracksuits & Track Pants.",
                  textScaleFactor: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400, color: blackC),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: width,
                  child: CusBtn(
                      btnColor: const Color(0xffF7941D),
                      btnText: "View Campaigns",
                      textSize: 18,
                      btnFunction: () {
                        ref.read(pageIndex.state).state = 22;
                      }),
                ),
                const Divider(),
                Row(
                  children: [
                    const Text(
                      "Attachments",
                      textScaleFactor: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: secondaryC),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 100,
                      child: CusBtn(
                          btnColor: const Color(0xff01FFF4),
                          btnText: "View all",
                          textSize: 16,
                          textColor: blackC,
                          btnFunction: () {
                          
                          }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                for (int i = 0; i < 5; i++) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Image.asset(
                              "assets/images/post1.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Expanded(
                          child: Text(
                            "Want to awaken your body after a hectic work week? Or, enjoy that after-shower glow by sealing in moisture?",
                            textScaleFactor: 1,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: blackC,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
