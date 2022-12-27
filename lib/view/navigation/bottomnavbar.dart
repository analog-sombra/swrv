// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/state/navigation/drawer.dart';
import 'package:swrv/view/home/earnings.dart';
import 'package:swrv/view/home/invite.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/view/user/profile.dart';

class BotttomBar extends HookConsumerWidget {
  const BotttomBar({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final bottomBarW = ref.watch(bottomIndex);
    return Container(
      width: width,
      height: 60,
      decoration: BoxDecoration(
        color: whiteC,
        boxShadow: [
          BoxShadow(
            color: blackC.withOpacity(0.15),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () async {
              scaffoldKey.currentState?.openDrawer();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: whiteC, borderRadius: BorderRadius.circular(10)),
              child: const FaIcon(
                FontAwesomeIcons.bars,
                size: 30,
                color: secondaryC,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              bottomBarW.setIndex(2);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const EarningsPage()),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: bottomBarW.index == 2 ? secondaryC : whiteC,
                  borderRadius: BorderRadius.circular(10)),
              child: FaIcon(
                FontAwesomeIcons.folderOpen,
                size: 30,
                color: bottomBarW.index == 2 ? whiteC : secondaryC,
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -25),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    color: secondaryC, shape: BoxShape.circle),
                child: const FaIcon(
                  FontAwesomeIcons.rightLeft,
                  color: whiteC,
                  size: 30,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              bottomBarW.setIndex(4);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InvitePage(),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: bottomBarW.index == 4 ? secondaryC : whiteC,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                CupertinoIcons.envelope_open_fill,
                size: 30,
                color: bottomBarW.index == 4 ? whiteC : secondaryC,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              bottomBarW.setIndex(5);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Profile(),
                  ),
                  (Route<dynamic> route) => false);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: bottomBarW.index == 5 ? secondaryC : whiteC,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                CupertinoIcons.person_fill,
                size: 30,
                color: bottomBarW.index == 5 ? whiteC : secondaryC,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
