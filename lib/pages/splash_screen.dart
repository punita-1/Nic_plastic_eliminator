// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:plastic_eliminator/pages/onboarding.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _navigateToOnboarding();
//   }

//   _navigateToOnboarding() async {
//     await Future.delayed(const Duration(seconds: 3), () {});
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => OnboardingScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF6F1F1),
//       body: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: Image.asset('Assets/images/logo_splash.png',
//                   // 'Assets/images/Onboarding_noBG.png',
//                   width: 200,
//                   height: 200),
//             ),
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Plastic',
//                   style: TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xff7469B6)),
//                 ),
//                 const Text(
//                   'Eliminator',
//                   style: TextStyle(
//                       color: Color(0xffAD88C6),
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:plastic_eliminator/pages/onboarding.dart';
// import 'package:plastic_eliminator/pages/bottomnav.dart'; // Home screen

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _checkLoginStatus();
//   }

//   Future<void> _checkLoginStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

//     // Navigate to the appropriate screen after a delay
//     Future.delayed(Duration(seconds: 2), () {
//       if (isLoggedIn) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => Bottomnav()),
//         );
//       } else {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => OnboardingScreen()),
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plastic_eliminator/pages/onboarding.dart';
import 'package:plastic_eliminator/pages/bottomnav.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Navigate to the appropriate screen after a delay
    Future.delayed(Duration(seconds: 2), () {
      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Bottomnav()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
