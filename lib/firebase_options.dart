// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyADYd7Pha1x4eJUaJfZhqlZkODoggc40H8',
    appId: '1:481062718504:web:c7847bed1fe34bd166391d',
    messagingSenderId: '481062718504',
    projectId: 'swrv-c4602',
    authDomain: 'swrv-c4602.firebaseapp.com',
    storageBucket: 'swrv-c4602.appspot.com',
    measurementId: 'G-V73X7S50JZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDdwmRX4JrGbiKerzD8Q0iVht2OtaGNlv4',
    appId: '1:481062718504:android:e77cbdc0de237a9366391d',
    messagingSenderId: '481062718504',
    projectId: 'swrv-c4602',
    storageBucket: 'swrv-c4602.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDZSjXDMTy6Oguht96T7JE79T0U4gdxdoU',
    appId: '1:481062718504:ios:0ff39796e883cf9366391d',
    messagingSenderId: '481062718504',
    projectId: 'swrv-c4602',
    storageBucket: 'swrv-c4602.appspot.com',
    iosClientId: '481062718504-uigk7gk2jgdphi8gb4sm05tqnod9qeaq.apps.googleusercontent.com',
    iosBundleId: 'com.example.swrv',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDZSjXDMTy6Oguht96T7JE79T0U4gdxdoU',
    appId: '1:481062718504:ios:0ff39796e883cf9366391d',
    messagingSenderId: '481062718504',
    projectId: 'swrv-c4602',
    storageBucket: 'swrv-c4602.appspot.com',
    iosClientId: '481062718504-uigk7gk2jgdphi8gb4sm05tqnod9qeaq.apps.googleusercontent.com',
    iosBundleId: 'com.example.swrv',
  );
}