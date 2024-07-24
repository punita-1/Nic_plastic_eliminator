import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addUserDetails(
      Map<String, dynamic> userInfoMap, String id) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(id).set(
          userInfoMap,
          SetOptions(merge: true)); // Merge to update existing fields
      print("User details added successfully.");
    } catch (e) {
      print("Error adding user details: $e");
    }
  }

  Future addevents(Map<String, dynamic> userInfoMap, String monthName) async {
    return await FirebaseFirestore.instance
        .collection(monthName)
        .add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getEvents(String month) async {
    return await FirebaseFirestore.instance.collection(month).snapshots();
  }
}
