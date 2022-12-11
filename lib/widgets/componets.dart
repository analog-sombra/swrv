import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/widgets/buttons.dart';

import '../state/userstate.dart';
import '../view/home/home.dart';
import '../view/notifications/notifications.dart';

class HomeCard extends HookConsumerWidget {
  final String title;
  final String imgUrl;
  final Color btnColor;
  final String btnText;
  final Function btnFunction;
  final String website;
  final String category;
  final bool isHeart;
  final bool isSocial;
  final String currency;
  final String amount;
  final List platforms;
  final bool networkImg;
  const HomeCard({
    super.key,
    required this.title,
    required this.imgUrl,
    required this.btnColor,
    required this.btnText,
    required this.btnFunction,
    required this.website,
    required this.category,
    required this.currency,
    required this.amount,
    required this.platforms,
    this.isHeart = true,
    this.isSocial = true,
    this.networkImg = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: blackC.withOpacity(0.1), blurRadius: 6),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: networkImg
                        ? CachedNetworkImage(
                            imageUrl: imgUrl,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/images/user.png",
                              fit: BoxFit.cover,
                            ),
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            imgUrl,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    textScaleFactor: 1,
                    style: const TextStyle(
                        color: blackC,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                if (isHeart) ...[
                  const SizedBox(
                    height: 60,
                    child: FaIcon(CupertinoIcons.heart_fill, color: Colors.red),
                  )
                ],
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            category,
            textAlign: TextAlign.left,
            textScaleFactor: 1,
            style: const TextStyle(fontSize: 14, color: blackC),
          ),
          Text(
            website,
            textAlign: TextAlign.left,
            textScaleFactor: 1,
            style: const TextStyle(fontSize: 14, color: blackC),
          ),
          const SizedBox(
            height: 10,
          ),
          if (isSocial) ...[
            const Divider(
              thickness: 2,
            ),
            Row(
              children: [
                Text(
                  "Platforms",
                  textScaleFactor: 1,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: blackC.withOpacity(0.65),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                Text(
                  "Amount",
                  textScaleFactor: 1,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: blackC.withOpacity(0.65),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < platforms.length; i++) ...[
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: whiteC,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blue, width: 2),
                          ),
                          child: SizedBox(
                            width: 35,
                            height: 35,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                imageUrl: platforms[i],
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    Image.asset("assets/images/instagram.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                )),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      amount,
                      textAlign: TextAlign.end,
                      textScaleFactor: 1,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "$currency/post",
                      textAlign: TextAlign.end,
                      textScaleFactor: 1,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    )
                  ],
                )
              ],
            ),
          ],
          const SizedBox(
            height: 20,
          ),
          CusBtn(
            btnColor: btnColor,
            btnText: btnText,
            textSize: 18,
            btnFunction: btnFunction,
            textColor: blackC,
          )
        ],
      ),
    );
  }
}

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
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: ((context) => const HomePage()),
                ),
                (Route<dynamic> route) => false,
              );
            },
            child: SizedBox(
              width: 120,
              child: Image.asset(
                "assets/images/logo.png",
              ),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              notificationsAlert(context);
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
                        imageUrl: userAvatar.value,
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
              userName.value.toString().split("@")[0],
              textScaleFactor: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 14, color: blackC, fontWeight: FontWeight.w500),
            )
          ],
        ],
      ),
    );
  }
}
