import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plastic_eliminator/pages/signup.dart';
import 'package:plastic_eliminator/services/shared_pref.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Function to delete the user
  Future<void> deleteUser() async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Delete the user
        await user.delete();
        print('User deleted successfully.');

        // Navigate to the sign-up screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Signup(),
          ),
        );
      } else {
        print('No user is currently signed in.');
      }
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  // Function to log out the user
  Future<void> logoutUser() async {
    try {
      // Sign out the user
      await FirebaseAuth.instance.signOut();
      print('User signed out successfully.');

      // Navigate to the sign-up screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Signup(),
        ),
      );
    } catch (e) {
      print('Error signing out user: $e');
    }
  }

  String? name, image, email;

  Future<void> getthedatafromsharedpref() async {
    name = await SharedPreferanceHelper().getUserName();
    image = await SharedPreferanceHelper().getUserImage();
    email = await SharedPreferanceHelper().getUserEmail();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getthedatafromsharedpref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hello,',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(188, 0, 0, 0),
                      ),
                    ),
                    Text(
                      name ?? 'Loading...',
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      email ?? 'Loading...',
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: image != null
                      ? Image.network(
                          'https://user-images.githubusercontent.com/55682574/146731502-9f57b365-6375-4d16-9344-2bc471386c7d.png',
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'Assets/images/girl_profile.png',
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                // Confirm user deletion with a dialog
                bool? confirmDeletion = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Delete Account'),
                    content:
                        Text('Are you sure you want to delete your account?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                );

                if (confirmDeletion == true) {
                  // Call the deleteUser function
                  await deleteUser();
                }
              },
              child: Text('Delete Account'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Call the logoutUser function
                await logoutUser();
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
