import 'package:flutter/material.dart';
import 'package:plastic_eliminator/features/Admin/presentation/pages/add_School.dart';
// import 'package:plastic_eliminator/features/Admin/presentation/pages/add_School.dart';
import 'package:plastic_eliminator/features/Admin/presentation/pages/add_event.dart';
import 'package:plastic_eliminator/features/Admin/presentation/pages/add_ngo.dart';
import 'package:plastic_eliminator/features/Admin/presentation/pages/admin_login.dart';
import 'package:plastic_eliminator/features/Admin/presentation/pages/admin_news.dart';
import 'package:plastic_eliminator/features/Admin/presentation/pages/gov_admin.dart';
// import 'package:plastic_eliminator/features/Admin/presentation/pages/learn.dart';
import 'package:plastic_eliminator/features/Admin/presentation/pages/shop_admin.dart';
import 'package:plastic_eliminator/features/Admin/presentation/tiptricksadmin.dart';
import 'package:plastic_eliminator/features/Home/drawer_items/learning_admin.dart'; // Ensure you have this import for navigation

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
        automaticallyImplyLeading: false,
        // leading: Image.asset('Assets/logo_image/logo.png'),
        centerTitle: true,
        title: Text(
          'Admin Home ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEvent()),
                );
              },
              child: Text('Add Event Admin Panel'),
              style: ElevatedButton.styleFrom(
                // primary: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GovWorkAdminPanel()),
                );
              },
              child: Text('Government Initiatives Admin Panel'),
              style: ElevatedButton.styleFrom(
                // primary: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminPanelTips()),
                );
              },
              child: Text('Tips & Tricks Admin Panel'),
              style: ElevatedButton.styleFrom(
                // primary: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminLearningPage()),
                );
              },
              child: Text('Learning Admin Panel'),
              style: ElevatedButton.styleFrom(
                // primary: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminNGOPanel()),
                );
              },
              child: Text('NGO Admin Panel'),
              style: ElevatedButton.styleFrom(
                // primary: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminNewsPanel()),
                );
              },
              child: Text('News Admin Panel'),
              style: ElevatedButton.styleFrom(
                // primary: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddShopPage()), // Navigate to AddShopPage
                );
              },
              child: Text('Add Shop'),
              style: ElevatedButton.styleFrom(
                // primary: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            SizedBox(height: 16.0),
             ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminPanelPage()),
                );
              },
              child: Text('School Admin Panel'),
              style: ElevatedButton.styleFrom(
                // primary: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
