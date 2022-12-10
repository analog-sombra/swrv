// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:swrv/database/models/favoritebrand.dart';
import 'package:swrv/services/apirequest.dart';
import 'package:swrv/utils/alerts.dart';
import 'package:swrv/utils/utilthemes.dart';

import '../../database/database.dart';
import '../../widgets/componets.dart';
import '../navigation/bottomnavbar.dart';
import '../navigation/drawer.dart';

class BrandInfo extends HookConsumerWidget {
  final String id;
  const BrandInfo({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());
    final width = MediaQuery.of(context).size.width;

    CusApiReq apiReq = CusApiReq();
    final branddata = useState([]);
    ValueNotifier<bool> isLoading = useState(true);

    ValueNotifier<List> favList = useState([]);

    ValueNotifier<bool> isFav = useState(false);

    void init() async {
      final getfav =
          await isarDB.favoriteBrands.filter().brandidEqualTo(id).findAll();
      favList.value = getfav;

      if (favList.value.isEmpty) {
        isFav.value = false;
      } else {
        isFav.value = true;
      }

      final req = {
        "id": id,
      };
      List data = await apiReq.postApi(jsonEncode(req), path: "/api/get-brand");
      if (data[0]["status"] == true) {
        branddata.value = [data[0]["data"]];
      } else {
        erroralert(context, "Error", "No Data found");
      }

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
      body: SafeArea(
        child: isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Header(),
                    Container(
                      width: width,
                      margin: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: whiteC,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: shadowC,
                            blurRadius: 5,
                            offset: Offset(0, 6),
                          )
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
                                borderRadius: BorderRadius.circular(6),
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: CachedNetworkImage(
                                    imageUrl: branddata.value[0]["logo"],
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      "assets/images/user.png",
                                      fit: BoxFit.cover,
                                    ),
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
                                      branddata.value[0]["name"],
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
                                      branddata.value[0]["email"],
                                      textAlign: TextAlign.left,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          color: blackC.withOpacity(0.65),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "Brand Code : ${branddata.value[0]["code"]}",
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
                              InkWell(
                                onTap: () async {
                                  isFav.value = !isFav.value;
                                  if (favList.value.isEmpty) {
                                    final newFav = FavoriteBrand()
                                      ..brandid = id
                                      ..name = branddata.value[0]["name"]
                                      ..img = branddata.value[0]["logo"];
                                    await isarDB.writeTxn(() async {
                                      await isarDB.favoriteBrands.put(newFav);
                                    });
                                  } else {
                                    await isarDB.writeTxn(() async {
                                      await isarDB.favoriteBrands
                                          .delete(favList.value[0].id);
                                    });
                                  }
                                },
                                child: Icon(
                                  Icons.favorite,
                                  size: 30,
                                  color: isFav.value ? Colors.red : Colors.grey,
                                ),
                              )
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
                            branddata.value[0]["info"],
                            textScaleFactor: 1,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: blackC),
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
