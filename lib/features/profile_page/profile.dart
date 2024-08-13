// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plastic_eliminator/features/auth/presentation/login.dart';
import 'package:plastic_eliminator/features/profile_page/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plastic_eliminator/features/Admin/presentation/pages/admin_login.dart'; // Ensure you have this import for navigation

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
  String dateOfBirth =
      'Date of Birth not provided'; // Added field for date of birth
  String photoURL = 'https://via.placeholder.com/150';
  String clubName = 'No Club Selected'; // Added field for club name
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // List<Map<String, dynamic>> _registeredEvents = [];
  int totalLikes = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    // _loadRegisteredEvents();
    _calculateTotalLikesAndUpdateState();
  }

  Future<void> _calculateTotalLikesAndUpdateState() async {
    final likes = await _calculateTotalLikes();
    setState(() {
      totalLikes = likes;
    });
  }

  Future<int> _calculateTotalLikes() async {
    if (currentUser == null) return 0;

    try {
      final postsSnapshot = await FirebaseFirestore.instance
          .collection('UserMediaPosts')
          .where('UserEmail', isEqualTo: currentUser!.email)
          .get();

      int totalLikes = 0;
      for (var doc in postsSnapshot.docs) {
        final postData = doc.data() as Map<String, dynamic>;
        totalLikes += (postData['Likes'] as int?) ?? 0;
      }
      return totalLikes;
    } catch (e) {
      // print('Error calculating total likes: $e');
      return 0;
    }
  }

  Future<void> _loadUserData() async {
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        final userDoc =
            await _firestore.collection('users').doc(currentUser!.uid).get();
        if (userDoc.exists) {
          setState(() {
            userName = userDoc.data()?['name'] ?? 'User';
            email = currentUser!.email ?? 'Email not available';
            phoneNumber =
                userDoc.data()?['phoneNumber'] ?? 'Phone number not provided';
            dateOfBirth = userDoc.data()?['dateOfBirth'] ??
                'Date of Birth not provided'; // Fetch date of birth
            photoURL = userDoc.data()?['profileImageUrl'] ??
                currentUser!.photoURL ??
                'https://via.placeholder.com/150';
            clubName = userDoc.data()?['club'] ??
                'No Club Selected'; // Fetch club name
            _usernameController.text = userName;
            _phoneNumberController.text = phoneNumber;
            _dateOfBirthController.text = dateOfBirth;
          });
        }
      } catch (e) {
        // print('Error loading user data: $e');
      }
    } else {
      // print('No user is currently logged in');
    }
  }

  Future<void> _updateUserProfile() async {
    if (currentUser != null) {
      try {
        await _firestore.collection('users').doc(currentUser!.uid).update({
          'name': _usernameController.text,
          'phoneNumber': _phoneNumberController.text,
          'dateOfBirth': _dateOfBirthController.text,
        });

        await currentUser!.updateDisplayName(_usernameController.text);

        setState(() {
          userName = _usernameController.text;
          phoneNumber = _phoneNumberController.text;
          dateOfBirth = _dateOfBirthController.text;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully.')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e')),
        );
      }
    }
  }

  // Future<void> selectProfileImage(BuildContext context) async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     final File imageFile = File(pickedFile.path);

  //     try {
  //       final storageRef =
  //           _storage.ref().child('profile_images/${currentUser!.uid}');
  //       final uploadTask = storageRef.putFile(imageFile);
  //       final snapshot = await uploadTask.whenComplete(() {});
  //       final downloadUrl = await snapshot.ref.getDownloadURL();

  //       await currentUser!.updatePhotoURL(downloadUrl);
  //       await _firestore.collection('users').doc(currentUser!.uid).update({
  //         'profileImageUrl': downloadUrl,
  //       });

  //       setState(() {
  //         photoURL = downloadUrl;
  //       });

  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Profile image updated successfully.')),
  //       );
  //     } catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error uploading image: $e')),
  //       );
  //     }
  //   }
  // }
Future<void> selectProfileImage(BuildContext context) async {
  if (currentUser == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please log in first.')),
    );
    return; // Exit the method if the user is not logged in
  }

  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    final File imageFile = File(pickedFile.path);

    try {
      final storageRef =
          _storage.ref().child('profile_images/${currentUser!.uid}');
      final uploadTask = storageRef.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

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

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all stored data

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  Future<void> _logoutAndGoToAdminLogin() async {
    await FirebaseAuth.instance.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all stored data

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AdminLogin()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(photoURL),
                    backgroundColor: Colors.grey[200],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => selectProfileImage(context),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                userName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                email,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                phoneNumber,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                dateOfBirth,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                clubName, // Display club name here
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _dateOfBirthController,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth (YYYY-MM-DD)',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
    onTap: () async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Color(0xFF00ACC1), // Teal color for the buttons
              ),
              buttonTheme: ButtonThemeData(
                textTheme: ButtonTextTheme.primary,
              ),
            ),
            child: child!,
          );
        },
      );


                    if (pickedDate != null) {
                      setState(() {
                        _dateOfBirthController.text =
                            "${pickedDate.toLocal()}".split(' ')[0];
                      });
                    }
                  },
                ),
              ),

              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (currentUser == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please log in first.')),
                    );
                  } else {
                    _updateUserProfile();
                  }
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Text(
                'Total Likes: $totalLikes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              // Center(
              //     child: Text('Registered Events',
              //         style: TextStyle(fontSize: 20))),
              // const SizedBox(height: 24),
              // if (_registeredEvents.isNotEmpty)
              //   ..._registeredEvents
              //       .map((event) => Column(
              //             children: [
              //               ListTile(
              //                 title: Text(event['Name'] ?? 'No Event Name'),
              //                 subtitle: Text(event['Date'] ?? 'No Event Date'),
              //               ),
              //               Divider(),
              //   ],
              // ))
              //       .toList()
              // else
              //   Text('No events registered.'),
              TextButton(
                onPressed: _logoutAndGoToAdminLogin,
                child: const Text(
                  'Are you an admin?',
                  style: TextStyle(color: Colors.teal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> _loadRegisteredEvents() async {
  //   if (currentUser != null) {
  //     try {
  //       final registrationsSnapshot = await _firestore
  //           .collection('registrations')
  //           .where('userId', isEqualTo: currentUser!.uid)
  //           .get();

  //       final registeredEvents = registrationsSnapshot.docs.map((doc) {
  //         final eventData = doc.data();
  //         return {
  //           'Name': eventData['eventName'],
  //           'Date': eventData['eventDate'],
  //         };
  //       }).toList();

  //       setState(() {
  //         _registeredEvents = registeredEvents;
  //       });
  //     } catch (e) {
  //       // print('Error loading registered events: $e');
  //     }
  //   }
  // }
}
