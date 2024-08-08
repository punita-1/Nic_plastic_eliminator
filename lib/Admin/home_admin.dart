import 'package:flutter/material.dart';
import 'package:plastic_eliminator/Admin/add_event.dart';
import 'package:plastic_eliminator/Admin/admin_login.dart'; // Ensure you have this import for navigation

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  void _logout() {
    // Implement your logout logic here, for example:
    // Clear user session, tokens, etc.

    // Navigate back to the login screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => AdminLogin()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('Assets/logo_image/logo.png'),
        centerTitle: true,
        title: Text(
          'Admin Home',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20, left: 20),
        child: TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddEvent()));
          },
          child: Text(
            'Add Event',
            style: TextStyle(color: Colors.teal,fontSize: 20),
          ),
        ),
      ),
    );
  }
}
