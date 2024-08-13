// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plastic_eliminator/features/Admin/presentation/pages/home_admin.dart';
import 'package:plastic_eliminator/features/auth/presentation/login.dart';

/// A stateful widget that provides an admin login interface.
/// 
/// The [AdminLogin] widget allows administrators to log in using their
/// username and password. Upon successful authentication, it navigates
/// to the [HomeAdmin] page. If authentication fails, an error message is shown.
class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  /// Whether the password is obscured in the password field.
  bool _obscureText = true;

  /// Whether the app is currently loading (e.g., during authentication).
  bool _isLoading = false;

  /// Controller for the admin username text field.
  TextEditingController Admin_nameController = TextEditingController();

  /// Controller for the admin password text field.
  TextEditingController Admin_passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(context),
          _buildLoginForm(context),
        ],
      ),
    );
  }

  /// Builds the background gradient and title text.
  Widget _buildBackground(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50.0, left: 20.0),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.teal,
            Color(0xFFB2EBF2),
          ],
        ),
      ),
      child: Text(
        'Admin\nLogin!',
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Builds the login form with username and password fields.
  Widget _buildLoginForm(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 25,
          left: 30,
          right: 30,
          bottom: 20,
        ),
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 5.5,
        ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Icon(Icons.arrow_upward)),
              SizedBox(height: 10),
              _buildUsernameField(),
              SizedBox(height: 15.0),
              _buildPasswordField(),
              SizedBox(height: 50.0),
              _buildLoginButton(),
              SizedBox(height: 20),
              _buildSwitchToUserLoginButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the username input field.
  Widget _buildUsernameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Username',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a Name';
            }
            return null;
          },
          controller: Admin_nameController,
          decoration: InputDecoration(
            hintText: 'Name',
            prefixIcon: Icon(Icons.person),
          ),
        ),
      ],
    );
  }

  /// Builds the password input field with an option to show/hide the password.
  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextFormField(
          controller: Admin_passwordController,
          decoration: InputDecoration(
            hintText: 'Password',
            prefixIcon: Icon(Icons.password_outlined),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
          obscureText: _obscureText,
        ),
      ],
    );
  }

  /// Builds the login button which triggers the [LoginAdmin] method when pressed.
  Widget _buildLoginButton() {
    return GestureDetector(
      onTap: _isLoading ? null : () => LoginAdmin(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal,
              Color(0xFFB2EBF2),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: _isLoading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }

  /// Builds the button to switch to the user login page.
  Widget _buildSwitchToUserLoginButton() {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        },
        child: Text(
          'Are you a user?',
          style: TextStyle(color: Colors.teal),
        ),
      ),
    );
  }

  /// Handles admin login by checking the credentials against Firestore.
  ///
  /// If the username and password match a record in the "Admin" collection,
  /// the user is navigated to the [HomeAdmin] page. Otherwise, an error
  /// message is shown.
  void LoginAdmin() async {
    setState(() {
      _isLoading = true;
    });

    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection("Admin").get();
      bool isAuthenticated = false;

      for (var result in snapshot.docs) {
        var data = result.data() as Map<String, dynamic>?;
        if (data != null &&
            data['username'] == Admin_nameController.text.trim() &&
            data['password'] == Admin_passwordController.text.trim()) {
          isAuthenticated = true;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeAdmin()),
          );
          break;
        }
      }

      if (!isAuthenticated) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Your username or password is not correct',
            style: TextStyle(fontSize: 20.0),
          ),
        ));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Error: $error',
          style: TextStyle(fontSize: 20.0),
        ),
      ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
