import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/components/header.dart';
import 'package:swrv/utils/utilthemes.dart';

import '../../utils/alerts.dart';

class EarningsPage extends HookConsumerWidget {
  const EarningsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Header(),
          const Padding(
            padding: EdgeInsets.only(left: 25, top: 20),
            child: Text(
              "My campaigns",
              textScaleFactor: 1,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w800, color: blackC),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 25, top: 10),
            child: Text(
              "Here you can manage all the\ncampaigns that you are particpating in.",
              textScaleFactor: 1,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w400, color: blackC),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              comingalert(context);
            },
            child: Container(
              width: 220,
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                color: whiteC,
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
                    height: 40,
                  ),
                  Icon(
                    CupertinoIcons.search,
                    color: blackC.withOpacity(0.65),
                    size: 50,
                  ),
                  const Text(
                    "To earn more money?",
                    textScaleFactor: 1,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: blackC),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Search, apply for public campaigns and create more great content",
                    textScaleFactor: 1,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: blackC.withOpacity(0.55)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 80,
          )
        ],
      ),
    );
  }
}
