import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plastic_eliminator/pages/initial_pages/login.dart';
import 'package:plastic_eliminator/pages/profile_page/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plastic_eliminator/Admin/admin_login.dart'; // Ensure you have this import for navigation
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plastic_eliminator/pages/initial_pages/login.dart';
import 'package:plastic_eliminator/pages/profile_page/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plastic_eliminator/Admin/admin_login.dart'; // Ensure you have this import for navigation

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
  String clubName = 'No Club Selected'; // Added field for club name
  final TextEditingController _usernameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _registeredEvents = [];
  int totalLikes = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadRegisteredEvents();
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
      print('Error calculating total likes: $e');
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
            photoURL = userDoc.data()?['profileImageUrl'] ??
                currentUser!.photoURL ??
                'https://via.placeholder.com/150';
            clubName = userDoc.data()?['club'] ??
                'No Club Selected'; // Fetch club name
            _usernameController.text = userName;
          });
        }
      } catch (e) {
        print('Error loading user data: $e');
      }
    } else {
      print('No user is currently logged in');
    }
  }

  Future<void> addEventNameToExistingRegistrations() async {
    try {
      final registrationsSnapshot =
          await FirebaseFirestore.instance.collection('registrations').get();

      for (var doc in registrationsSnapshot.docs) {
        final registrationData = doc.data();
        final eventName = registrationData[
            'eventName']; // Fetch eventName from the registration

        if (eventName != null) {
          await doc.reference.update({'eventName': eventName});
        } else {
          print('No eventName found in registration document ${doc.id}');
        }
      }
    } catch (e) {
      print('Error updating registrations: $e');
    }
  }

  Future<String?> getEventIdByName(String eventName) async {
    try {
      final eventsSnapshot = await FirebaseFirestore.instance
          .collection('events')
          .where('eventName', isEqualTo: eventName)
          .get();

      if (eventsSnapshot.docs.isNotEmpty) {
        return eventsSnapshot
            .docs.first.id; // Return the ID of the first matching event
      } else {
        print('No event found with name $eventName');
        return null;
      }
    } catch (e) {
      print('Error fetching eventId for eventName $eventName: $e');
      return null;
    }
  }

  Future<void> _loadRegisteredEvents() async {
    final events = await _fetchRegisteredEvents();
    setState(() {
      _registeredEvents = events;
    });
  }

  Future<List<Map<String, dynamic>>> _fetchRegisteredEvents() async {
    List<Map<String, dynamic>> events = [];
    if (currentUser != null) {
      try {
        final registrationsSnapshot = await _firestore
            .collection('registrations')
            .where('userId', isEqualTo: currentUser!.uid)
            .get();

        for (var doc in registrationsSnapshot.docs) {
          final registrationData = doc.data();
          final eventId = registrationData['eventId'];

          if (eventId != null) {
            try {
              final eventDoc =
                  await _firestore.collection('December').doc(eventId).get();

              if (eventDoc.exists) {
                print('Fetched event data: ${eventDoc.data()}');
                events.add(eventDoc.data()!);
              } else {
                print('Event with ID $eventId does not exist.');
              }
            } catch (e) {
              print('Error fetching event with ID $eventId: $e');
            }
          } else {
            print('No eventId found in registration document.');
          }
        }
      } catch (e) {
        print('Error fetching registered events: $e');
      }
    } else {
      print('No user is currently logged in');
    }
    return events;
  }

  Future<void> _updateUserName() async {
    if (currentUser != null && _usernameController.text.isNotEmpty) {
      try {
        await _firestore.collection('users').doc(currentUser!.uid).update({
          'name': _usernameController.text,
        });

        await currentUser!.updateDisplayName(_usernameController.text);

        setState(() {
          userName = _usernameController.text;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Username updated successfully.')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating username: $e')),
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

  Future<void> selectProfileImage(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

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
                '$clubName', // Display club name here
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  // color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.save,
                      ),
                      onPressed: _updateUserName,
                    ),
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
              // ElevatedButton(
              //   onPressed: _logout,
              //   style: ElevatedButton.styleFrom(
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              //     textStyle: Theme.of(context).textTheme.bodyMedium,
              //     shape: RoundedRectangleBorder(
              //       borderRadius:
              //           BorderRadius.circular(8), // Adjust this value as needed
              //     ),
              //   ),
              //   child: const Text(
              //     'Logout',
              //     style: TextStyle(color: Colors.teal),
              //   ),
              // ),
              const SizedBox(height: 24), // Add spacing before the new button

              Center(child: Text('Registered Events', style: TextStyle(fontSize: 20),)),
              const SizedBox(height: 24),
              if (_registeredEvents.isNotEmpty)
                ..._registeredEvents
                    .map((event) => Column(
                          children: [
                            ListTile(
                              title: Text(event['Name'] ??
                                  'No Event Name'), // Event name
                              subtitle: Text(event['Date'] ??
                                  'No Event Date'), // Event date
                            ),
                            Divider(),
                          ],
                        ))
                    .toList()
              else
                Text('No events registered.'),
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
}
