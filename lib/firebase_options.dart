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
    apiKey: 'AIzaSyCe40xLE01HkxyR0wdJZiSx5Y-uvOHRWEk',
    appId: '1:573767214589:web:e85245ff18c5fe40bfa594',
    messagingSenderId: '573767214589',
    projectId: 'bizfuel-c67b7',
    authDomain: 'bizfuel-c67b7.firebaseapp.com',
    storageBucket: 'bizfuel-c67b7.appspot.com',
    measurementId: 'G-14L1Q60C3R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJxxlZ7F7_quvm3JA1p4EQpQqiRDlpkZE',
    appId: '1:573767214589:android:4ba5638e1f3c0fc9bfa594',
    messagingSenderId: '573767214589',
    projectId: 'bizfuel-c67b7',
    storageBucket: 'bizfuel-c67b7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBbHuZ_zZGD1kG753UyebteJc95EzK-tjA',
    appId: '1:573767214589:ios:a9fb4a09032af777bfa594',
    messagingSenderId: '573767214589',
    projectId: 'bizfuel-c67b7',
    storageBucket: 'bizfuel-c67b7.appspot.com',
    iosBundleId: 'com.example.bizfuel',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBbHuZ_zZGD1kG753UyebteJc95EzK-tjA',
    appId: '1:573767214589:ios:a9fb4a09032af777bfa594',
    messagingSenderId: '573767214589',
    projectId: 'bizfuel-c67b7',
    storageBucket: 'bizfuel-c67b7.appspot.com',
    iosBundleId: 'com.example.bizfuel',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCe40xLE01HkxyR0wdJZiSx5Y-uvOHRWEk',
    appId: '1:573767214589:web:56e0081cd6439512bfa594',
    messagingSenderId: '573767214589',
    projectId: 'bizfuel-c67b7',
    authDomain: 'bizfuel-c67b7.firebaseapp.com',
    storageBucket: 'bizfuel-c67b7.appspot.com',
    measurementId: 'G-GS46C7K03S',
  );
}
