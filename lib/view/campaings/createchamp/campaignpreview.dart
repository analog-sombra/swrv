// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/utils/alerts.dart';
import 'package:swrv/utils/utilthemes.dart';

import '../../../state/compaign/createcampaignstate.dart';
import '../../../state/userstate.dart';
import '../../../widgets/componets.dart';
import '../../home/home.dart';
import '../../navigation/bottomnavbar.dart';
import '../../navigation/drawer.dart';

class CampaignsPreview extends HookConsumerWidget {
  const CampaignsPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());
    final width = MediaQuery.of(context).size.width;

    ValueNotifier<String> userAvatar = useState("");
    ValueNotifier<String> brandInfo = useState("");
    ValueNotifier<String> website = useState("");
    final userStateW = ref.watch(userState);
    final createCmpSW = ref.watch(createCampState);
    ValueNotifier<bool> isLoading = useState(true);

    void init() async {
      brandInfo.value = await userStateW.getBrandInfo();
      userAvatar.value = await userStateW.getUserAvatar();
      website.value = await userStateW.getWebsite();
      isLoading.value = false;
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
      body: isLoading.value
          ? const Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: CircularProgressIndicator()),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Header(),
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
                              offset: Offset(0, 6))
                        ],
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: userAvatar.value == "" ||
                                          userAvatar.value == "0"
                                      ? Image.asset(
                                          "assets/images/user.png",
                                          fit: BoxFit.cover,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: userAvatar.value,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      createCmpSW.data[0],
                                      textAlign: TextAlign.left,
                                      textScaleFactor: 1,
                                      style: const TextStyle(
                                          color: blackC,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Category: ${createCmpSW.categoryValue}",
                                      textAlign: TextAlign.left,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          color: blackC.withOpacity(0.65),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      website.value,
                                      textAlign: TextAlign.left,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          color: blackC.withOpacity(0.55),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Center(
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Mentions",
                                        textScaleFactor: 1,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: blackC),
                                      ),
                                      for (int i = 0;
                                          i < createCmpSW.mention.length;
                                          i++) ...[
                                        Container(
                                          width: 120,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            color: backgroundC,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            "@${createCmpSW.mention[i]}",
                                            textScaleFactor: 1,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: secondaryC),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Hashtags",
                                        textScaleFactor: 1,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: blackC),
                                      ),
                                      for (int i = 0;
                                          i < createCmpSW.hashtag.length;
                                          i++) ...[
                                        Container(
                                          width: 120,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            color: backgroundC,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            "#${createCmpSW.hashtag[i]}",
                                            textScaleFactor: 1,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: secondaryC),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Brand info",
                              textScaleFactor: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: secondaryC),
                            ),
                          ),
                          Text(
                            brandInfo.value,
                            textScaleFactor: 1,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: blackC),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Champign info",
                              textScaleFactor: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: secondaryC),
                            ),
                          ),
                          Text(
                            createCmpSW.data[1],
                            textScaleFactor: 1,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: blackC),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Mooodboard",
                              textScaleFactor: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: secondaryC),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                for (int i = 0;
                                    i < createCmpSW.images.length;
                                    i++) ...[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: Image.file(
                                          createCmpSW.images[i],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Attachment",
                              textScaleFactor: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: secondaryC),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: backgroundC,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: const Icon(
                                    Icons.attachment,
                                    color: blackC,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  "Attachment",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      color: blackC,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Platforms",
                              textScaleFactor: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: secondaryC),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                for (int i = 0;
                                    i <
                                        createCmpSW
                                            .selectedPlatfomrsList.length;
                                    i++) ...[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: CachedNetworkImage(
                                          imageUrl: createCmpSW.platforms[
                                              int.parse(createCmpSW
                                                      .selectedPlatfomrsList[
                                                  i])]["platformLogoUrl"],
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                                color: backgroundC,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: const [
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.done, color: Colors.green),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Do",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      color: blackC,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              for (int i = 0;
                                  i < createCmpSW.dos.length;
                                  i++) ...[
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(Icons.done,
                                          color: Colors.green),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: blackC.withOpacity(0.15),
                                                blurRadius: 10),
                                          ],
                                          color: whiteC,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              createCmpSW.dos[i],
                                              textScaleFactor: 1,
                                              style: const TextStyle(
                                                color: blackC,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ]
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: backgroundC,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: const [
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.close, color: Colors.red),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Don't",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      color: blackC,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              for (int i = 0;
                                  i < createCmpSW.dont.length;
                                  i++) ...[
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(Icons.done,
                                          color: Colors.green),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: blackC.withOpacity(0.15),
                                                blurRadius: 10),
                                          ],
                                          color: whiteC,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              createCmpSW.dont[i],
                                              textScaleFactor: 1,
                                              style: const TextStyle(
                                                color: blackC,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ]
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: width,
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: whiteC,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                              color: shadowC,
                              blurRadius: 5,
                              offset: Offset(0, 6))
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Campaign Preview",
                            textScaleFactor: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: secondaryC),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Congratulations",
                              textScaleFactor: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: blackC),
                            ),
                          ),
                          const Text(
                            "The Jaquar Group, established in 1960, is a growing multi-diversified bathroom and lighting solutions company with 17% CAGR over 10 years in a row, offers faucets, showers, shower enclosures, sanitary ware, flushing systems, wellness products, concealed cisterns, water heaters, and varied lighting products.",
                            textScaleFactor: 1,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: blackC),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 0,
                                      backgroundColor: backgroundC,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "back",
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          color: blackC,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 120,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor: primaryC,
                                    ),
                                    onPressed: () async {
                                      isLoading.value = true;
                                      final res = await createCmpSW.createCamp(
                                          context, createCmpSW.data);
                                      if (res[0] == false) {
                                        erroralert(context, "Error",
                                            "Unable to create, Try again");
                                      } else {
                                        createCmpSW.setChampId(
                                            res[0]["campaign"]["id"]);
                                        await createCmpSW.addMoodBorad(context);
                                        await createCmpSW
                                            .addAttachmentUrl(context);

                                        susalert(context, "Created",
                                            "Successfully Created new Campaign ");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage(),
                                          ),
                                        );
                                      }
                                      isLoading.value = false;
                                    },
                                    child: const Text(
                                      "Create",
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                        color: whiteC,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
