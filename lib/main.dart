// ignore_for_file: use_key_in_widget_constructors, depend_on_referenced_packages

import 'package:plastic_eliminator/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:plastic_eliminator/features/profile_page/local_notifier.dart';
import 'package:plastic_eliminator/core/utils/firebase_auth_utils.dart';
import 'package:plastic_eliminator/features/onboarding/presentation/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plastic_eliminator/core/theme/dark_theme.dart';
import 'package:plastic_eliminator/core/theme/light_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// The entry point of the application.
/// Initializes Firebase and runs the [MyApp] widget.
void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter bindings are initialized
  try {
    await Firebase.initializeApp(); // Initialize Firebase
    await initializeAuth(); // Initialize authentication
  } catch (e) {
    // Handle initialization errors
    // print("Error initializing Firebase: $e");
  }

  runApp(MyApp()); // Run the app
}

/// The main application widget.
///
/// Sets up localization, theming, and the initial screen to be displayed.
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// The locale notifier used to manage and provide the current locale.
  final LocaleNotifier _localeNotifier = LocaleNotifier();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleNotifier>(
            create: (context) =>
                _localeNotifier), // Provides the locale notifier
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) =>
                ThemeProvider()), // Provides the theme provider
      ],
      child: Consumer2<LocaleNotifier, ThemeProvider>(
        builder: (context, localeNotifier, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false, // Hides the debug banner
            title: 'Plastic Eliminator', // App title
            theme: lightTheme, // Light theme
            darkTheme: darkTheme, // Dark theme
            themeMode: themeProvider.themeMode, // Controls theme mode
            localizationsDelegates: const [
              AppLocalizations
                  .delegate, // Localization delegate for app strings
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: localeNotifier.locale, // Current locale
            supportedLocales: const [
              Locale('en'), // Supported locale: English
              Locale('hi'), // Supported locale: Hindi
            ],
            home: SplashScreen(), // Initial screen
          );
        },
      ),
    );
  }
}
