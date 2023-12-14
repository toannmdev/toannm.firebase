import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Requires that a Firebase local emulator is running locally.
/// See https://firebase.flutter.dev/docs/auth/start/#optional-prototype-and-test-with-firebase-local-emulator-suite
bool shouldUseFirebaseEmulator = true;

late final FirebaseApp app;
late final FirebaseAuth auth;

final emulatorHost =
    (!kIsWeb && defaultTargetPlatform == TargetPlatform.android)
        ? '10.0.2.2'
        : 'localhost';

// The port we've set the Firebase Database emulator to run on via the
// `firebase.json` configuration file. https://firebase.google.com/docs/emulator-suite/install_and_configure#port_configuration
const emulatorAuthPort = 9099;
const emulatorRTDBPort = 9000;
const emulatorStorePort = 9199;
