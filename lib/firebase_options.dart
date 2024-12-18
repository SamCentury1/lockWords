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
    apiKey: 'AIzaSyB3NCO4B0_p5eaV7FVsln8QGRtJN61yAsc',
    appId: '1:530495360476:web:eb589f86a651a504279319',
    messagingSenderId: '530495360476',
    projectId: 'cryptext-7c891',
    authDomain: 'cryptext-7c891.firebaseapp.com',
    storageBucket: 'cryptext-7c891.appspot.com',
    measurementId: 'G-92XVVM82Y2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCU-CQuMwUXiWR18J50i5r83r99mIIOEKQ',
    appId: '1:530495360476:android:47ae426952ce01cd279319',
    messagingSenderId: '530495360476',
    projectId: 'cryptext-7c891',
    storageBucket: 'cryptext-7c891.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAukiHZjyM_RDOWP9uBUpYVmWuevvkyXLI',
    appId: '1:530495360476:ios:b36a85b46714b3eb279319',
    messagingSenderId: '530495360476',
    projectId: 'cryptext-7c891',
    storageBucket: 'cryptext-7c891.appspot.com',
    androidClientId: '530495360476-992q4efik5dbc0mj5qp10ppvc2f5pgt8.apps.googleusercontent.com',
    iosClientId: '530495360476-b68bal9ukh59m0easmn4oca0cvrv6a4f.apps.googleusercontent.com',
    iosBundleId: 'com.nodamngoodstudios.cryptext',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAukiHZjyM_RDOWP9uBUpYVmWuevvkyXLI',
    appId: '1:530495360476:ios:b36a85b46714b3eb279319',
    messagingSenderId: '530495360476',
    projectId: 'cryptext-7c891',
    storageBucket: 'cryptext-7c891.appspot.com',
    androidClientId: '530495360476-992q4efik5dbc0mj5qp10ppvc2f5pgt8.apps.googleusercontent.com',
    iosClientId: '530495360476-b68bal9ukh59m0easmn4oca0cvrv6a4f.apps.googleusercontent.com',
    iosBundleId: 'com.nodamngoodstudios.cryptext',
  );
}
