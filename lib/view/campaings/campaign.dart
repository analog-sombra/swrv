import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/components/header.dart';
import 'package:swrv/state/navstate.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/widgets/componets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class FindCampaings extends HookConsumerWidget {
  const FindCampaings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    ValueNotifier<String?> filtervalue = useState(null);
    ValueNotifier<List<String>> filterlist =
        useState(["filter 1", "filter 2", "flter 3"]);

    ValueNotifier<String?> categoryValue = useState(null);
    ValueNotifier<List<String>> categoryList = useState([
      "Sponsored Post",
      "Unboxing Review Posts",
      "Discount codes",
      "Giveaways & contest",
      "Campaign"
    ]);
    ValueNotifier<String?> countryValue = useState(null);
    ValueNotifier<List<String>> countryList =
        useState(["India", "Japan", "China", "Thailand", "Span", "German"]);

    ValueNotifier<bool> isShowActiveCompain = useState(false);
    ValueNotifier<bool> isBrand = useState(false);

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Header(),
          const Padding(
            padding: EdgeInsets.only(left: 25, top: 20),
            child: Text(
              "Find campaigs",
              textScaleFactor: 1,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w800, color: blackC),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 25, top: 10),
            child: Text(
              "Here you can manage all the campaigns that you\nare participating in.",
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
                          color:
                              isBrand.value ? blackC.withOpacity(0.65) : blackC,
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
                          color:
                              isBrand.value ? blackC : blackC.withOpacity(0.65),
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
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: backgroundC,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Save filter",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: blackC,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        hint: const Text(
                          "Saved filter",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 16,
                              color: blackC,
                              fontWeight: FontWeight.w500),
                        ),
                        buttonDecoration: BoxDecoration(
                          boxShadow: const [],
                          borderRadius: BorderRadius.circular(10),
                          color: backgroundC,
                        ),
                        itemPadding: const EdgeInsets.only(left: 5, right: 5),
                        buttonPadding: const EdgeInsets.only(left: 5, right: 5),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                        value: filtervalue.value,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        items: filterlist.value.map((String item) {
                          return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                textScaleFactor: 1,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ));
                        }).toList(),
                        onChanged: (newval) {
                          filtervalue.value = newval;
                        },
                        buttonElevation: 2,
                        itemHeight: 40,
                        dropdownMaxHeight: 200,
                        dropdownPadding: null,
                        isDense: false,
                        dropdownElevation: 8,
                        scrollbarRadius: const Radius.circular(40),
                        scrollbarThickness: 6,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(0, 0),
                        dropdownDecoration: BoxDecoration(
                          color: whiteC,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Select",
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
                            fontWeight: FontWeight.w500),
                      ),
                      buttonDecoration: BoxDecoration(
                        boxShadow: const [],
                        borderRadius: BorderRadius.circular(10),
                        color: backgroundC,
                      ),
                      itemPadding: const EdgeInsets.only(left: 20, right: 5),
                      buttonPadding: const EdgeInsets.only(left: 20, right: 5),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400),
                      value: categoryValue.value,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      items: categoryList.value.map((String item) {
                        return DropdownMenuItem(
                            value: item,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: blackC.withOpacity(0.25)))),
                              width: 220,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                item,
                                textScaleFactor: 1,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ));
                      }).toList(),
                      onChanged: (newval) {
                        categoryValue.value = newval;
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Channels",
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
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: whiteC,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 2),
                      ),
                      child: const SizedBox(
                        width: 35,
                        height: 35,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/images/facebook.png",
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: whiteC,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 2),
                      ),
                      child: const SizedBox(
                        width: 35,
                        height: 35,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/images/instagram.png",
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: whiteC,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 2),
                      ),
                      child: const SizedBox(
                        width: 35,
                        height: 35,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/images/snapchat.png",
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: whiteC,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 2),
                      ),
                      child: const SizedBox(
                        width: 35,
                        height: 35,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/images/twitter.png",
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: whiteC,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 2),
                      ),
                      child: const SizedBox(
                        width: 35,
                        height: 35,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/images/youtube.png",
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: whiteC,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 2),
                      ),
                      child: const SizedBox(
                        width: 35,
                        height: 35,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/images/linkedin.png",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Country",
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
                        "Country",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 16,
                            color: blackC,
                            fontWeight: FontWeight.w500),
                      ),
                      buttonDecoration: BoxDecoration(
                        boxShadow: const [],
                        borderRadius: BorderRadius.circular(10),
                        color: backgroundC,
                      ),
                      itemPadding: const EdgeInsets.only(left: 20, right: 5),
                      buttonPadding: const EdgeInsets.only(left: 20, right: 5),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400),
                      value: countryValue.value,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      items: countryList.value.map((String item) {
                        return DropdownMenuItem(
                            value: item,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: blackC.withOpacity(0.25)))),
                              width: 220,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                item,
                                textScaleFactor: 1,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ));
                      }).toList(),
                      onChanged: (newval) {
                        countryValue.value = newval;
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      FlutterSwitch(
                        width: 50,
                        height: 25.0,
                        valueFontSize: 25.0,
                        toggleSize: 20.0,
                        value: isShowActiveCompain.value,
                        borderRadius: 30.0,
                        padding: 3.0,
                        showOnOff: false,
                        activeColor: secondaryC,
                        inactiveColor: backgroundC,
                        onToggle: (val) {
                          isShowActiveCompain.value = val;
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Show only active campaigns",
                        textScaleFactor: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: secondaryC),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: secondaryC,
                      ),
                      label: const Text(
                        "Advance filter",
                        textScaleFactor: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: secondaryC,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.delete,
                      color: secondaryC,
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
                      onPressed: () {},
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
          ),
          const CampaingList(),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(
            height: 80,
          ),
        ],
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
                    amount: "3500",
                    currency: "USD",
                    platforms: const [
                      "assets/images/instagram.png",
                      "assets/images/facebook.png"
                    ]),
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
                    amount: "3500",
                    currency: "USD",
                    platforms: const [
                      "assets/images/instagram.png",
                      "assets/images/facebook.png"
                    ]),
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
                    amount: "3500",
                    currency: "USD",
                    platforms: const [
                      "assets/images/instagram.png",
                      "assets/images/facebook.png"
                    ]),
              ],
            ),
          )
        ],
      ),
    );
  }
}
