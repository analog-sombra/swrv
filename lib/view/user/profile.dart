// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swrv/state/navstate.dart';
import 'package:swrv/view/login.dart';

import '../../state/userstate.dart';
import '../../utils/alerts.dart';
import '../../widgets/componets.dart';

class Profile extends HookConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<SharedPreferences?> prefs = useState(null);
    final userStateW = ref.watch(userState);
    ValueNotifier<String> userName = useState("loading...");
    ValueNotifier<String> nickname = useState("loading...");
    ValueNotifier<String> userAvatar = useState("");

    void init() async {
      prefs.value = await SharedPreferences.getInstance();
      userName.value = await userStateW.getUserName();
      userAvatar.value = await userStateW.getUserAvatar();
      nickname.value = await userStateW.getNickname();
    }

    useEffect(() {
      init();
      return;
    }, []);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Header(
            isShowUser: false,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            margin:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        width: 100,
                        height: 100,
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
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 130,
                            child: Text(
                              userName.value,
                              overflow: TextOverflow.ellipsis,
                              textScaleFactor: 1,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            nickname.value,
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.75)),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        ref.watch(pageIndex.state).state = 31;
                      },
                      child: Icon(
                        Icons.edit_outlined,
                        color: Colors.black.withOpacity(0.85),
                        size: 30,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Dashboard",
                  textScaleFactor: 1,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.75)),
                ),
                GestureDetector(
                  onTap: () {
                    ref.watch(pageIndex.state).state = 26;
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff5eead4),
                          ),
                          width: 60,
                          height: 60,
                          child: const Icon(
                            Icons.people_alt_outlined,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                "Campaigns",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black.withOpacity(0.65),
                          size: 25,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    comingalert(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xfffdba74)),
                          width: 60,
                          height: 60,
                          child: const Icon(
                            Icons.wallet_giftcard_outlined,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                "Payment",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black.withOpacity(0.65),
                          size: 25,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ref.watch(pageIndex.state).state = 12;
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xff60a5fa)),
                          width: 60,
                          height: 60,
                          child: const Icon(
                            Icons.laptop_chromebook_outlined,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                "Privacy",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black.withOpacity(0.65),
                          size: 25,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    comingalert(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "My account",
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.75)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    bool? success = await prefs.value?.remove('isLogin');
                    bool? userDel = await prefs.value?.remove('isLogin');
                    if (success! && userDel!) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    }
                  },
                  child: GestureDetector(
                    onTap: () {
                      comingalert(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "Switch to Other Account",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue.withOpacity(0.75)),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    FirebaseAuth.instance.currentUser;

                    bool? success = await prefs.value?.remove('isLogin');
                    if (success!) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "Log Out",
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.red.withOpacity(0.75)),
                    ),
                  ),
                ),
              ],
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
