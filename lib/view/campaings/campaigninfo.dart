import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/components/header.dart';
import 'package:swrv/state/navstate.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/widgets/componets.dart';
import 'package:swrv/widgets/cuswidgets.dart';

class CampaignsInfo extends HookConsumerWidget {
  const CampaignsInfo({super.key});

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
            name: "analog-sombra",
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Adidas Cases",
                            textAlign: TextAlign.left,
                            textScaleFactor: 1,
                            style: TextStyle(
                                color: blackC,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
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
                          Text(
                            "www.adidas.co.in",
                            textAlign: TextAlign.left,
                            textScaleFactor: 1,
                            style: TextStyle(
                                color: blackC.withOpacity(0.55),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    direction: Axis.horizontal,
                    children: [
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                            color: whiteC,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5)
                            ]),
                        child: Row(children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: backgroundC,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                                const Icon(Icons.star, color: blackC, size: 45),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "4.2",
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      color: blackC,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Rating",
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      color: blackC.withOpacity(0.65),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          )
                        ]),
                      ),
                      Container(
                        width: 150,
                        decoration: BoxDecoration(
                            color: whiteC,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5)
                            ]),
                        child: Row(children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: backgroundC,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.handshake,
                                color: blackC, size: 45),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "21",
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      color: blackC,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Connections",
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      color: blackC.withOpacity(0.65),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          )
                        ]),
                      ),
                      Container(
                        width: 200,
                        decoration: BoxDecoration(
                            color: whiteC,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5)
                            ]),
                        child: Row(children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: backgroundC,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.people_alt,
                                color: blackC, size: 45),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "48",
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      color: blackC,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Completed Campaigns",
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      color: blackC.withOpacity(0.65),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          )
                        ]),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: CusBtn(
                      btnColor: primaryC,
                      btnText: "Connect",
                      textSize: 18,
                      btnFunction: () {
                        ref.read(pageIndex.state).state = 22;
                      }),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Brand info",
                    textScaleFactor: 1,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: secondaryC),
                  ),
                ),
                const Text(
                  "Don't miss out on Early Access sale of EOSS for members only. Become a Adi club member and get Early access to EOSS from 21st to 23rd June. adidas® Official Shop. Free Shipping. Types: Running Shoes, Running Shorts & Tights, Running Jackets, Tracksuits & Track Pants Don't miss out on Early Access sale of EOSS for members only. Become a Adi club member and get Early access to EOSS from 21st to 23rd June. adidas® Official Shop. Free Shipping. Types: Running Shoes, Running Shorts & Tights, Running Jackets, Tracksuits & Track Pants.Don't miss out on Early Access sale of EOSS for members only. Become a Adi club member and get Early access to EOSS from 21st to 23rd June. adidas® Official Shop. Free Shipping. Types: Running Shoes, Running Shorts & Tights, Running Jackets, Tracksuits & Track Pants.Don't miss out on Early Access sale of EOSS for members only. Become a Adi club member and get Early access to EOSS from 21st to 23rd June. adidas® Official Shop. Free Shipping. Types: Running Shoes, Running Shorts & Tights, Running Jackets, Tracksuits & Track Pants.Don't miss out on Early Access sale of EOSS for members only. Become a Adi club member and get Early access to EOSS from 21st to 23rd June. adidas® Official Shop. Free Shipping. Types: Running Shoes, Running Shorts & Tights, Running Jackets, Tracksuits & Track Pants..",
                  textScaleFactor: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400, color: blackC),
                ),
              ],
            ),
          ),
          const CampaingList(),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}

class CampaingList extends HookConsumerWidget {
  const CampaingList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<bool> isPast = useState(false);

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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                      backgroundColor:
                          isPast.value ? backgroundC : const Color(0xff01fff4),
                    ),
                    onPressed: () {
                      isPast.value = false;
                    },
                    child: Text(
                      "Available Campaigns",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1,
                      style: TextStyle(
                          color:
                              isPast.value ? blackC.withOpacity(0.65) : blackC,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor:
                          isPast.value ? const Color(0xff01fff4) : backgroundC,
                    ),
                    onPressed: () {
                      isPast.value = true;
                    },
                    child: Text(
                      "Past associations",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1,
                      style: TextStyle(
                          color:
                              isPast.value ? blackC : blackC.withOpacity(0.65),
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
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
