import 'package:flutter/material.dart';
import 'package:plastic_eliminator/navigation/bottomnav.dart';
import 'package:plastic_eliminator/features/auth/presentation/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A StatefulWidget that handles user login and authentication.
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email, password;
  bool _isLoading = false; // Indicates whether the login process is ongoing.

  // Controllers for the email and password fields
  final TextEditingController gmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Key for form validation
  bool _obscureText = true; // Controls the visibility of the password

  /// Handles user login using Firebase Authentication.
  Future<void> userLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        email = gmailController.text;
        password = passwordController.text;
        _isLoading = true; // Start loading state
      });

      try {
        // Sign in the user with Firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email!, password: password!);

        if (userCredential.user != null) {
          // Save login state and user email in SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('userEmail', email!);

          // Navigate to the main screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Bottomnav()),
          );
        }
      } catch (e) {
        // Show an error message if login fails
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          'An error occurred: ${e.toString()}',
          style: const TextStyle(fontSize: 20.0),
        )));
      } finally {
        setState(() {
          _isLoading = false; // Stop loading state
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient container
          Container(
            padding: const EdgeInsets.only(top: 50.0, left: 20.0),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.teal,
              Color(0xFFB2EBF2),
            ])),
            child:  Text(
              'Hello,\nSign in!',
               style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          // Login form container
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(
                  top: 25, left: 30, right: 30, bottom: 20),
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 5.5),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   const SizedBox(height: 20),
                    // Email input field
                    Text('Gmail', style: Theme.of(context).textTheme.bodyLarge),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      controller: gmailController,
                      decoration: const InputDecoration(
                          hintText: 'Gmail',
                          prefixIcon: Icon(
                            Icons.mail_outline,
                          )),
                    ),
                    const SizedBox(height: 15),
                    // Password input field
                    Text(
                      'Password',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid password';
                          }
                          return null;
                        },
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: const Icon(
                            Icons.password_outlined,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscureText),
                    const SizedBox(height: 15),
                    // Forgot password link
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot password?',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50.0),
                    // Sign in button
                    GestureDetector(
                      onTap: () {
                        userLogin();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Colors.teal,
                              Color(0xFFB2EBF2),
                            ]),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : const Text(
                                  'SIGN IN',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Sign up link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                              // color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Signup()));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                " Sign up",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
