

import 'package:firebase_auth/firebase_auth.dart';

Future<void> refreshAuthStateAfterDeletion() async {

  await signOutUser();

}

Future<void> signOutUser() async {
  await FirebaseAuth.instance.signOut();
  print("User signed out successfully.");
}


