import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/utils/utilthemes.dart';

import '../../utils/alerts.dart';
import '../../widgets/componets.dart';
import '../navigation/bottomnavbar.dart';
import '../navigation/drawer.dart';

class DraftsPage extends HookConsumerWidget {
  const DraftsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());
    final width = MediaQuery.of(context).size.width;

    ValueNotifier<List> darfData = useState([
      {
        "img": "assets/images/1.jpg",
        "name": "sohan",
        "msg":
            "There’s just one more thing you need to do to get started with us."
      },
      {
        "img": "assets/images/2.jpg",
        "name": "Rahul",
        "msg":
            "Thank you for scheduling an appointment with our office. You are confirmed for an appointment with"
      },
      {
        "img": "assets/images/3.jpg",
        "name": "Mohan",
        "msg":
            "Thank you for providing the information we requested. We will follow up with you shortly regarding the next steps."
      },
      {
        "img": "assets/images/4.jpg",
        "name": "Soniya",
        "msg":
            "We’re super excited to announce that we’re opening our doors on DATE at TIME. Come join us!"
      },
      {
        "img": "assets/images/5.jpg",
        "name": "Sonali",
        "msg":
            "Thank you for your business! We pride ourselves on great service and it’s your feedback that makes that possible!"
      },
      {
        "img": "assets/images/6.jpg",
        "name": "Sakhi",
        "msg":
            "We just wanted to remind you that we’re waiting for the DOCUMENT you agreed to send us so we can complete the TRANSACTION we discussed."
      },
      {
        "img": "assets/images/7.jpg",
        "name": "Ansh ikha",
        "msg": "We look forward to seeing you for your appointment today."
      },
    ]);

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
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Header(),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: width,
                margin: const EdgeInsets.all(15),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: BoxDecoration(
                  color: whiteC,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                        color: shadowC, blurRadius: 5, offset: Offset(0, 6))
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextField(
                        onTap: () {
                          comingalert(context);
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: const Icon(Icons.sort),
                          filled: true,
                          fillColor: backgroundC,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: "Search",
                          hintStyle: TextStyle(
                            fontSize: 20,
                            color: blackC.withOpacity(0.4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    for (int i = 0; i < darfData.value.length; i++) ...[
                      GestureDetector(
                        onTap: () {
                          comingalert(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: blackC.withOpacity(0.25))),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Image.asset(
                                    darfData.value[i]["img"],
                                    fit: BoxFit.cover,
                                  ),
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
                                  children: [
                                    Text(
                                      darfData.value[i]["name"],
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: blackC,
                                      ),
                                    ),
                                    Text(
                                      darfData.value[i]["msg"],
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: blackC.withOpacity(0.55),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.circle,
                                  color: Colors.blue, size: 15),
                            ],
                          ),
                        ),
                      ),
                    ],
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
