// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/state/inboxstate.dart';
import 'package:swrv/state/userstate.dart';
import 'package:swrv/utils/utilthemes.dart';

import '../../widgets/componets.dart';
import '../chat/chat.dart';
import '../navigation/bottomnavbar.dart';
import '../navigation/drawer.dart';

class Inbox extends HookConsumerWidget {
  const Inbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());
    final width = MediaQuery.of(context).size.width;
    UserState userState = UserState();

    ValueNotifier<bool> isLoading = useState(true);
    ValueNotifier<String?> userId = useState<String?>(null);
    final inboxStateW = ref.watch(inboxState);

    void init() async {
      userId.value = await userState.getUserId();
      await inboxStateW.showInboxMsg(context);
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
          ? const Center(
              child: CircularProgressIndicator(),
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
                      margin: const EdgeInsets.all(25),
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
                          const Text(
                            "Inbox",
                            textScaleFactor: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: secondaryC),
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10,
                          ),
                          if (inboxStateW.messages.isEmpty) ...[
                            const Center(
                              child: Text(
                                "Inbox is empty",
                                textScaleFactor: 1,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: secondaryC),
                              ),
                            ),
                          ] else ...[
                            for (int i = 0;
                                i < inboxStateW.messages.length;
                                i++) ...[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) => ChatPage(
                                              avatarUrl: inboxStateW.messages[i]
                                                          ["fromUser"]["id"] ==
                                                      userId.value
                                                  ? inboxStateW.messages[i]
                                                      ["toUser"]["pic"]
                                                  : inboxStateW.messages[i]
                                                      ["fromUser"]["pic"],
                                              userName: inboxStateW.messages[i]
                                                          ["fromUser"]["id"] ==
                                                      userId.value
                                                  ? inboxStateW.messages[i]
                                                          ["toUser"]["name"]
                                                      .toString()
                                                      .split("@")[0]
                                                  : inboxStateW.messages[i]
                                                          ["fromUser"]["name"]
                                                      .toString()
                                                      .split("@")[0],
                                              userId: inboxStateW.messages[i]
                                                          ["fromUser"]["id"] ==
                                                      userId.value
                                                  ? inboxStateW.messages[i]
                                                      ["toUser"]["id"]
                                                  : inboxStateW.messages[i]
                                                      ["fromUser"]["id"],
                                            )),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: CachedNetworkImage(
                                            imageUrl: inboxStateW.messages[i]
                                                        ["fromUser"]["id"] ==
                                                    userId.value
                                                ? inboxStateW.messages[i]
                                                    ["toUser"]["pic"]
                                                : inboxStateW.messages[i]
                                                    ["fromUser"]["pic"],
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                CircularProgressIndicator(
                                                    value: downloadProgress
                                                        .progress),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    "assets/images/user.png"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              inboxStateW.messages[i]
                                                          ["fromUser"]["id"] ==
                                                      userId.value
                                                  ? inboxStateW.messages[i]
                                                          ["toUser"]["name"]
                                                      .toString()
                                                      .split("@")[0]
                                                  : inboxStateW.messages[i]
                                                          ["fromUser"]["name"]
                                                      .toString()
                                                      .split("@")[0],
                                              textScaleFactor: 1,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: blackC,
                                              ),
                                            ),
                                            Text(
                                              "${inboxStateW.messages[i]["fromUser"]["id"] == userId.value ? "you: " : ""} ${inboxStateW.messages[i]["comment"]}",
                                              overflow: TextOverflow.ellipsis,
                                              textScaleFactor: 1,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: blackC,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
