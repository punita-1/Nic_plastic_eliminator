

// import 'package:firebase_auth/firebase_auth.dart';

// Future<void> refreshAuthStateAfterDeletion() async {

//   await signOutUser();

// }

// Future<void> signOutUser() async {
//   await FirebaseAuth.instance.signOut();
//   print("User signed out successfully.");
// }


import 'package:firebase_auth/firebase_auth.dart';

Future<void> initializeAuth() async {
  try {
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  } catch (e) {
    print("Error setting persistence: $e");
  }

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
