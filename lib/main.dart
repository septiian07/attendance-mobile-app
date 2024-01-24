import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'src/app/app.locator.dart';
import 'src/helpers/setup/setup_dialog.dart';
import 'src/injector/injector.dart';
import 'src/my_app.dart';

Future<void> main() async {
  try {
    runZonedGuarded<Future<void>>(() async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        name: 'Attendance Mobile',
        options: const FirebaseOptions(
          apiKey: 'AIzaSyAHAsf51D0A407EklG1bs-5wA7EbyfNFg0',
          appId: '1:448618578101:ios:2bc5c1fe2ec336f8ac3efc',
          messagingSenderId: '448618578101',
          projectId: 'react-native-firebase-testing',
        ),
      );

      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

      await setupInjector();
      setupLocator();
      setupDialog();
      runApp(const MyApp());
    },
        (error, stack) =>
            FirebaseCrashlytics.instance.recordError(error, stack));
  } catch (error) {
    // print('$error & $stacktrace');
  }
}
