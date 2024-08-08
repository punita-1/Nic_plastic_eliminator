import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plastic_eliminator/pages/initial_pages/login.dart';
import 'package:random_string/random_string.dart';
import 'bottomnav.dart'; // Your Bottomnav widget
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  File? _profileImage;
  final _picker = ImagePicker();
  bool _obscureText = true;
  bool _isLoading = false; // Added here

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _signUp() async {
    if (_profileImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a profile picture.')),
      );
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final name = _nameController.text.trim();
      final phoneNumber = _phoneController.text.trim();

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        // Upload profile image to Firebase Storage
        final storageRef = _storage.ref().child('profile_images/${user.uid}');
        final uploadTask = storageRef.putFile(_profileImage!);
        final snapshot = await uploadTask.whenComplete(() {});
        final downloadUrl = await snapshot.ref.getDownloadURL();

        // Save user data to Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'phoneNumber': phoneNumber,
          'profileImageUrl': downloadUrl,
        });

        // Save login state and user information to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userEmail', email);
        await prefs.setString('userName', name);
        await prefs.setString('userPhone', phoneNumber);
        await prefs.setString('profileImageUrl', downloadUrl);

        // Navigate to the main screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Bottomnav()),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50.0, left: 20.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.teal,
                  Color(0xFFB2EBF2),
                  // Colors.white,
                ],
              ),
            ),
            child: Text(
              'Create Your\nAccount!',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding:
                  EdgeInsets.only(top: 25, left: 30, right: 30, bottom: 20),
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 5.5),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Icon(
                      Icons.arrow_upward,
                      // color: Colors.grey,
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: _profileImage != null
                              ? FileImage(_profileImage!)
                              : AssetImage('Assets/logo_image/signup_man.png')
                                  as ImageProvider,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Icon(
                              Icons.camera_alt,
                              // color: Colors.grey
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 21,
                        // color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Name',
                        prefixIcon: Icon(
                          Icons.person,
                          // color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 21,
                        // color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(
                          Icons.mail_outline,
                          // color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 21,
                        // color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(
                          Icons.password_outlined,
                          // color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            // color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Phone Number',
                      style: TextStyle(
                        fontSize: 21,
                        // color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      controller: _phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        prefixIcon: Icon(
                          Icons.phone,
                          // color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    GestureDetector(
                      onTap: _isLoading
                          ? null
                          : _signUp, // Disable button when loading
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.teal,
                              Color(0xFFB2EBF2),
                              // Colors.white,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Text(
                                  'SIGN UP',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                        child: Text(
                      'OR',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(vertical: 16.0),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.g_mobiledata,
                              color: Colors.teal,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Login With Google',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.teal),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            // color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            );
                          },
                          child: Text(
                            " Sign in",
                            style: TextStyle(
                              // color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
