import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/view/home/drafts.dart';
import 'package:swrv/view/home/earnings.dart';
import 'package:swrv/view/home/favourite.dart';
import 'package:swrv/view/home/help.dart';
import 'package:swrv/view/home/inbox.dart';
import 'package:swrv/view/home/invite.dart';
import 'package:swrv/view/infopages/forgetpassword.dart';
import 'package:swrv/view/infopages/termsandcon.dart';
import 'package:swrv/view/navigation/drawer.dart';
import 'package:swrv/state/navstate.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/view/campaings/campaign.dart';
import 'package:swrv/view/campaings/campaigninfo.dart';
import 'package:swrv/view/campaings/compaignconnect.dart';
import 'package:swrv/view/home/home.dart';
import 'package:swrv/view/user/editprofile.dart';
import 'package:swrv/view/user/profile.dart';
import 'package:swrv/widgets/alerts.dart';

import '../campaings/createcampaign.dart';

class Bottomnav extends HookConsumerWidget {
  Bottomnav({super.key});

  static const List pages = [
    //bottom nav pages 0 t0 5
    HomePage(),
    HomePage(),
    ForgetPassInfo(),
    HomePage(),
    TermsAndConInfo(),
    Profile(),
    //drawer pages 6 to 20
    FindCampaings(),
    Inbox(),
    EarningsPage(),
    DraftsPage(),
    FavouritePage(),
    InvitePage(),
    HelpPage(),
    FindCampaings(),
    FindCampaings(),
    FindCampaings(),
    FindCampaings(),
    FindCampaings(),
    FindCampaings(),
    FindCampaings(),
    FindCampaings(),
    //campaings 21 - 30
    CampaignsInfo(),
    CampaignConnect(),
    CreateCampaings(),
    CampaignConnect(),
    CampaignConnect(),
    CampaignConnect(),
    CampaignConnect(),
    CampaignConnect(),
    CampaignConnect(),
    CampaignConnect(),
    //user profile
    EditProfile(),
  ];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final GlobalKey<ScaffoldState> scaffoldKey = useMemoized(()=> GlobalKey<ScaffoldState>());
    final width = MediaQuery.of(context).size.width;

    final indexPage = ref.watch(pageIndex);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: backgroundC,
      drawerEnableOpenDragGesture: false,
      drawer: CusDrawer(
        scaffoldKey: scaffoldKey,
      ),
      bottomNavigationBar: Container(
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
                ref.read(pageIndex.notifier).state = 2;
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: indexPage == 2 ? secondaryC : whiteC,
                    borderRadius: BorderRadius.circular(10)),
                child: FaIcon(
                  FontAwesomeIcons.folderOpen,
                  size: 30,
                  color: indexPage == 2 ? whiteC : secondaryC,
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -25),
              child: GestureDetector(
                onTap: () {
                  connectAlert(context);
                },
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
                ref.read(pageIndex.notifier).state = 4;
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: indexPage == 4 ? secondaryC : whiteC,
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(
                  CupertinoIcons.envelope_open_fill,
                  size: 30,
                  color: indexPage == 4 ? whiteC : secondaryC,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                ref.read(pageIndex.notifier).state = 5;
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: indexPage == 5 ? secondaryC : whiteC,
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(
                  CupertinoIcons.person_fill,
                  size: 30,
                  color: indexPage == 5 ? whiteC : secondaryC,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: pages[indexPage],
      ),
    );
  }
}
