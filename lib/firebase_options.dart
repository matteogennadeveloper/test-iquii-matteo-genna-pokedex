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
    apiKey: 'AIzaSyDJvnuTk56HMEFwctcHpHguYoeU2vmR2rU',
    appId: '1:292588197941:web:e5a9cf6697e3dbeb18f97c',
    messagingSenderId: '292588197941',
    projectId: 'pokedex-65af3',
    authDomain: 'pokedex-65af3.firebaseapp.com',
    storageBucket: 'pokedex-65af3.appspot.com',
    measurementId: 'G-EJL3QR4YZF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJ1w0aI_zwcohBjOEhvC4KFTKYsiPqXn8',
    appId: '1:292588197941:android:261f31205d8c02e918f97c',
    messagingSenderId: '292588197941',
    projectId: 'pokedex-65af3',
    storageBucket: 'pokedex-65af3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB-tS40-68rdw-qZnaluRfWZPFrnUbBbw0',
    appId: '1:292588197941:ios:442ce6dfbc9a87f118f97c',
    messagingSenderId: '292588197941',
    projectId: 'pokedex-65af3',
    storageBucket: 'pokedex-65af3.appspot.com',
    iosBundleId: 'com.example.testIquii',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB-tS40-68rdw-qZnaluRfWZPFrnUbBbw0',
    appId: '1:292588197941:ios:442ce6dfbc9a87f118f97c',
    messagingSenderId: '292588197941',
    projectId: 'pokedex-65af3',
    storageBucket: 'pokedex-65af3.appspot.com',
    iosBundleId: 'com.example.testIquii',
  );
}
