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
    apiKey: 'AIzaSyCCjrdSsVGN6hDNCZFCeInvX4q2bmgP7Io',
    appId: '1:280414475439:web:6bff521a0ac800e0e9705a',
    messagingSenderId: '280414475439',
    projectId: 'putain-8c812',
    authDomain: 'putain-8c812.firebaseapp.com',
    storageBucket: 'putain-8c812.appspot.com',
    measurementId: 'G-T8ZC63YG01',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBAQxXjiq8HiC2s-ntiiYeqjr5yqKgGdOU',
    appId: '1:280414475439:android:69d02d5d80307b16e9705a',
    messagingSenderId: '280414475439',
    projectId: 'putain-8c812',
    storageBucket: 'putain-8c812.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB7RJP0nq-Y5An8CitVrOyQbpouA4QSiZE',
    appId: '1:280414475439:ios:6f0ece737b960d75e9705a',
    messagingSenderId: '280414475439',
    projectId: 'putain-8c812',
    storageBucket: 'putain-8c812.appspot.com',
    iosBundleId: 'com.example.shopnewversion',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB7RJP0nq-Y5An8CitVrOyQbpouA4QSiZE',
    appId: '1:280414475439:ios:6f0ece737b960d75e9705a',
    messagingSenderId: '280414475439',
    projectId: 'putain-8c812',
    storageBucket: 'putain-8c812.appspot.com',
    iosBundleId: 'com.example.shopnewversion',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCCjrdSsVGN6hDNCZFCeInvX4q2bmgP7Io',
    appId: '1:280414475439:web:e8c11fe28f46bc83e9705a',
    messagingSenderId: '280414475439',
    projectId: 'putain-8c812',
    authDomain: 'putain-8c812.firebaseapp.com',
    storageBucket: 'putain-8c812.appspot.com',
    measurementId: 'G-BKCLJLQMRG',
  );
}