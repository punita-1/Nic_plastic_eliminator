// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';

/// Initializes Firebase Authentication and sets up authentication state listeners.
///
/// This function configures Firebase Authentication to persist the user's sign-in state locally
/// and listens for changes in the authentication state. It logs whether a user is signed in or out.
///
/// Throws an exception if setting the persistence fails.
Future<void> initializeAuth() async {
  try {
    // Set Firebase Authentication persistence to LOCAL
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
    print("Authentication persistence set to LOCAL.");
  } catch (e) {
    print("Error setting persistence: $e");
  }

  // Listen to changes in authentication state
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      // User is signed in
      print('User is signed in: ${user.uid}');
    } else {
      // User is signed out
      print('User is signed out');
    }
  });
}
