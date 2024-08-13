// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  /// Adds user details to the Firestore database.
  ///
  /// [userInfoMap] A map containing user details to be added or updated.
  /// [id] The document ID where the user details will be stored.
  /// This method merges the new data with the existing document.
  Future<void> addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .set(userInfoMap, SetOptions(merge: true)); // Merge to update existing fields
      print("User details added successfully.");
    } catch (e) {
      print("Error adding user details: $e");
    }
  }

  /// Adds an event to a specified Firestore collection.
  ///
  /// [userInfoMap] A map containing event details to be added.
  /// [monthName] The name of the collection (e.g., month) where the event will be stored.
  /// This method adds a new document to the specified collection with the given event details.
  Future<void> addEvent(Map<String, dynamic> userInfoMap, String monthName) async {
    try {
      await FirebaseFirestore.instance
          .collection(monthName)
          .add(userInfoMap);
      print("Event added successfully.");
    } catch (e) {
      print("Error adding event: $e");
    }
  }

  /// Retrieves a stream of events from a specified Firestore collection.
  ///
  /// [month] The name of the collection (e.g., month) from which events will be retrieved.
  /// Returns a [Stream<QuerySnapshot>] that listens to real-time updates of the collection.
  Future<Stream<QuerySnapshot>> getEvents(String month) async {
    return FirebaseFirestore.instance.collection(month).snapshots();
  }
}
