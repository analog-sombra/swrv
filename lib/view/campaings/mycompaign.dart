import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/components/header.dart';
import 'package:swrv/state/navstate.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/widgets/componets.dart';

class MyCampaings extends HookConsumerWidget {
  const MyCampaings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    ValueNotifier<bool> isFinished = useState(false);

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Header(

          ),
          const Padding(
            padding: EdgeInsets.only(left: 25, top: 20),
            child: Text(
              "My campaigs",
              textScaleFactor: 1,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w800, color: blackC),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 25, top: 10),
            child: Text(
              "Here you can manage all the\ncampaigns that you are participating in.",
              textScaleFactor: 1,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w400, color: blackC),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                          isFinished.value ? whiteC : const Color(0xff01fff4),
                    ),
                    onPressed: () {
                      isFinished.value = false;
                    },
                    child: Text(
                      "Active Campaigns",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1,
                      style: TextStyle(
                          color: isFinished.value
                              ? blackC.withOpacity(0.65)
                              : blackC,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
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
                          isFinished.value ? const Color(0xff01fff4) : whiteC,
                    ),
                    onPressed: () {
                      isFinished.value = true;
                    },
                    child: Text(
                      "Finished campaigns",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1,
                      style: TextStyle(
                          color: isFinished.value
                              ? blackC
                              : blackC.withOpacity(0.65),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
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
                  btnText: "View",
                  btnFunction: () {
                    ref.read(pageIndex.state).state = 21;
                  },
                  website: "www.adidas.co.in",
                  category: "Category: Consumer Electronics",
                  isHeart: false,
                ),
                HomeCard(
                  imgUrl: "assets/images/post1.jpg",
                  title: "Adidas Cases",
                  btnColor: const Color(0xfffbc98e),
                  btnText: "View",
                  btnFunction: () {
                    ref.read(pageIndex.state).state = 21;
                  },
                  website: "www.adidas.co.in",
                  category: "Category",
                  isHeart: false,
                ),
                HomeCard(
                  imgUrl: "assets/images/post1.jpg",
                  title: "Adidas Cases",
                  btnColor: const Color(0xfffbc98e),
                  btnText: "View",
                  btnFunction: () {
                    ref.read(pageIndex.state).state = 21;
                  },
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
