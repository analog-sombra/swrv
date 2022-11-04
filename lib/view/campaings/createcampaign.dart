import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/components/header.dart';
import 'package:swrv/state/compaign/createcampaignstate.dart';
import 'package:swrv/state/navstate.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/widgets/componets.dart';
import 'package:swrv/widgets/cuswidgets.dart';

class CreateCampaings extends HookConsumerWidget {
  const CreateCampaings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    final createCmpSR = ref.read(createCampState);
    final createCmpSW = ref.watch(createCampState);

    ValueNotifier<bool> isBrand = useState(false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Header(
              name: "analog-sombra",
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25, top: 20),
              child: Text(
                "Create campaign",
                textScaleFactor: 1,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w600, color: blackC),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25, top: 10),
              child: Text(
                "Here you can create campaigns that you are like.",
                textScaleFactor: 1,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w400, color: blackC),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                        backgroundColor:
                            isBrand.value ? whiteC : const Color(0xff01fff4),
                      ),
                      onPressed: () {
                        isBrand.value = false;
                      },
                      child: Text(
                        "Campaign",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1,
                        style: TextStyle(
                            color: isBrand.value
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
                        backgroundColor:
                            isBrand.value ? const Color(0xff01fff4) : whiteC,
                      ),
                      onPressed: () {
                        isBrand.value = true;
                      },
                      child: Text(
                        "Brand",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1,
                        style: TextStyle(
                            color: isBrand.value
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
            Container(
              width: width,
              margin: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: whiteC,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: shadowC, blurRadius: 5, offset: Offset(0, 6))
                ],
              ),
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Campaign name",
                      textScaleFactor: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: secondaryC),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextField(
                        controller: createCmpSW.name,
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
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Campaign info",
                      textScaleFactor: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: secondaryC),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextField(
                        minLines: 4,
                        maxLines: 7,
                        controller: createCmpSW.info,
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
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Select Category",
                      textScaleFactor: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: secondaryC),
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        hint: const Text(
                          "Category",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 16,
                              color: blackC,
                              fontWeight: FontWeight.w400),
                        ),
                        buttonDecoration: BoxDecoration(
                          boxShadow: const [],
                          borderRadius: BorderRadius.circular(10),
                          color: backgroundC,
                        ),
                        itemPadding: const EdgeInsets.only(left: 20, right: 5),
                        buttonPadding:
                            const EdgeInsets.only(left: 20, right: 5),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                        value: createCmpSW.categoryValue,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        items: [
                          for (int i = 0;
                              i < createCmpSW.categoryList.length;
                              i++) ...[
                            DropdownMenuItem(
                              value: createCmpSW.categoryList[i],
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: blackC.withOpacity(0.25),
                                    ),
                                  ),
                                ),
                                width: 220,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  createCmpSW.categoryList[i],
                                  textScaleFactor: 1,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ),
                          ]
                        ],
                        onChanged: (newval) {
                          createCmpSR.setCatValue(newval!);
                        },
                        buttonElevation: 2,
                        itemHeight: 40,
                        dropdownMaxHeight: 250,
                        dropdownPadding: null,
                        isDense: false,
                        dropdownElevation: 8,
                        scrollbarRadius: const Radius.circular(40),
                        scrollbarThickness: 6,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(0, 0),
                        dropdownDecoration: BoxDecoration(
                            color: const Color(0xfffbfbfb),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const []),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0;
                          i < createCmpSW.platforms.length;
                          i++) ...[
                        GestureDetector(
                          onTap: () {
                            createCmpSR.togglePlatfroms(i);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 5),
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: whiteC,
                              shape: BoxShape.circle,
                              border: createCmpSW.selectedPlatfomrs[i]
                                  ? Border.all(color: Colors.blue, width: 2)
                                  : Border.all(
                                      color: Colors.transparent, width: 2),
                            ),
                            child: SizedBox(
                              width: 35,
                              height: 35,
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                  createCmpSR.platforms[i],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Currency",
                      textScaleFactor: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: secondaryC),
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        hint: const Text(
                          "Currency",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 16,
                              color: blackC,
                              fontWeight: FontWeight.w400),
                        ),
                        buttonDecoration: BoxDecoration(
                          boxShadow: const [],
                          borderRadius: BorderRadius.circular(10),
                          color: backgroundC,
                        ),
                        itemPadding: const EdgeInsets.only(left: 20, right: 5),
                        buttonPadding:
                            const EdgeInsets.only(left: 20, right: 5),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                        value: createCmpSR.currencyValue,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        items: [
                          for (int i = 0;
                              i < createCmpSR.currencyList.length;
                              i++) ...[
                            DropdownMenuItem(
                              value: createCmpSR.currencyList[i],
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: blackC.withOpacity(0.25),
                                    ),
                                  ),
                                ),
                                width: 220,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  createCmpSR.currencyList[i],
                                  textScaleFactor: 1,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ),
                          ]
                        ],
                        onChanged: (newval) {
                          createCmpSW.setCountryValue(newval!);
                        },
                        buttonElevation: 2,
                        itemHeight: 40,
                        dropdownMaxHeight: 250,
                        dropdownPadding: null,
                        isDense: false,
                        dropdownElevation: 8,
                        scrollbarRadius: const Radius.circular(40),
                        scrollbarThickness: 6,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(0, 0),
                        dropdownDecoration: BoxDecoration(
                            color: const Color(0xfffbfbfb),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const []),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CusBtn(
                      btnColor: primaryC,
                      btnText: "Create",
                      textSize: 18,
                      btnFunction: () async {
                        final res = await createCmpSR.createCamp(context);
                        if(res){
                          ref.watch(pageIndex.state).state = 0;
                        }
                      }),
                ],
              ),
            ),
            // const CampaingList(),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}

class CampaingList extends HookConsumerWidget {
  const CampaingList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    return Container(
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
                const Text(
                  "Found: 03 Campaigns",
                  textAlign: TextAlign.left,
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: blackC, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: backgroundC,
                      elevation: 0,
                    ),
                    icon: const Icon(
                      Icons.sort,
                      color: blackC,
                    ),
                    label: Text(
                      "Reach",
                      textAlign: TextAlign.left,
                      textScaleFactor: 1,
                      style: TextStyle(
                          color: blackC.withOpacity(0.55),
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
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
                HomeCard(
                  imgUrl: "assets/images/post1.jpg",
                  title: "Adidas Cases",
                  btnColor: const Color(0xfffbc98e),
                  btnText: "Learn more & apply",
                  btnFunction: () {
                    ref.read(pageIndex.state).state = 21;
                  },
                  website: "www.adidas.co.in",
                  category: "Category: Consumer Electronics",
                  isHeart: false,
                ),
                HomeCard(
                  imgUrl: "assets/images/post1.jpg",
                  title: "Adidas Cases",
                  btnColor: const Color(0xfffbc98e),
                  btnText: "Learn more & apply",
                  btnFunction: () {
                    ref.read(pageIndex.state).state = 21;
                  },
                  website: "www.adidas.co.in",
                  category: "Category: Consumer Electronics",
                  isHeart: false,
                ),
                HomeCard(
                  imgUrl: "assets/images/post1.jpg",
                  title: "Adidas Cases",
                  btnColor: const Color(0xfffbc98e),
                  btnText: "Learn more & apply",
                  btnFunction: () {
                    ref.read(pageIndex.state).state = 21;
                  },
                  website: "www.adidas.co.in",
                  category: "Category: Consumer Electronics",
                  isHeart: false,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
