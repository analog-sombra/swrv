import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'database/database.dart';
import 'services/firebase.dart';
import 'view/login.dart';

//removing scroll grow effect
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await isarInit();
  runApp(const ProviderScope(child: SWRV()));
}

class SWRV extends HookConsumerWidget {
  const SWRV({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseAppW = ref.watch(firebaseApp);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: "SWRV",
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(primaryColor: Colors.blue, canvasColor: Colors.transparent),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child!,
        );
      },
      home: firebaseAppW.when(
        data: (data) {
          return const Login();
        },
        error: (err, stack) => Center(
          child: Center(child: Text("Error: $err")),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
