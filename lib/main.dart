// import 'package:provider/provider.dart';
// import 'package:flutter/material.dart';
// import 'package:plastic_eliminator/local_notifier.dart';
// import 'package:plastic_eliminator/services/firebase_auth_utils.dart';
// import 'package:plastic_eliminator/pages/initial_pages/splash_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:plastic_eliminator/themes/dark_theme.dart';
// import 'package:plastic_eliminator/themes/light_theme.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     await Firebase.initializeApp();
//     await initializeAuth(); // Initialize authentication
//   } catch (e) {
//     // Handle initialization errors here
//     print("Error initializing Firebase: $e");
//   }

//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final LocaleNotifier _localeNotifier = LocaleNotifier();

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<LocaleNotifier>(
//       create: (context) => _localeNotifier,
//       child: Consumer<LocaleNotifier>(
//         builder: (context, localeNotifier, child) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: 'Plastic Eliminator',
//             theme: lightTheme,
//             darkTheme: darkTheme,
//             localizationsDelegates: [
//               AppLocalizations.delegate,
//               GlobalMaterialLocalizations.delegate,
//               GlobalWidgetsLocalizations.delegate,
//               GlobalCupertinoLocalizations.delegate,
//             ],
//             locale: localeNotifier.locale,
//             supportedLocales: [
//               Locale('en'),
//               Locale('hi'),
//             ],
//             home: SplashScreen(),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:plastic_eliminator/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:plastic_eliminator/local_notifier.dart';
import 'package:plastic_eliminator/services/firebase_auth_utils.dart';
import 'package:plastic_eliminator/pages/initial_pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plastic_eliminator/themes/dark_theme.dart';
import 'package:plastic_eliminator/themes/light_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'theme_provider.dart'; // Import the ThemeProvider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
    // Ensure all necessary initializations are completed
    await initializeAuth(); 
 
  
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleNotifier>(create: (context) => _localeNotifier),
        ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider()),
      ],
      child: Consumer2<LocaleNotifier, ThemeProvider>(
        builder: (context, localeNotifier, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Plastic Eliminator',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeProvider.themeMode,
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
          );
        },
      ),
    );
  }
}
