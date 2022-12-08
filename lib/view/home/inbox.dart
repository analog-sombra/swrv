import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/widgets/buttons.dart';

import '../../utils/alerts.dart';
import '../../widgets/componets.dart';
import '../campaings/compaignconnect.dart';
import '../navigation/bottomnavbar.dart';
import '../navigation/drawer.dart';

class Inbox extends HookConsumerWidget {
  const Inbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());
    final width = MediaQuery.of(context).size.width;

    ValueNotifier<List> darfData = useState([
      {
        "img": "assets/images/1.jpg",
        "name": "sohan",
        "msg":
            "There’s just one more thing you need to do to get started with us."
      },
      {
        "img": "assets/images/2.jpg",
        "name": "Rahul",
        "msg":
            "Thank you for scheduling an appointment with our office. You are confirmed for an appointment with"
      },
      {
        "img": "assets/images/3.jpg",
        "name": "Mohan",
        "msg":
            "Thank you for providing the information we requested. We will follow up with you shortly regarding the next steps."
      },
      {
        "img": "assets/images/4.jpg",
        "name": "Soniya",
        "msg":
            "We’re super excited to announce that we’re opening our doors on DATE at TIME. Come join us!"
      },
      {
        "img": "assets/images/5.jpg",
        "name": "Sonali",
        "msg":
            "Thank you for your business! We pride ourselves on great service and it’s your feedback that makes that possible!"
      },
      {
        "img": "assets/images/6.jpg",
        "name": "Sakhi",
        "msg":
            "We just wanted to remind you that we’re waiting for the DOCUMENT you agreed to send us so we can complete the TRANSACTION we discussed."
      },
    ]);

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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Header(),
              Container(
                width: width,
                margin: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: whiteC,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                        color: shadowC, blurRadius: 5, offset: Offset(0, 6))
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
                          color: blackC,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
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
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: blackC),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: width,
                      child: CusBtn(
                          btnColor: const Color(0xffF7941D),
                          btnText: "View Campaign",
                          textSize: 18,
                          btnFunction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => const CampaignConnect()),
                              ),
                            );
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
                                comingalert(context);
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    for (int i = 0; i < darfData.value.length; i++) ...[
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
                                  darfData.value[i]["img"],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Text(
                                darfData.value[i]["msg"],
                                textScaleFactor: 1,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
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
        ),
      ),
    );
  }
}
