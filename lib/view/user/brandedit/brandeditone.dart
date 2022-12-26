// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/state/userstate.dart';
import 'package:swrv/utils/utilthemes.dart';

import '../../../utils/alerts.dart';
import '../../../widgets/componets.dart';
import '../../navigation/bottomnavbar.dart';
import '../../navigation/drawer.dart';

class BrandEditOne extends HookConsumerWidget {
  const BrandEditOne({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());

    TextEditingController userName = useTextEditingController();
    TextEditingController knowAs = useTextEditingController();
    TextEditingController cname = useTextEditingController();
    TextEditingController website = useTextEditingController();
    TextEditingController brand = useTextEditingController();
    TextEditingController info = useTextEditingController();

    ValueNotifier<String> userAvatar = useState("");
    ValueNotifier<String> showuserName = useState("");
    ValueNotifier<String> shownickName = useState("");

    final userStateW = ref.watch(userState);
    void init() async {
      userAvatar.value = await userStateW.getUserAvatar();
      showuserName.value = await userStateW.getUserName();
      shownickName.value = await userStateW.getNickname();

      userName.text = await userStateW.getUserName();
      knowAs.text = await userStateW.getNickname();
    }

    useEffect(() {
      init();
      return;
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
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 10),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        fit: StackFit.loose,
                        children: [
                          Align(
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  imageUrl: userAvatar.value,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      Image.asset("assets/images/user.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: secondaryC,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: whiteC,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            showuserName.value,
                            textScaleFactor: 1,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            shownickName.value,
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.75)),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        "Company name",
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TextField(
                          controller: cname,
                          readOnly: true,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xfff3f4f6),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        "Website",
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TextField(
                          controller: website,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xfff3f4f6),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        "Brand",
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TextField(
                          controller: brand,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xfff3f4f6),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        "Company info",
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TextField(
                          controller: info,
                          minLines: 4,
                          maxLines: 6,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xfff3f4f6),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 0,
                                    backgroundColor: backgroundC,
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    "Back",
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 0,
                                      backgroundColor: secondaryC),
                                  onPressed: () {
                                    comingalert(context);
                                  },
                                  child: const Text(
                                    "Save",
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        color: whiteC,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ]),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
  }
}
