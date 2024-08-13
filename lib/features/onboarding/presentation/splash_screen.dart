// ignore_for_file: use_key_in_widget_constructors
// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plastic_eliminator/features/onboarding/presentation/onboarding.dart';
import 'package:plastic_eliminator/navigation/bottomnav.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Check login status when the widget is initialized
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Retrieve instance of SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if user is logged in
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Delay for 4 seconds to show splash screen
    Future.delayed(Duration(seconds: 4), () {
      // Navigate to the appropriate screen based on login status
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => isLoggedIn ? Bottomnav() : OnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display logo image
            Image.asset(
              'Assets/all_images/nic_logo.png',
              width: 200,
              height: 200,
            ),
            Image.asset(
              'Assets/onboard_images/onboard1.png',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            // Show a loading indicator
            CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onSurface),
            SizedBox(height: 20),
            // Display app name
            Text(
              'Plastic Eliminator',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
