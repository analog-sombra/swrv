// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/state/navigation/drawer.dart';
import 'package:swrv/view/home/invite.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/view/campaings/findcampaign.dart';
import 'package:swrv/view/user/profile.dart';


// class Bottomnav extends HookConsumerWidget {
//   final bool isWelcomeAlert;
//   Bottomnav({Key? key, this.isWelcomeAlert = false}) : super(key: key);

//   static const List pages = [
//     //bottom nav pages 0 t0 5
//     HomePage(),
//     HomePage(),
//     EarningsPage(),
//     // ForgetPassInfo(),
//     HomePage(),
//     DraftsPage(),
//     // TermsAndConInfo(),
//     Profile(),
//     //drawer pages 6 to 20
//     FindCampaings(),
//     Inbox(),
//     EarningsPage(),
//     DraftsPage(),
//     FavouritePage(),
//     InvitePage(),
//     HelpPage(),
//     FindCampaings(),
//     FindCampaings(),
//     FindCampaings(),
//     FindCampaings(),
//     FindCampaings(),
//     FindCampaings(),
//     FindCampaings(),
//     FindCampaings(),
//     //campaings 21 - 30
//     CampaignsInfo(),
//     CampaignConnect(),
//     CreateCampaignsPage(),
//     CreateCampaings(),
//     CampaignsPreview(),
//     MyCampaings(),
//     CampaignConnect(),
//     CampaignConnect(),
//     CampaignConnect(),
//     CampaignConnect(),
//     //user profile
//     EditProfile(),
//     //band 32 - 35
//     CreateBrandPage(),
//     CreateBrandPage(),
//     CreateBrandPage(),
//     CreateBrandPage(),
//     //info pages 35
//     ForgetPassInfo(),
//   ];
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final GlobalKey<ScaffoldState> scaffoldKey = useMemoized(()=> GlobalKey<ScaffoldState>());
//     final width = MediaQuery.of(context).size.width;

//     final indexPage = ref.watch(pageIndex);
//     final userStateW = ref.watch(userState);

//     void init() async {
//       if (isWelcomeAlert) {
//         await Future.delayed(const Duration(milliseconds: 400));
//         welcomeAlert(context, await userStateW.getUserEmail());
//       }
//     }

//     useEffect(() {
//       init();
//       return null;
//     }, []);

//     return WillPopScope(
//       onWillPop: () async {
//         if (ref.watch(pageIndex) != 0) {
//           ref.watch(pageIndex.state).state = 0;
//         } else {
//           exitAlert(context);
//         }

//         return false;
//       },
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: backgroundC,
//         drawerEnableOpenDragGesture: false,
//         drawer: CusDrawer(
//           scaffoldKey: scaffoldKey,
//         ),
//         bottomNavigationBar: Container(
//           width: width,
//           height: 60,
//           decoration: BoxDecoration(
//             color: whiteC,
//             boxShadow: [
//               BoxShadow(
//                 color: blackC.withOpacity(0.15),
//                 blurRadius: 10,
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               GestureDetector(
//                 onTap: () async {
//                   scaffoldKey.currentState?.openDrawer();
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 10),
//                   padding: const EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                       color: whiteC, borderRadius: BorderRadius.circular(10)),
//                   child: const FaIcon(
//                     FontAwesomeIcons.bars,
//                     size: 30,
//                     color: secondaryC,
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   ref.read(pageIndex.notifier).state = 2;
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 10),
//                   padding: const EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                       color: indexPage == 2 ? secondaryC : whiteC,
//                       borderRadius: BorderRadius.circular(10)),
//                   child: FaIcon(
//                     FontAwesomeIcons.folderOpen,
//                     size: 30,
//                     color: indexPage == 2 ? whiteC : secondaryC,
//                   ),
//                 ),
//               ),
//               Transform.translate(
//                 offset: const Offset(0, -25),
//                 child: GestureDetector(
//                   onTap: () {
//                     // welcomeAlert(context);
//                     // connectAlert(context);
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 5),
//                     padding: const EdgeInsets.all(15),
//                     decoration: const BoxDecoration(
//                         color: secondaryC, shape: BoxShape.circle),
//                     child: const FaIcon(
//                       FontAwesomeIcons.rightLeft,
//                       color: whiteC,
//                       size: 30,
//                     ),
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   ref.read(pageIndex.notifier).state = 4;
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 10),
//                   padding: const EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                       color: indexPage == 4 ? secondaryC : whiteC,
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Icon(
//                     CupertinoIcons.envelope_open_fill,
//                     size: 30,
//                     color: indexPage == 4 ? whiteC : secondaryC,
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   ref.read(pageIndex.notifier).state = 5;
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 10),
//                   padding: const EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                       color: indexPage == 5 ? secondaryC : whiteC,
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Icon(
//                     CupertinoIcons.person_fill,
//                     size: 30,
//                     color: indexPage == 5 ? whiteC : secondaryC,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: SafeArea(
//           child: pages[indexPage],
//         ),
//       ),
//     );
//   }
// }

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
                  builder: ((context) => const FindCampaings()),
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
              onTap: () {
                // welcomeAlert(context);
                // connectAlert(context);
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
          GestureDetector(
            onTap: () {
              bottomBarW.setIndex(5);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Profile(),
                ),
              );
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
