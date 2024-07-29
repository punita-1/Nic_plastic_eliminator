import 'package:firebase_auth/firebase_auth.dart';
import 'package:plastic_eliminator/services/shared_pref.dart';
// import 'package:plastic_eliminator/services/shared_preference_helper.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SharedPreferanceHelper _prefsHelper = SharedPreferanceHelper();

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    await _prefsHelper.saveUserEmail(userCredential.user!.email!);
    await _prefsHelper.saveLoginState(); // Set login state to true
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _prefsHelper.removeLoginState(); // Clear login state
  }
}
