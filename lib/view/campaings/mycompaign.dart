import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/widgets/componets.dart';

import '../../services/apirequest.dart';
import '../../state/userstate.dart';
import '../navigation/bottomnavbar.dart';
import '../navigation/drawer.dart';
import 'campaigninfo.dart';

class MyCampaings extends HookConsumerWidget {
  const MyCampaings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());
    final width = MediaQuery.of(context).size.width;
    final userStateW = ref.watch(userState);
    ValueNotifier<bool> isFinished = useState(false);
    CusApiReq apiReq = CusApiReq();

    ValueNotifier<List> champ = useState([]);

    void init() async {
      final userid = await userStateW.getUserId();
      final req = {"id": userid};

      dynamic data =
          await apiReq.postApi(jsonEncode(req), path: "/api/get-my-campaigns");

      champ.value = data[0]["data"]["campaigns"];
    }

    useEffect(() {
      init();
      return null;
    }, []);

    List platformUrls(List plt) {
      List data = [];

      for (int j = 0; j < plt.length; j++) {
        data.add(plt[j]["platformLogoUrl"]);
      }
      return data;
    }

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Header(),
              const Padding(
                padding: EdgeInsets.only(left: 25, top: 20),
                child: Text(
                  "My campaign",
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                          backgroundColor: isFinished.value
                              ? whiteC
                              : const Color(0xff01fff4),
                        ),
                        onPressed: () {
                          isFinished.value = false;
                        },
                        child: Text(
                          "Active Campaign",
                          textAlign: TextAlign.center,
                          textScaleFactor: 1,
                          style: TextStyle(
                              color: isFinished.value
                                  ? blackC.withOpacity(0.65)
                                  : blackC,
                              fontSize: 12,
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
                          backgroundColor: isFinished.value
                              ? const Color(0xff01fff4)
                              : whiteC,
                        ),
                        onPressed: () {
                          isFinished.value = true;
                        },
                        child: Text(
                          "Finished campaign",
                          textAlign: TextAlign.center,
                          textScaleFactor: 1,
                          style: TextStyle(
                              color: isFinished.value
                                  ? blackC
                                  : blackC.withOpacity(0.65),
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (champ.value.isEmpty) ...[
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
                    children: const [
                      Text(
                        "You have no campaign right now",
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: blackC),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                Container(
                  width: width,
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                          color: shadowC, blurRadius: 5, offset: Offset(0, 6))
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
                            for (int i = 0; i < champ.value.length; i++) ...[
                              HomeCard(
                                imgUrl: champ.value[i]["brand"]["logo"],
                                title: champ.value[i]["name"],
                                btnColor: const Color(0xfffbc98e),
                                btnText: "View",
                                btnFunction: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChampignInfo(
                                        id: champ.value[i]["id"],
                                      ),
                                    ),
                                  );
                                },
                                website:
                                    "Min Eligible Rating : ${champ.value[i]["minEligibleRating"]}",
                                category:
                                    "Category: ${champ.value[i]["type"]["name"]}",
                                isHeart: false,
                                amount: "${champ.value[i]["totalBudget"]}",
                                currency:
                                    "${champ.value[i]["currency"]["code"]}",
                                platforms:
                                    platformUrls(champ.value[i]["platforms"]),
                              ),
                            ],
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
