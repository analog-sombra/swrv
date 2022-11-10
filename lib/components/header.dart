
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/state/navstate.dart';
import 'package:swrv/utils/utilthemes.dart';

import '../state/userstate.dart';

class Header extends HookConsumerWidget {
  final bool isShowUser;
  const Header({Key? key, this.isShowUser = true}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStateW = ref.watch(userState);
    ValueNotifier<String> userName = useState("loading...");
    ValueNotifier<String> userAvatar = useState("");

    void init() async {
      userName.value = await userStateW.getUserName();
      userAvatar.value = await userStateW.getUserAvatar();

    }

    useEffect(() {
      init();
      return null;
    }, []);
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              ref.watch(pageIndex.state).state = 0;
            },
            child: SizedBox(
              width: 120,
              child: Image.asset("assets/images/logo.png"),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              ref.watch(pageIndex.state).state = 9;
            },
            child: const FaIcon(
              FontAwesomeIcons.solidBell,
              color: secondaryC,
            ),
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
                child: userAvatar.value == "" || userAvatar.value == "0"
                    ? Image.asset(
                        "assets/images/user.png",
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl:
                            userAvatar.value,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              userName.value.toString(),
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
