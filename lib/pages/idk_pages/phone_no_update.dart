import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';

Future<void> uploadProfileImage(File imageFile) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final storageRef =
        FirebaseStorage.instance.ref().child('profile_images/${user.uid}.jpg');
    await storageRef.putFile(imageFile);
    final imageUrl = await storageRef.getDownloadURL();
    await user.updatePhotoURL(imageUrl);
  }
}

Future<void> selectProfileImage(BuildContext context) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    File imageFile = File(pickedFile.path);
    await uploadProfileImage(imageFile);
    // Reload profile data after updating
    (context as Element).reassemble();
  }
}

Future<void> updatePhoneNumber(String phoneNumber) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({'phoneNumber': phoneNumber});
  }
}
