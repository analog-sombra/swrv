import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/state/navstate.dart';
import 'package:swrv/utils/utilthemes.dart';

class CusDrawer extends HookConsumerWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const CusDrawer({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onHorizontalDragUpdate: (info) => {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Drawer(
          backgroundColor: whiteC,
          child: SingleChildScrollView(
            child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Image.asset("assets/images/logo.png"),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            scaffoldKey.currentState?.closeDrawer();
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 15, top: 10, right: 5, bottom: 10),
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: tertiaryC,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 25,
                              color: whiteC,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    DrawerButton(
                      index: 0,
                      icon: FontAwesomeIcons.folderOpen,
                      title: "My campaings",
                      isFontAwesome: true,
                      scaffoldKey: scaffoldKey,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DrawerButton(
                      index: 6,
                      icon: Icons.search,
                      title: "Find campaings",
                      isFontAwesome: false,
                      scaffoldKey: scaffoldKey,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DrawerButton(
                      index: 7,
                      icon: Icons.inbox,
                      title: "Inbox",
                      isFontAwesome: false,
                      scaffoldKey: scaffoldKey,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DrawerButton(
                      index: 8,
                      icon: FontAwesomeIcons.handHoldingDollar,
                      title: "My earnings",
                      isFontAwesome: true,
                      scaffoldKey: scaffoldKey,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DrawerButton(
                      index: 9,
                      icon: Icons.drafts,
                      title: "Drafts",
                      isFontAwesome: false,
                      scaffoldKey: scaffoldKey,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DrawerButton(
                      index: 10,
                      icon: Icons.favorite,
                      title: "Favourite",
                      isFontAwesome: false,
                      scaffoldKey: scaffoldKey,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DrawerButton(
                      index: 11,
                      icon: Icons.person_search,
                      title: "Invite",
                      isFontAwesome: false,
                      scaffoldKey: scaffoldKey,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    DrawerButton(
                      index: 12,
                      icon: Icons.help,
                      title: "Help",
                      isFontAwesome: false,
                      scaffoldKey: scaffoldKey,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class DrawerButton extends HookConsumerWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final int index;
  final IconData icon;
  final String title;
  final bool isFontAwesome;
  const DrawerButton({
    Key? key,
    required this.index,
    required this.icon,
    required this.title,
    required this.isFontAwesome,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexpage = ref.read(pageIndex);
    return GestureDetector(
      onTap: () {
        scaffoldKey.currentState?.closeDrawer();
        ref.read(pageIndex.state).state = index;
      },
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: indexpage == index ? tertiaryC : whiteC,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            if (isFontAwesome) ...[
              FaIcon(
                icon,
                color: indexpage == index ? whiteC : tertiaryC,
              ),
            ] else ...[
              Icon(
                icon,
                color: indexpage == index ? whiteC : tertiaryC,
              ),
            ],
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              textScaleFactor: 1,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: indexpage == index ? whiteC : tertiaryC,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
