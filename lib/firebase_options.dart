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
    apiKey: 'AIzaSyDzOWi90BG8ej98DIWc9GwQovP2IoP6Alk',
    appId: '1:356792877934:web:a475f04abe18ef4980377f',
    messagingSenderId: '356792877934',
    projectId: 'zag-cnp',
    authDomain: 'zag-cnp.firebaseapp.com',
    storageBucket: 'zag-cnp.appspot.com',
    measurementId: 'G-MZ5HW9YXB5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAipG-vuYFRRJgmmnl_J0EDvNzf4fmXayc',
    appId: '1:356792877934:android:0185a4a5f293209680377f',
    messagingSenderId: '356792877934',
    projectId: 'zag-cnp',
    storageBucket: 'zag-cnp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD5lVph6oxgfNAel4axaf_4vbWiz_-BYu0',
    appId: '1:356792877934:ios:9f64ed120d670c6380377f',
    messagingSenderId: '356792877934',
    projectId: 'zag-cnp',
    storageBucket: 'zag-cnp.appspot.com',
    iosClientId: '356792877934-nekpb622m1ql9irk8oabjdjnl31hndpc.apps.googleusercontent.com',
    iosBundleId: 'com.example.cityinpocket',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD5lVph6oxgfNAel4axaf_4vbWiz_-BYu0',
    appId: '1:356792877934:ios:3e3e9a7fabbbfee480377f',
    messagingSenderId: '356792877934',
    projectId: 'zag-cnp',
    storageBucket: 'zag-cnp.appspot.com',
    iosClientId: '356792877934-2go9nqog6517ie298pilgsu5aruf8gdc.apps.googleusercontent.com',
    iosBundleId: 'com.example.cityinpocket.RunnerTests',
  );
}