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
    apiKey: 'AIzaSyBiP13W9PdwM_HoYVdyKeIFyw3w6sjTY1k',
    appId: '1:360266895523:web:fc36f99ef7f5f601bcef16',
    messagingSenderId: '360266895523',
    projectId: 'project-plo',
    authDomain: 'project-plo.firebaseapp.com',
    storageBucket: 'project-plo.appspot.com',
    measurementId: 'G-Q3JRDJG4Z0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB26PKbBSOqwTWZd6jLeuv1mqQ-dNOZrB0',
    appId: '1:360266895523:android:4a887f08c52422b2bcef16',
    messagingSenderId: '360266895523',
    projectId: 'project-plo',
    storageBucket: 'project-plo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDuJ4dcSuQQbnGGldIc-w2byPBYgPMoPG0',
    appId: '1:360266895523:ios:19df97b80536c655bcef16',
    messagingSenderId: '360266895523',
    projectId: 'project-plo',
    storageBucket: 'project-plo.appspot.com',
    iosBundleId: 'com.example.plo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDuJ4dcSuQQbnGGldIc-w2byPBYgPMoPG0',
    appId: '1:360266895523:ios:101e62ad8490b357bcef16',
    messagingSenderId: '360266895523',
    projectId: 'project-plo',
    storageBucket: 'project-plo.appspot.com',
    iosBundleId: 'com.example.plo.RunnerTests',
  );
}