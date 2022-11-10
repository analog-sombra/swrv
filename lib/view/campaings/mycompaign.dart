import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/components/header.dart';
import 'package:swrv/state/navstate.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/widgets/componets.dart';

import '../../services/apirequest.dart';
import '../../state/userstate.dart';

class MyCampaings extends HookConsumerWidget {
  const MyCampaings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final userStateW = ref.watch(userState);
    ValueNotifier<bool> isFinished = useState(false);
    CusApiReq apiReq = CusApiReq();

    ValueNotifier<List> champ = useState([]);

    void init() async {
      final userid = await userStateW.getUserId();
      final req = {"id": userid};
      try {
        log(userid.toString());
        dynamic data = await apiReq.postApi(jsonEncode(req),
            path: "/api/get-my-campaigns");

        champ.value = data[0]["data"]["campaigns"];
        // log(data.toString());

        // log(data[0]["data"].toString());
        // log(data[0]["data"]["campaigns"].toString());
      } catch (e) {
        log(e.toString());
      }
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

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Header(),
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
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
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
                      for (int i = 0; i < champ.value.length; i++) ...[
                        HomeCard(
                          imgUrl: "assets/images/post1.jpg",
                          title: champ.value[i]["name"],
                          btnColor: const Color(0xfffbc98e),
                          btnText: "View",
                          btnFunction: () {
                            ref.read(pageIndex.state).state = 21;
                          },
                          website:
                              "Min Eligible Rating : ${champ.value[i]["minEligibleRating"]}",
                          category:
                              "Category: ${champ.value[i]["type"]["name"]}",
                          isHeart: false,
                          amount: "${champ.value[i]["totalBudget"]}",
                          currency: "${champ.value[i]["currency"]["code"]}",
                          platforms: platformUrls(champ.value[i]["platforms"]),
                          // platforms:  champ.value[i]["platforms"],
                          // platforms: [
                          //   for (int j = 0;
                          //       j < champ.value[i]["platforms"].length;
                          //       j++)
                          //     {
                          //        "${champ.value[i]["platforms"][j]["platformLogoUrl"]}",
                          //     }
                          // ]
                        ),
                      ],
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}
