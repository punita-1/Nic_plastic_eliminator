import 'package:firebase_database/firebase_database.dart';
import 'package:plastic_eliminator/services/shared_pref.dart';


class FirebaseService {
  final DatabaseReference _userRef = FirebaseDatabase.instance.ref('users');

  Future<void> fetchUserData(String userId) async {
    final ref = _userRef.child(userId);
    final snapshot = await ref.get();

    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      final name = data['userName'];
      final email = data['userEmail'];
      final image = data['userImage'];

      // Save the fetched data to SharedPreferences
      await SharedPreferanceHelper().saveUserName(name);
      await SharedPreferanceHelper().saveUserEmail(email);
      await SharedPreferanceHelper().saveUserImage(image);
    } else {
      print('No data available.');
    }
  }
}
