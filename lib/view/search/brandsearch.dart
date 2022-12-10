import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/brand/findbrandstate.dart';
import '../../utils/utilthemes.dart';
import '../../widgets/componets.dart';
import '../brand/brandinfo.dart';



class TextBrandSearch extends HookConsumerWidget {
  const TextBrandSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    TextEditingController textSearch = useTextEditingController();
    final findBrandStateW = ref.watch(findBrandState);

    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: whiteC,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: shadowC, blurRadius: 5, offset: Offset(0, 6))
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: textSearch,
                decoration: const InputDecoration(
                  isDense: true,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
            height: 10,
          ),
          Row(
            children: [
              const Spacer(),
              InkWell(
                onTap: () {
                  findBrandStateW.clear();
                },
                child: const Icon(
                  Icons.delete,
                  color: secondaryC,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryC,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  final data = await findBrandStateW.textSearch(
                      context, textSearch.text);
                  if (data[0] != false) {
                    findBrandStateW.setIsSearch(true);
                    findBrandStateW.setSearchData(jsonDecode(data[0]));
                  }
                },
                child: const Text(
                  "Search",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: whiteC,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BrandList extends HookConsumerWidget {
  const BrandList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final findBrandStateW = ref.watch(findBrandState);

    return findBrandStateW.isSearch
        ? Container(
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        "Found: ${findBrandStateW.searchData.length} Campaigns",
                        textAlign: TextAlign.left,
                        textScaleFactor: 1,
                        style: const TextStyle(
                            color: blackC,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
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
                      if (findBrandStateW.searchData.isEmpty) ...[
                        Text(
                          "Reach",
                          textAlign: TextAlign.left,
                          textScaleFactor: 1,
                          style: TextStyle(
                              color: blackC.withOpacity(0.85),
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                      for (int i = 0;
                          i < findBrandStateW.searchData.length;
                          i++) ...[
                        HomeCard(
                          imgUrl: findBrandStateW.searchData[i]["logo"],
                          title: findBrandStateW.searchData[i]["name"],
                          btnColor: const Color(0xff80fff9),
                          btnText: "View",
                          btnFunction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BrandInfo(
                                  id: findBrandStateW.searchData[i]["id"]
                                      .toString(),
                                ),
                              ),
                            );
                          },
                          website: findBrandStateW.searchData[i]["email"],
                          category:
                              "Brand Code : ${findBrandStateW.searchData[i]["code"]}",
                          isSocial: false,
                          amount: "3500",
                          currency: "USD",
                          platforms: const [],
                          isHeart: false,
                        ),
                      ],
                    ],
                  ),
                )
              ],
            ),
          )
        : Container();
  }
}
