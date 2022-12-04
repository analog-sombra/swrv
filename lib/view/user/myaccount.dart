
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/widgets/cuswidgets.dart';

import '../../state/userstate.dart';
import '../../utils/alerts.dart';
import '../../widgets/componets.dart';
import '../campaings/createcampaign.dart';
import '../navigation/bottomnavbar.dart';
import '../navigation/drawer.dart';

class MyAccount extends HookConsumerWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());
    final width = MediaQuery.of(context).size.width;

    ValueNotifier<bool> isBrand = useState(false);
    final userStateW = ref.watch(userState);

    void init() async {
      isBrand.value = await userStateW.isBrand();
    }

    ValueNotifier<List> data = useState([
      {"name": "Posts", "num": "345"},
      {"name": "Followers", "num": "654"},
      {"name": "Post Engagement", "num": "643"},
      {"name": "Post Reach", "num": "456"},
      {"name": "Post View", "num": "335"},
    ]);
    useEffect(() {
      init();
      return null;
    }, []);

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Header(),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: width,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: whiteC,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: shadowC,
                    blurRadius: 5,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    child: Image.asset("assets/images/car.jpg"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Alexander Hirschi",
                              textScaleFactor: 1,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: blackC,
                              ),
                            ),
                            Row(
                              children: [
                                for (int i = 0; i < 4; i++) ...[
                                  const Icon(Icons.star, color: secondaryC)
                                ],
                                Icon(Icons.star,
                                    color: blackC.withOpacity(0.35))
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            // width: 200,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: backgroundC,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                    color: shadowC,
                                    blurRadius: 5,
                                    offset: Offset(0, 6))
                              ],
                            ),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "2 00 5887",
                                          textScaleFactor: 1,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: blackC),
                                        ),
                                        Text(
                                          "Reach",
                                          textScaleFactor: 1,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: blackC),
                                        ),
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: blackC.withOpacity(0.55),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "1 34 9887",
                                          textScaleFactor: 1,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: blackC),
                                        ),
                                        Text(
                                          "impression",
                                          textScaleFactor: 1,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: blackC),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(
                      "Bio",
                      textScaleFactor: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: blackC),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Don't miss out on Early Access sale of EOSS for members only. Become a Adi club member and get Early access to EOSS from 21st to 23rd June. adidas® Official Shop. Free Shipping. Types: Running Shoes, Running Shorts & Tights, Running Jackets, Tracksuits & Track Pants.Don't miss out on Early Access sale of EOSS for members only. Become a Adi club member and get Early access to EOSS from 21st to 23rd June. adidas® Official Shop. Free Shipping. Types: Running Shoes, Running Shorts & Tights, Running Jackets, Tracksuits & Track Pants.",
                      textScaleFactor: 1,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: blackC),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: CusBtn(
                      btnColor: secondaryC,
                      btnText: "Sent Message",
                      textSize: 18,
                      btnFunction: () {
                        comingalert(context);
                      },
                      elevation: 1,
                    ),
                  ),
                ],
              ),
            ),
            if (isBrand.value) ...[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                width: width,
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: whiteC,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: shadowC,
                      blurRadius: 5,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Would yo like to collaorate ?",
                      textScaleFactor: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: blackC),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CusBtn(
                      btnColor: primaryC,
                      btnText: "create campign",
                      textSize: 18,
                      btnFunction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateCampaignsPage(),
                          ),
                        );
                      },
                      elevation: 1,
                    ),
                    CusBtn(
                      btnColor: const Color(0xFF10BCE2),
                      btnText: "Invite to a campaign",
                      textSize: 18,
                      btnFunction: () {
                        // ref.read(pageIndex.state).state = 32;
                      },
                      elevation: 1,
                    ),
                  ],
                ),
              ),
            ],
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              width: width,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: whiteC,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: shadowC,
                    blurRadius: 5,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  for (int i = 0; i < data.value.length; i++) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: blackC.withOpacity(0.35),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            data.value[i]["name"],
                            textScaleFactor: 1,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: secondaryC,
                            ),
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                data.value[i]["num"],
                                textScaleFactor: 1,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: secondaryC,
                                ),
                              ),
                              const Text(
                                "30% of stands",
                                textScaleFactor: 1,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF7CFF01),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              width: width,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: whiteC,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: shadowC,
                    blurRadius: 5,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Average result",
                    textScaleFactor: 1,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: secondaryC),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  for (int i = 0; i < data.value.length; i++) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: blackC.withOpacity(0.35),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            data.value[i]["name"],
                            textScaleFactor: 1,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: secondaryC,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            data.value[i]["num"],
                            textScaleFactor: 1,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: secondaryC,
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
    );
  }
}
