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
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: 'react-native-firebase-testing',
    authDomain: '',
    databaseURL: '',
    storageBucket: '',
    measurementId: '',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-lDeCwQR6mtA53saPGfkIopN94agTOOo',
    appId: '1:894413922477:android:645bac0bd563bfe9ed6624',
    messagingSenderId: '894413922477',
    projectId: 'doctor-74824',
    storageBucket: 'doctor-74824.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: 'bootcampflutter-799c7',
    storageBucket: '',
  );
}
