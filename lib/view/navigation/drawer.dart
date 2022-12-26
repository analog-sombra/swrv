import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:swrv/state/navigation/drawer.dart';
import 'package:swrv/state/userstate.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/view/home/search.dart';
import 'package:swrv/view/campaings/mycompaign.dart';
import 'package:swrv/view/home/favourite_brand.dart';
import 'package:swrv/view/home/inbox.dart';

import '../home/drafts.dart';
import '../home/earnings.dart';
import '../home/favourite_cam.dart';
import '../home/help.dart';
import '../home/invite.dart';

class CusDrawer extends HookConsumerWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const CusDrawer({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<bool> isBrand = useState(false);
    UserState userStateW = ref.watch(userState);
    ValueNotifier<String> version = useState("");

    Future<void> setVerion() async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      version.value = packageInfo.version;
    }

    void init() async {
      isBrand.value = await userStateW.isBrand();
      await setVerion();
    }

    useEffect(() {
      init();
      return null;
    }, []);
    return GestureDetector(
      onHorizontalDragUpdate: (info) => {},
      child: ClipRRect(
        borderRadius: const BorderRadius.horizontal(right: Radius.circular(15)),
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
                      index: 1,
                      icon: FontAwesomeIcons.folderOpen,
                      title: "My Campaign",
                      isFontAwesome: true,
                      scaffoldKey: scaffoldKey,
                      page: const MyCampaings(),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DrawerButton(
                      index: 6,
                      icon: Icons.search,
                      title: "Find Campaign",
                      isFontAwesome: false,
                      scaffoldKey: scaffoldKey,
                      page: const Search(),
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
                      page: const Inbox(),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (!isBrand.value) ...[
                      DrawerButton(
                        index: 8,
                        icon: FontAwesomeIcons.handHoldingDollar,
                        title: "My earnings",
                        isFontAwesome: true,
                        scaffoldKey: scaffoldKey,
                        page: const EarningsPage(),
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
                        page: const DraftsPage(),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                    DrawerButton(
                      index: 10,
                      icon: Icons.favorite,
                      title: "Favourite Campaigns",
                      isFontAwesome: false,
                      scaffoldKey: scaffoldKey,
                      page: const FavouritePage(),
                    ),
                    if (isBrand.value == false) ...[
                      const SizedBox(
                        height: 15,
                      ),
                      DrawerButton(
                        index: 11,
                        icon: Icons.favorite,
                        title: "Favourite Brands",
                        isFontAwesome: false,
                        scaffoldKey: scaffoldKey,
                        page: const FavouriteBrand(),
                      ),
                    ],
                    const SizedBox(
                      height: 15,
                    ),
                    DrawerButton(
                      index: 12,
                      icon: Icons.person_search,
                      title: "Invite",
                      isFontAwesome: false,
                      scaffoldKey: scaffoldKey,
                      page: const InvitePage(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    DrawerButton(
                      index: 13,
                      icon: Icons.help,
                      title: "Help",
                      isFontAwesome: false,
                      scaffoldKey: scaffoldKey,
                      page: const HelpPage(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "App Version: ${version.value}",
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.55),
                        ),
                      ),
                    )
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
  final Widget page;
  const DrawerButton({
    Key? key,
    required this.index,
    required this.icon,
    required this.title,
    required this.isFontAwesome,
    required this.scaffoldKey,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drawerIndexW = ref.read(drawerIndex);
    return GestureDetector(
      onTap: () {
        scaffoldKey.currentState?.closeDrawer();
        drawerIndexW.setIndex(index);
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        width: 230,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: drawerIndexW.index == index ? tertiaryC : whiteC,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            if (isFontAwesome) ...[
              FaIcon(
                icon,
                color: drawerIndexW.index == index ? whiteC : tertiaryC,
              ),
            ] else ...[
              Icon(
                icon,
                color: drawerIndexW.index == index ? whiteC : tertiaryC,
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
                color: drawerIndexW.index == index ? whiteC : tertiaryC,
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
