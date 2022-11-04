import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/components/header.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/widgets/componets.dart';
import 'package:swrv/widgets/cuswidgets.dart';

import '../user/userinput.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List postImg = [
      "post1.jpg",
      'post2.jpg',
      "post3.jpg",
      "post4.jpg",
      "post5.jpg",
      "post6.jpg"
    ];
    ValueNotifier<bool> isFill = useState(false);
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Header(
              name: "analog-sombra",
            ),
            if (!isFill.value) ...[
              Container(
                width: width,
                margin: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: primaryC,
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
                      children: [
                        const Text(
                          "Please Complete Your Profile",
                          textScaleFactor: 1,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: whiteC,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            isFill.value = true;
                          },
                          child: const FaIcon(
                            FontAwesomeIcons.xmark,
                            color: whiteC,
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Your linded social media accounts are under\nverification, you'll be not notified withen 14 hours.",
                        textScaleFactor: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: whiteC,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    CusBtn(
                      btnColor: secondaryC,
                      btnText: "Click here to complete",
                      textSize: 16,
                      btnFunction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const UserInput()),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Welcome to SWRV",
              textAlign: TextAlign.center,
              textScaleFactor: 1,
              style: TextStyle(
                  color: secondaryC, fontSize: 40, fontWeight: FontWeight.w900),
            ),
            const Text(
              "Reach the next billion",
              textScaleFactor: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: secondaryC, fontSize: 18, fontWeight: FontWeight.w400),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 25),
              child: CarouselSlider(
                options: CarouselOptions(
                    height: 180.0,
                    autoPlay: true,
                    viewportFraction: 0.5,
                    enlargeCenterPage: true),
                items: postImg.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(color: Colors.amber),
                          child: Image.asset(
                            "assets/images/$i",
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF7941D),
                boxShadow: const [
                  BoxShadow(color: shadowC, blurRadius: 5, offset: Offset(0, 6))
                ],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(16),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFFDB60C),
                        ),
                        child: Image.asset("assets/images/homeavatar.png"),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Welcome to SWRV",
                            textScaleFactor: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: blackC,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Search, apply for brands campaings\nand create more great content.",
                              textAlign: TextAlign.left,
                              textScaleFactor: 1,
                              style: TextStyle(
                                  color: blackC,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const CampaingList(),
            const SizedBox(
              height: 30,
            ),
            const TopBrandsList(),
            const SizedBox(
              height: 80,
            ),
          ]),
    );
  }
}

class CampaingList extends HookConsumerWidget {
  const CampaingList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 25),
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: const [
                FaIcon(CupertinoIcons.sparkles, color: primaryC),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "New Campaign",
                  textAlign: TextAlign.left,
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: blackC, fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                HomeCard(
                  imgUrl: "assets/images/post1.jpg",
                  title: "Adidas Cases",
                  btnColor: const Color(0xfffbc98e),
                  btnText: "Learn more & apply",
                  btnFunction: () {},
                  website: "www.adidas.co.in",
                  category: "Category: Consumer Electronics",
                  isHeart: false,
                ),
                HomeCard(
                  imgUrl: "assets/images/post1.jpg",
                  title: "Adidas Cases",
                  btnColor: const Color(0xfffbc98e),
                  btnText: "Learn more & apply",
                  btnFunction: () {},
                  website: "www.adidas.co.in",
                  category: "Category: Consumer Electronics",
                  isHeart: false,
                ),
                HomeCard(
                  imgUrl: "assets/images/post1.jpg",
                  title: "Adidas Cases",
                  btnColor: const Color(0xfffbc98e),
                  btnText: "Learn more & apply",
                  btnFunction: () {},
                  website: "www.adidas.co.in",
                  category: "Category: Consumer Electronics",
                  isHeart: false,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TopBrandsList extends HookConsumerWidget {
  const TopBrandsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 25),
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: const [
                FaIcon(CupertinoIcons.star_fill, color: primaryC),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Top brands",
                  textAlign: TextAlign.left,
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: blackC, fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                HomeCard(
                  imgUrl: "assets/images/post1.jpg",
                  title: "Adidas Cases",
                  btnColor: const Color(0xff80fff9),
                  btnText: "View",
                  btnFunction: () {
                    Scaffold.of(context).openDrawer();
                  },
                  website: "www.adidas.co.in",
                  category: "Category: Consumer Electronics",
                  isSocial: false,
                ),
                HomeCard(
                  imgUrl: "assets/images/post1.jpg",
                  title: "Adidas Cases",
                  btnColor: const Color(0xff80fff9),
                  btnText: "View",
                  btnFunction: () {},
                  website: "www.adidas.co.in",
                  category: "Category: Consumer Electronics",
                  isSocial: false,
                ),
                HomeCard(
                  imgUrl: "assets/images/post1.jpg",
                  title: "View",
                  btnColor: const Color(0xff80fff9),
                  btnText: "Adidas Cases",
                  btnFunction: () {},
                  website: "www.adidas.co.in",
                  category: "Category: Consumer Electronics",
                  isSocial: false,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
