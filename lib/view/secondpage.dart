import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class ShowMemberDetails extends StatefulWidget {
  const ShowMemberDetails({Key? key}) : super(key: key);

  @override
  State<ShowMemberDetails> createState() => _ShowMemberDetailsState();
}

class _ShowMemberDetailsState extends State<ShowMemberDetails> {
  final TextEditingController _search = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: CupertinoPageScaffold(
        backgroundColor: Colors.white,
        navigationBar: CupertinoNavigationBar(
          middle: const Text("All Contact List"),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            child: const Icon(
              Icons.refresh,
              color: CupertinoColors.activeBlue,
            ),
          ),
        ),
        child: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: size.height / 10,
                          width: size.width / 1,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(top: 5),
                          child: SizedBox(
                            height: size.height / 16,
                            width: size.width / 1.1,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    onChanged: (value) {},
                                    controller: _search,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white70,
                                      prefixIcon: const Icon(Icons.search),
                                      hintText: "Search",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _controller,
                    shrinkWrap: true,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onLongPress: () {},
                        onTap: () {},
                        title: Row(children: const [
                          Icon(Icons.person),
                          Expanded(
                            child: Text(
                              "data",
                            ),
                          )
                        ]),
                        subtitle: Row(
                          children: const <Widget>[
                            Icon(Icons.folder_open),
                            Expanded(
                              child: Text("data"),
                            ),
                            Icon(Icons.call),
                            Expanded(child: Text("some data"))
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
