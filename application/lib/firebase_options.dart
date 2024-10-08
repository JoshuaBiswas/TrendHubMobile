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
    apiKey: 'AIzaSyBfBOBJtIp52CIlifexCqksja-VSO9TM0c',
    appId: '1:56019761029:web:495a992a210ce9422d76ec',
    messagingSenderId: '56019761029',
    projectId: 'trendhubbase',
    authDomain: 'trendhubbase.firebaseapp.com',
    storageBucket: 'trendhubbase.appspot.com',
    measurementId: 'G-FMXPXBN69Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBrNX5EwQA8ffhcvgRaHAzToeDyNdqsIFM',
    appId: '1:56019761029:android:5736ed59b803870d2d76ec',
    messagingSenderId: '56019761029',
    projectId: 'trendhubbase',
    storageBucket: 'trendhubbase.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAo8EQbn75A8wijIrdAqkGmTrvAJY3Ity4',
    appId: '1:56019761029:ios:5be66eb11703b2a32d76ec',
    messagingSenderId: '56019761029',
    projectId: 'trendhubbase',
    storageBucket: 'trendhubbase.appspot.com',
    iosClientId: '56019761029-5jcf6496f4n2vkac4ef87v752hbih60j.apps.googleusercontent.com',
    iosBundleId: 'com.example.application',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAo8EQbn75A8wijIrdAqkGmTrvAJY3Ity4',
    appId: '1:56019761029:ios:5be66eb11703b2a32d76ec',
    messagingSenderId: '56019761029',
    projectId: 'trendhubbase',
    storageBucket: 'trendhubbase.appspot.com',
    iosClientId: '56019761029-5jcf6496f4n2vkac4ef87v752hbih60j.apps.googleusercontent.com',
    iosBundleId: 'com.example.application',
  );
}
