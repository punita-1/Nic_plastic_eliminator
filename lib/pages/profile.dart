import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plastic_eliminator/pages/signup.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? currentUser;
  String userName = 'User';
  String email = 'Email not available';
  String phoneNumber = 'Phone number not provided';
  String photoURL = 'https://via.placeholder.com/150';

  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userDoc =
          await _firestore.collection('users').doc(currentUser!.uid).get();
      setState(() {
        userName = userDoc.data()?['name'] ?? 'User';
        email = currentUser!.email ?? 'Email not available';
        phoneNumber =
            userDoc.data()?['phoneNumber'] ?? 'Phone number not provided';
        photoURL = userDoc.data()?['profileImageUrl'] ??
            currentUser!.photoURL ??
            'https://via.placeholder.com/150';
      });
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Signup()),
    );
  }

  Future<void> selectProfileImage(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      // Upload image to Firebase Storage
      try {
        final storageRef =
            _storage.ref().child('profile_images/${currentUser!.uid}');
        final uploadTask = storageRef.putFile(imageFile);
        final snapshot = await uploadTask.whenComplete(() {});
        final downloadUrl = await snapshot.ref.getDownloadURL();

        // Update user profile and Firestore document
        await currentUser!.updatePhotoURL(downloadUrl);
        await _firestore.collection('users').doc(currentUser!.uid).update({
          'profileImageUrl': downloadUrl,
        });

        setState(() {
          photoURL = downloadUrl;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile image updated successfully.')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading image: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile image
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(photoURL),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: 16),

              // Upload profile image button
              ElevatedButton(
                onPressed: () => selectProfileImage(context),
                child: const Text('Upload Profile Image'),
              ),
              const SizedBox(height: 16),

              // Username
              Text(
                'Hello, $userName!',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Email
              Text(
                'Email: $email',
                style: const TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Phone number
              Text(
                'Phone: $phoneNumber',
                style: const TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Logout button
              ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
