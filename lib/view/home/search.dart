// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/widgets/componets.dart';

import '../../state/compaign/findcompaignstate.dart';
import '../../state/influencer/findinfluencerstate.dart';
import '../../state/userstate.dart';
import '../navigation/bottomnavbar.dart';
import '../navigation/drawer.dart';
import '../search/brandsearch.dart';
import '../search/campaignsearch.dart';
import '../search/usersearch.dart';

class Search extends HookConsumerWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());

    final findCampStateW = ref.watch(findCampState);
    final findInfStateW = ref.watch(findInfState);

    ValueNotifier<bool> isBrand = useState(false);
    final userStateW = ref.watch(userState);

    void init() async {
      isBrand.value = await userStateW.isBrand();
    }

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
                  "Find campaign",
                  textScaleFactor: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w800, color: blackC),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 25, top: 10),
                child: Text(
                  "Here you can manage all the campaign that you\nare participating in.",
                  textScaleFactor: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400, color: blackC),
                ),
              ),
              if (isBrand.value == false) ...[
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
                            backgroundColor: findCampStateW.isBrand
                                ? whiteC
                                : const Color(0xff01fff4),
                          ),
                          onPressed: () {
                            findCampStateW.setIsBrand(false);
                          },
                          child: Text(
                            "Campaign",
                            textAlign: TextAlign.center,
                            textScaleFactor: 1,
                            style: TextStyle(
                                color: findCampStateW.isBrand
                                    ? blackC.withOpacity(0.65)
                                    : blackC,
                                fontSize: 16,
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
                            backgroundColor: findCampStateW.isBrand
                                ? const Color(0xff01fff4)
                                : whiteC,
                          ),
                          onPressed: () {
                            findCampStateW.setIsBrand(true);
                          },
                          child: Text(
                            "Brand",
                            textAlign: TextAlign.center,
                            textScaleFactor: 1,
                            style: TextStyle(
                                color: findCampStateW.isBrand
                                    ? blackC
                                    : blackC.withOpacity(0.65),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (isBrand.value) ...[
                //influancer search
                if (findInfStateW.isAdvance) ...[
                  const AdvanceInfSearch(),
                ] else ...[
                  const TextInfSeach(),
                ],
                const UserList()
                //is user is brand
              ] else ...[
                if (findCampStateW.isBrand) ...[
                  //brand search
                  const TextBrandSearch(),
                  const BrandList(),
                ] else ...[
                  //campaignSearch
                  if (findCampStateW.isAdvance) ...[
                    const AdvanceCampaignSearch(),
                  ] else ...[
                    const TextCampaignSeach(),
                  ],
                  const CampaingList(),
                ]
              ],
              const SizedBox(
                height: 30,
              ),
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
