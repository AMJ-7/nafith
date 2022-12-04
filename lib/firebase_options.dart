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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJFYCkgk51lLTza1zL-ikGc--aMmVVcz8',
    appId: '1:854239875016:android:82618527690766d03e7afd',
    messagingSenderId: '854239875016',
    projectId: 'raqi-ced36',
    storageBucket: 'raqi-ced36.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD1OM-2UQ4sPKkPNIA1frGI85mYYq-JudE',
    appId: '1:854239875016:ios:304d6d1f7c4ad0bb3e7afd',
    messagingSenderId: '854239875016',
    projectId: 'raqi-ced36',
    storageBucket: 'raqi-ced36.appspot.com',
    androidClientId: '854239875016-234grissphhi7fu7pvc86tkb1p1ekd45.apps.googleusercontent.com',
    iosClientId: '854239875016-blk370in5h05u8miam2f8r021nerv1nh.apps.googleusercontent.com',
    iosBundleId: 'com.raqi.app',
  );
}
