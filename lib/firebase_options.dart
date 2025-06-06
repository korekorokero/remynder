// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAnXh1eC0dPsf0ZrMbrg1gt3ILXobGetq4',
    appId: '1:917255006816:web:263cec34a89ac41391f105',
    messagingSenderId: '917255006816',
    projectId: 'remynder-6d0d2',
    authDomain: 'remynder-6d0d2.firebaseapp.com',
    storageBucket: 'remynder-6d0d2.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDtuxLt-O-yEM0pf-bt4psWrGcZqcFM6p8',
    appId: '1:917255006816:android:57fa7cd95edb71d391f105',
    messagingSenderId: '917255006816',
    projectId: 'remynder-6d0d2',
    storageBucket: 'remynder-6d0d2.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD7zeTX8_WZm3N6N2s4tUzwUdQLLeBVNhw',
    appId: '1:917255006816:ios:7acec8d4eac2b16591f105',
    messagingSenderId: '917255006816',
    projectId: 'remynder-6d0d2',
    storageBucket: 'remynder-6d0d2.firebasestorage.app',
    iosBundleId: 'com.example.remynder',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD7zeTX8_WZm3N6N2s4tUzwUdQLLeBVNhw',
    appId: '1:917255006816:ios:7acec8d4eac2b16591f105',
    messagingSenderId: '917255006816',
    projectId: 'remynder-6d0d2',
    storageBucket: 'remynder-6d0d2.firebasestorage.app',
    iosBundleId: 'com.example.remynder',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAnXh1eC0dPsf0ZrMbrg1gt3ILXobGetq4',
    appId: '1:917255006816:web:71e0f12725ce0c2491f105',
    messagingSenderId: '917255006816',
    projectId: 'remynder-6d0d2',
    authDomain: 'remynder-6d0d2.firebaseapp.com',
    storageBucket: 'remynder-6d0d2.firebasestorage.app',
  );
}
