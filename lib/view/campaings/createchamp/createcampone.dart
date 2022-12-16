import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/widgets/buttons.dart';

import '../../../state/compaign/createcampaignstate.dart';
import '../../../utils/utilthemes.dart';
import '../../../widgets/alerts.dart';
import '../../../widgets/componets.dart';
import '../../navigation/bottomnavbar.dart';
import '../../navigation/drawer.dart';

class CreateCampOne extends HookConsumerWidget {
  const CreateCampOne({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());
    final GlobalKey<FormState> formKey =
        useMemoized(() => GlobalKey<FormState>());
    final width = MediaQuery.of(context).size.width;

    TextEditingController dos = useTextEditingController();
    TextEditingController dont = useTextEditingController();
    TextEditingController mention = useTextEditingController();
    TextEditingController hashtag = useTextEditingController();
    TextEditingController info = useTextEditingController();
    TextEditingController affiliatedLinks = useTextEditingController();
    TextEditingController discountCoupons = useTextEditingController();

    final createCmpSW = ref.watch(createCampState);
    void init() async {
      info.text = createCmpSW.campInfo ?? "";
      affiliatedLinks.text = createCmpSW.affiliatedLinks ?? "";
      discountCoupons.text = createCmpSW.discountCoupons ?? "";
      await createCmpSW.setPlatforms();
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Header(),
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
                  "Here you can create campaign that you are like.",
                  textScaleFactor: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400, color: blackC),
                ),
              ),
              Container(
                width: width,
                margin: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: whiteC,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                        color: shadowC, blurRadius: 5, offset: Offset(0, 6))
                  ],
                ),
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      cusTitle("Sponsored post"),
                      if (createCmpSW.platforms.isEmpty ||
                          createCmpSW.selectedPlatfomrs.isEmpty) ...[
                        const CircularProgressIndicator()
                      ] else ...[
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (int i = 0;
                                  i < createCmpSW.platforms.length;
                                  i++) ...[
                                GestureDetector(
                                  onTap: () {
                                    createCmpSW.togglePlatfroms(i);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: whiteC,
                                      shape: BoxShape.circle,
                                      border: createCmpSW.selectedPlatfomrs[i]
                                          ? Border.all(
                                              color: Colors.blue, width: 2)
                                          : Border.all(
                                              color: Colors.transparent,
                                              width: 2),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: SizedBox(
                                        width: 35,
                                        height: 35,
                                        child: CachedNetworkImage(
                                          imageUrl: createCmpSW.platforms[i]
                                              ["platformLogoUrl"],
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 0;
                                i < createCmpSW.mediaType.length;
                                i++) ...[
                              InkWell(
                                onTap: () {
                                  createCmpSW.setMediaType(i);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: (createCmpSW.selectedMediaType == i)
                                        ? secondaryC
                                        : backgroundC,
                                  ),
                                  child: Text(
                                    createCmpSW.mediaType[i],
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          (createCmpSW.selectedMediaType == i)
                                              ? whiteC
                                              : blackC,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (createCmpSW.campType ==
                          CampaingType.unboxingOrReviewPosts) ...[
                        cusTitle("Campaign Eligible Rating"),
                        RatingBar.builder(
                          initialRating: createCmpSW.rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: primaryC,
                          ),
                          onRatingUpdate: (rating) {
                            createCmpSW.setRating(rating);
                          },
                        ),
                      ],
                      if (createCmpSW.campType ==
                          CampaingType.discountCodes) ...[
                        cusTitle("Affiliated links"),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null ||
                                    value == "" ||
                                    value.isEmpty) {
                                  return "This field can't be empty";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                createCmpSW.setAffiliatedLinks(value);
                              },
                              controller: affiliatedLinks,
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
                        cusTitle("Discount coupons"),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null ||
                                    value == "" ||
                                    value.isEmpty) {
                                  return "This field can't be empty";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                createCmpSW.setDiscountCoupons(value);
                              },
                              controller: discountCoupons,
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
                      ],
                      cusTitle("Mentions"),
                      InkWell(
                        onTap: () {
                          addMentionsAlert(context, mention, ref);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: backgroundC,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(children: [
                                    for (int i = 0;
                                        i < createCmpSW.mention.length;
                                        i++) ...[
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: whiteC,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              "@${createCmpSW.mention[i]}",
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
                                            InkWell(
                                              onTap: () {
                                                createCmpSW.removeMention(
                                                  createCmpSW.mention[i],
                                                );
                                              },
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ]),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {
                                    addMentionsAlert(context, mention, ref);
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: blackC,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      cusTitle("HashTag"),
                      InkWell(
                        onTap: () {
                          addHashTagAlert(context, hashtag, ref);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: backgroundC,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(children: [
                                    for (int i = 0;
                                        i < createCmpSW.hashtag.length;
                                        i++) ...[
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: whiteC,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              "#${createCmpSW.hashtag[i]}",
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
                                            InkWell(
                                              onTap: () {
                                                createCmpSW.removeHashTag(
                                                  createCmpSW.hashtag[i],
                                                );
                                              },
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ]),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {
                                    addHashTagAlert(context, hashtag, ref);
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: blackC,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      cusTitle("Campaign info"),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value == "" ||
                                  value.isEmpty) {
                                return "Enter some info about campaign";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              createCmpSW.setCampInfo(value);
                            },
                            minLines: 4,
                            maxLines: 7,
                            controller: info,
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
                      cusTitle("Attachments"),
                      InkWell(
                        onTap: () {
                          createCmpSW.addAttachment(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: backgroundC,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.attachment,
                                color: blackC,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                (createCmpSW.attachments == null)
                                    ? "Attachments"
                                    : createCmpSW.attachments!.path
                                        .split("/")
                                        .last,
                                textScaleFactor: 1,
                                style: const TextStyle(
                                    color: blackC,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {
                                    createCmpSW.addAttachment(context);
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: blackC,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      cusTitle("You should"),
                      InkWell(
                        onTap: () {
                          addDosAlert(context, dos, ref);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: backgroundC,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(Icons.done, color: Colors.green),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text(
                                "Do",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    color: blackC,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {
                                    addDosAlert(context, dos, ref);
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: blackC,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        alignment: WrapAlignment.start,
                        runAlignment: WrapAlignment.start,
                        children: [
                          for (int i = 0; i < createCmpSW.dos.length; i++) ...[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: blackC.withOpacity(0.15),
                                          blurRadius: 10),
                                    ],
                                    color: whiteC,
                                    borderRadius: BorderRadius.circular(5),
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
                                      InkWell(
                                        onTap: () {
                                          createCmpSW.removeDos(
                                            createCmpSW.dos[i],
                                          );
                                        },
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ]
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          addDontAlert(context, dont, ref);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: backgroundC,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(Icons.close, color: Colors.red),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text(
                                "Don't",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    color: blackC,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {
                                    addDontAlert(context, dont, ref);
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: blackC,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        runSpacing: 8,
                        spacing: 10,
                        alignment: WrapAlignment.start,
                        runAlignment: WrapAlignment.start,
                        children: [
                          for (int i = 0; i < createCmpSW.dont.length; i++) ...[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: blackC.withOpacity(0.15),
                                          blurRadius: 10),
                                    ],
                                    color: whiteC,
                                    borderRadius: BorderRadius.circular(5),
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
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          createCmpSW.removedont(
                                            createCmpSW.dont[i],
                                          );
                                        },
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ]
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Center(
                        child: Text(
                          "Does the influencer need to seek an approval of the post before posting",
                          textScaleFactor: 1,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: secondaryC,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                createCmpSW.setApproval(Approval.yes);
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: (createCmpSW.approval == Approval.yes)
                                      ? secondaryC
                                      : backgroundC,
                                ),
                                child: Center(
                                  child: Text(
                                    "Yes",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          (createCmpSW.approval == Approval.yes)
                                              ? whiteC
                                              : blackC,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                createCmpSW.setApproval(Approval.no);
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: (createCmpSW.approval == Approval.no)
                                      ? secondaryC
                                      : backgroundC,
                                ),
                                child: Center(
                                  child: Text(
                                    "No",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          (createCmpSW.approval == Approval.no)
                                              ? whiteC
                                              : blackC,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CusBtn(
                              btnColor: backgroundC,
                              btnText: "Back",
                              textSize: 18,
                              btnFunction: () {
                                Navigator.pop(context);
                              },
                              textColor: blackC,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: CusBtn(
                              btnColor: secondaryC,
                              btnText: "Next",
                              textSize: 18,
                              btnFunction: () {
                                if (formKey.currentState!.validate()) {}
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cusTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 15),
      child: Text(
        title,
        textScaleFactor: 1,
        textAlign: TextAlign.left,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: secondaryC),
      ),
    );
  }
}
