// ignore_for_file: use_build_context_synchronously, use_super_parameters
// ignore_for_file: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plastic_eliminator/features/auth/presentation/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A page that allows users to configure app settings, including sound and music preferences.
/// It also provides login/logout functionality based on the user's authentication status.
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _soundEnabled = true;
  bool _musicEnabled = true;
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _getCurrentUser();
  }

  /// Loads the user's settings from [SharedPreferences] and updates the state.
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _soundEnabled = prefs.getBool('soundEnabled') ?? true;
      _musicEnabled = prefs.getBool('musicEnabled') ?? true;
    });
  }

  /// Gets the currently logged-in user, if any.
  void _getCurrentUser() {
    setState(() {
      _currentUser = FirebaseAuth.instance.currentUser;
    });
  }

  /// Saves the current settings to [SharedPreferences].
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('soundEnabled', _soundEnabled);
    await prefs.setBool('musicEnabled', _musicEnabled);
  }

  /// Signs out the user, clears all stored data, and navigates to the login page.
  Future<void> _logoutAndGoToLogin(BuildContext context) async {
    try {
      // Sign out the user from Firebase
      await FirebaseAuth.instance.signOut();

      // Clear all stored data in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      // Update UI after logout
      setState(() {
        _currentUser = null;
      });

      // Navigate to the login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } catch (e) {
      // Handle errors by showing a dialog or toast
      // print('Error during logout: $e');
      // Consider showing an error message to the user here
    }
  }

  /// Navigates the user to the login page.
  Future<void> _goToLoginPage(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    ).then((_) =>
        _getCurrentUser()); // Refresh user status after returning from login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          // Switch for enabling/disabling background music
          SwitchListTile(
            title: const Text('Background Music'),
            value: _musicEnabled,
            onChanged: (bool value) {
              setState(() {
                _musicEnabled = value;
              });
              _saveSettings(); // Save setting when toggled
            },
          ),
          // Conditional rendering of login/logout buttons
          if (_currentUser == null)
            _buildLoginButton(context)
          else
            _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () => _goToLoginPage(context),
            child: const Text(
              'Login',
              style: TextStyle(
                color: Colors.teal,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () => _goToLoginPage(context),
              icon: const Icon(Icons.login),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () => _logoutAndGoToLogin(context),
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.teal,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () => _logoutAndGoToLogin(context),
              icon: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
    );
  }
}
