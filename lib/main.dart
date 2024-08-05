// import 'package:flutter/material.dart';
// import 'package:plastic_eliminator/Admin/admin_login.dart';
// import 'package:plastic_eliminator/Admin/home_admin.dart';
// import 'package:plastic_eliminator/services/firebase_auth_utils.dart';
// import 'package:plastic_eliminator/pages/initial_pages/splash_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:plastic_eliminator/themes/dark_theme.dart';
// import 'package:plastic_eliminator/themes/light_theme.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_localizations/flutter_localizations.dart'; // Correct import

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     await Firebase.initializeApp();
//     await initializeAuth(); // Initialize authentication
//   } catch (e) {
//     // Handle initialization errors here
//     print("Error initializing Firebase: $e");
//   }
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Plastic Eliminator',
//       theme: lightTheme,
//       darkTheme: darkTheme,
//       localizationsDelegates: [
//         AppLocalizations.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       locale: Locale('hi'),
//       supportedLocales: [
//         Locale('en'),
//         Locale('hi'),
//       ],
//       home: SplashScreen(),
//       // home: AdminLogin()
//     );
//   }
// }
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:plastic_eliminator/Admin/admin_login.dart';
import 'package:plastic_eliminator/Admin/home_admin.dart';
import 'package:plastic_eliminator/local_notifier.dart';
import 'package:plastic_eliminator/services/firebase_auth_utils.dart';
import 'package:plastic_eliminator/pages/initial_pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plastic_eliminator/themes/dark_theme.dart';
import 'package:plastic_eliminator/themes/light_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'locale_notifier.dart'; // Import the LocaleNotifier

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    await initializeAuth(); // Initialize authentication
  } catch (e) {
    // Handle initialization errors here
    print("Error initializing Firebase: $e");
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LocaleNotifier _localeNotifier = LocaleNotifier();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocaleNotifier>(
      create: (context) => _localeNotifier,
      child: Consumer<LocaleNotifier>(
        builder: (context, localeNotifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Plastic Eliminator',
            theme: lightTheme,
            darkTheme: darkTheme,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: localeNotifier.locale,
            supportedLocales: [
              Locale('en'),
              Locale('hi'),
            ],
            home: SplashScreen(),
            // home: AdminLogin()
          );
        },
      ),
    );
  }
}
