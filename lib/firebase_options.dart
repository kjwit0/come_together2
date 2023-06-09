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
    apiKey: 'AIzaSyD3wSsEL87a2bPM5Q1SdscvHEAAX4BHPqg',
    appId: '1:575648529034:web:a4afb65c798a48bef94b73',
    messagingSenderId: '575648529034',
    projectId: 'come-together-e2781',
    authDomain: 'come-together-e2781.firebaseapp.com',
    storageBucket: 'come-together-e2781.appspot.com',
    measurementId: 'G-L7TDBE46F7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfuWk_GqB-iTYiYP8rpAZ-h1yBC5XG7qo',
    appId: '1:575648529034:android:0ab08c0e603aba56f94b73',
    messagingSenderId: '575648529034',
    projectId: 'come-together-e2781',
    storageBucket: 'come-together-e2781.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDER0FynCReUSf3AqEPE-qsvNiFDjObdPo',
    appId: '1:575648529034:ios:e6e65ac73667f5fdf94b73',
    messagingSenderId: '575648529034',
    projectId: 'come-together-e2781',
    storageBucket: 'come-together-e2781.appspot.com',
    iosClientId: '575648529034-0388so88bqk97vah372h2rlbr7lnvcc5.apps.googleusercontent.com',
    iosBundleId: 'com.example.comeTogether2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDER0FynCReUSf3AqEPE-qsvNiFDjObdPo',
    appId: '1:575648529034:ios:e6e65ac73667f5fdf94b73',
    messagingSenderId: '575648529034',
    projectId: 'come-together-e2781',
    storageBucket: 'come-together-e2781.appspot.com',
    iosClientId: '575648529034-0388so88bqk97vah372h2rlbr7lnvcc5.apps.googleusercontent.com',
    iosBundleId: 'com.example.comeTogether2',
  );
}
