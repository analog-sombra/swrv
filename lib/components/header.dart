import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/utils/utilthemes.dart';

class Header extends HookConsumerWidget {
  final String name;
  final String? imgUrl;
  final bool isShowUser;
  const Header(
      {Key? key,
      required this.name,
      this.imgUrl,
      this.isShowUser = true})
      : super(key: key);
      
        get secondaryC => null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Image.asset("assets/images/logo.png"),
          ),
          const Spacer(),
          FaIcon(
            FontAwesomeIcons.solidBell,
            color: secondaryC,
          ),
          if (isShowUser) ...[
            const SizedBox(
              width: 10,
            ),
          

            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: SizedBox(
                width: 35,
                height: 35,
                child: imgUrl == null? Image.asset(
                  "assets/images/user.png",
                  fit: BoxFit.cover,
                ):Image.asset(imgUrl!),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              name,
              textScaleFactor: 1,
              style: const TextStyle(
                  fontSize: 14, color: blackC, fontWeight: FontWeight.w500),
            )
          ],
        ],
      ),
    );
  }
}
