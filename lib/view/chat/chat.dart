// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swrv/state/chatstate.dart';
import 'package:swrv/state/userstate.dart';
import 'package:swrv/utils/alerts.dart';
import 'package:swrv/utils/utilthemes.dart';
import 'package:swrv/view/user/myaccount.dart';
import 'package:swrv/widgets/buttons.dart';

import '../../widgets/componets.dart';

class ChatPage extends HookConsumerWidget {
  const ChatPage({
    super.key,
    required this.avatarUrl,
    required this.userId,
    required this.userName,
  });
  final String userId;
  final String avatarUrl;
  final String userName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey =
        useMemoized(() => GlobalKey<FormState>());
    final width = MediaQuery.of(context).size.width;
    ScrollController scrollController = useScrollController();
    final chatStateW = ref.watch(chatState);
    ValueNotifier<bool> isLoading = useState(true);
    ValueNotifier<bool> needScroll = useState(false);

    ValueNotifier<String?> id = useState(null);
    UserState userState = UserState();
    TextEditingController msg = useTextEditingController();

    void scrollToEnd() {
      scrollController.jumpTo(
        scrollController.position.maxScrollExtent,
      );
    }

    void init() async {
      id.value = await userState.getUserId();
      await chatStateW.setMessages(context, userId);
      isLoading.value = false;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        scrollToEnd();
      });
    }

    useEffect(() {
      init();

      return () {};
    }, []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        scrollToEnd();
      });
      return null;
    });

    return Scaffold(
      backgroundColor: backgroundC,
      body: isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Header(),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      width: width,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(Icons.arrow_back_ios)),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    width: 35,
                                    height: 35,
                                    child: CachedNetworkImage(
                                      imageUrl: avatarUrl,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          Image.asset("assets/images/user.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                userName,
                                textScaleFactor: 1,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 100,
                                child: CusBtn(
                                  btnColor: primaryC,
                                  btnText: "Info",
                                  textSize: 16,
                                  btnFunction: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) => MyAccount(
                                              id: userId,
                                              isSendMsg: true,
                                            )),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                          const Divider(
                            color: blackC,
                          ),
                          // const Text("great"),
                          Expanded(
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: chatStateW.mes.length,
                              itemBuilder: ((context, index) {
                                return ChatBox(
                                  time: chatStateW.mes[index]["updatedAt"],
                                  text: chatStateW.mes[index]["comment"],
                                  isUser: chatStateW.mes[index]["fromUser"]
                                              ["id"]
                                          .toString() ==
                                      id.value,
                                );
                              }),
                            ),
                          ),
                          Form(
                            key: formKey,
                            child: Container(
                              padding: const EdgeInsets.only(top: 5),
                              height: 50,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: TextFormField(
                                        controller: msg,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xfff3f4f6),
                                          // prefixIcon: const Icon(Icons.mic),
                                          // suffixIcon: Row(
                                          //   mainAxisSize: MainAxisSize.min,
                                          //   children: const [
                                          //     InkWell(
                                          //         child: Icon(Icons.attachment)),
                                          //     InkWell(child: Icon(Icons.camera)),
                                          //     InkWell(child: Icon(Icons.face)),
                                          //     SizedBox(
                                          //       width: 5,
                                          //     )
                                          //   ],
                                          // ),
                                          hintText: "Type Something",
                                          hintStyle: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.5)),
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
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 65,
                                    child: CusBtn(
                                      btnColor: secondaryC,
                                      btnText: "Send",
                                      textSize: 14,
                                      btnFunction: () async {
                                        isLoading.value = true;
                                        if (msg.text == "" ||
                                            msg.text.isEmpty) {
                                          erroralert(context, "Error",
                                              "You can't send empty message");
                                        } else {
                                          await chatStateW.sendMessage(
                                              context, msg.text, userId);
                                          msg.clear();

                                          chatStateW.setMessages(
                                              context, userId);
                                          needScroll.value = true;
                                          isLoading.value = false;
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
    );
  }
}

class ChatBox extends HookWidget {
  final String time;
  final String text;
  final bool isUser;
  const ChatBox({
    super.key,
    required this.isUser,
    required this.text,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Align(
      alignment: isUser ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        width: width * 0.75,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isUser ? const Color(0xffa5f3fc) : backgroundC,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft:
                isUser ? const Radius.circular(15) : const Radius.circular(0),
            bottomRight:
                isUser ? const Radius.circular(0) : const Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              time,
              textScaleFactor: 1,
              style: TextStyle(
                color: blackC.withOpacity(0.65),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              text,
              textScaleFactor: 1,
              style: TextStyle(
                color: blackC.withOpacity(0.85),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
