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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAdl2NTIHXrDdUV3A90Q7-TSRAeY5iMlGk',
    appId: '1:441083531339:web:4d2a6e353ab3c63f277dce',
    messagingSenderId: '441083531339',
    projectId: 'database-tester-7b8d1',
    authDomain: 'database-tester-7b8d1.firebaseapp.com',
    databaseURL: 'https://database-tester-7b8d1-default-rtdb.firebaseio.com',
    storageBucket: 'database-tester-7b8d1.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCSWrL58jWn-gxg1UelHXWEasOzc1mhSbE',
    appId: '1:441083531339:android:979fccb9bd959824277dce',
    messagingSenderId: '441083531339',
    projectId: 'database-tester-7b8d1',
    databaseURL: 'https://database-tester-7b8d1-default-rtdb.firebaseio.com',
    storageBucket: 'database-tester-7b8d1.appspot.com',
  );
}
