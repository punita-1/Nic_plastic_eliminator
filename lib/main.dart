import 'package:flutter/material.dart';
import 'package:plastic_eliminator/Admin/add_event.dart';
import 'package:plastic_eliminator/Admin/admin_login.dart';
import 'package:plastic_eliminator/firebase_auth_utils.dart';
import 'package:plastic_eliminator/pages/bottomnav.dart';
import 'package:plastic_eliminator/pages/challenges.dart';
import 'package:plastic_eliminator/pages/home.dart';
import 'package:plastic_eliminator/pages/login.dart';
import 'package:plastic_eliminator/pages/onboarding.dart';
import 'package:plastic_eliminator/pages/signup.dart';
import 'package:plastic_eliminator/pages/splash_screen.dart'; // Import the splash screen
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await refreshAuthStateAfterDeletion();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: SplashScreen(),
      // home: AdminLogin(),
      // home: AddEvent(),
    );
  }
}
