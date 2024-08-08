import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plastic_eliminator/pages/initial_pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:your_app/pages/login_page.dart'; // Replace with your actual login page path

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _soundEnabled = true;
  bool _musicEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _soundEnabled = prefs.getBool('soundEnabled') ?? true;
      _musicEnabled = prefs.getBool('musicEnabled') ?? true;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('soundEnabled', _soundEnabled);
    await prefs.setBool('musicEnabled', _musicEnabled);
  }

  Future<void> _logoutAndGoToLogin(BuildContext context) async {
    try {
      // Sign out the user
      await FirebaseAuth.instance.signOut();

      // Clear all stored data
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      // Navigate to the login page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Login()), // Replace with your actual login page
        (route) => false, // Remove all previous routes
      );
    } catch (e) {
      // Handle errors (e.g., show a dialog or toast)
      print('Error during logout: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Background Music'),
            value: _musicEnabled,
            onChanged: (bool value) {
              setState(() {
                _musicEnabled = value;
              });
              _saveSettings(); // Save setting when toggled
            },
          ),
          Container(
            margin: EdgeInsets.only(left: 8, right: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => _logoutAndGoToLogin(context),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                    onPressed: () => _logoutAndGoToLogin(context),
                    icon: Icon(Icons.logout))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
