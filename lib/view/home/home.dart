// ignore_for_file: use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/state/navigation/drawer.dart';
import 'package:swrv/state/userstate.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/widgets/componets.dart';
import 'package:swrv/widgets/cuswidgets.dart';

import '../../utils/alerts.dart';
import '../../widgets/alerts.dart';
import '../navigation/bottomnavbar.dart';
import '../navigation/drawer.dart';
import '../user/brandinput.dart';
import '../user/influencerinput.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key, this.isWelcomeAlert = false});
  final bool isWelcomeAlert;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());
    List postImg = [
      "user1.jpg",
      'user2.jpg',
      "user3.jpg",
      "user4.jpg",
      "user5.jpg",
      "user6.jpg"
    ];

    final width = MediaQuery.of(context).size.width;
    ValueNotifier<bool> isCompleted = useState(false);

    final userStateW = ref.watch(userState);
    final drawerIndexW = ref.watch(drawerIndex);
    final bottomIndexW = ref.watch(bottomIndex);
    ValueNotifier<bool> isBrand = useState(false);
    ValueNotifier<String> userName = useState("loading..");

    void init() async {
      drawerIndexW.setIndex(0);
      bottomIndexW.setIndex(0);
      if (isWelcomeAlert) {
        await Future.delayed(const Duration(milliseconds: 400));
        welcomeAlert(context, await userStateW.getUserEmail());
      }
      final username = await userStateW.getUserName();
      userName.value = username;
      isBrand.value = await userStateW.isBrand();
      isCompleted.value = await userStateW.isProfileCompleted();
    }

    useEffect(() {
      init();
      return null;
    }, []);

    return WillPopScope(
      onWillPop: () async {
        exitAlert(context);
        return false;
      },
      child: Scaffold(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Header(),
                  if (isCompleted.value == false) ...[
                    Container(
                      width: width,
                      margin: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: primaryC,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                              color: shadowC,
                              blurRadius: 5,
                              offset: Offset(0, 6))
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
                                  isCompleted.value = true;
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
                              "Your linked social media accounts are under\nverification, you'll be not notified withen 14 hours.",
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
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: ((context) => const BrandInput()),
                              //   ),
                              // );
                              if (isBrand.value) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => const BrandInput()),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) =>
                                        const InfluencerInput()),
                                  ),
                                );
                              }
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
                        color: secondaryC,
                        fontSize: 40,
                        fontWeight: FontWeight.w900),
                  ),
                  const Text(
                    "Reach the next billion",
                    textScaleFactor: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: secondaryC,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
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
                                decoration:
                                    const BoxDecoration(color: Colors.amber),
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
                        BoxShadow(
                            color: shadowC, blurRadius: 5, offset: Offset(0, 6))
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
                              child:
                                  Image.asset("assets/images/homeavatar.png"),
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
          ),
        ),
      ),
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
                  imgUrl: "assets/images/brand/adidas.jpg",
                  title: "Adidas Cases",
                  btnColor: const Color(0xfffbc98e),
                  btnText: "Learn more & apply",
                  btnFunction: () {
                    comingalert(context);
                  },
                  website: "www.adidas.co.in",
                  category: "Category: Sport Apparels",
                  isHeart: false,
                  amount: "3500",
                  currency: "USD",
                  platforms: const [
                    "assets/images/instagram.png",
                    "assets/images/facebook.png",
                    "assets/images/facebook.png",
                    "assets/images/facebook.png",
                  ],
                  networkImg: false,
                ),
                HomeCard(
                  imgUrl: "assets/images/brand/furinicom.jpg",
                  title: "Furnicom",
                  btnColor: const Color(0xfffbc98e),
                  btnText: "Learn more & apply",
                  btnFunction: () {
                    comingalert(context);
                  },
                  website: "www.furniture.com",
                  category: "Category: furniture Store",
                  isHeart: false,
                  amount: "3500",
                  currency: "USD",
                  platforms: const [
                    "assets/images/instagram.png",
                    "assets/images/instagram.png",
                    "assets/images/instagram.png",
                    "assets/images/instagram.png",
                    "assets/images/instagram.png",
                  ],
                  networkImg: false,
                ),
                HomeCard(
                  imgUrl: "assets/images/brand/hilton.jpg",
                  title: "Hilton",
                  btnColor: const Color(0xfffbc98e),
                  btnText: "Learn more & apply",
                  btnFunction: () {
                    comingalert(context);
                  },
                  website: "www.hilton.in",
                  category: "Category: Hotels",
                  isHeart: false,
                  amount: "3500",
                  currency: "USD",
                  platforms: const [
                    "assets/images/instagram.png",
                    "assets/images/facebook.png"
                  ],
                  networkImg: false,
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
                  imgUrl: "assets/images/brand/lucent.jpg",
                  title: "Lucent Skin",
                  btnColor: const Color(0xff80fff9),
                  btnText: "View",
                  btnFunction: () {
                    comingalert(context);
                  },
                  website: "www.lucent.co.in",
                  category: "Category: Dermatologist",
                  isSocial: false,
                  amount: "3500",
                  currency: "USD",
                  platforms: const [
                    "assets/images/instagram.png",
                    "assets/images/facebook.png"
                  ],
                  networkImg: false,
                ),
                HomeCard(
                  imgUrl: "assets/images/brand/powerfitgym.jpg",
                  title: "PoweerFIT Gym",
                  btnColor: const Color(0xff80fff9),
                  btnText: "View",
                  btnFunction: () {
                    comingalert(context);
                  },
                  website: "www.powerfit.co.in",
                  category: "Category: Fitness",
                  isSocial: false,
                  amount: "3500",
                  currency: "USD",
                  platforms: const [
                    "assets/images/instagram.png",
                    "assets/images/facebook.png"
                  ],
                  networkImg: false,
                ),
                HomeCard(
                  imgUrl: "assets/images/brand/ups.jpg",
                  title: "UPS",
                  btnColor: const Color(0xff80fff9),
                  btnText: "View",
                  btnFunction: () {
                    comingalert(context);
                  },
                  website: "www.usp.in",
                  category: "Category: Delivery",
                  isSocial: false,
                  amount: "3500",
                  currency: "USD",
                  platforms: const [
                    "assets/images/instagram.png",
                    "assets/images/facebook.png"
                  ],
                  networkImg: false,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
