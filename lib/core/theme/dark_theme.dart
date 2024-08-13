// import 'package:flutter/material.dart';

// /// Defines the dark theme for the application.
// ///
// /// This theme is applied when the app is using the dark mode. It sets
// /// various colors and styles for app components such as AppBar, buttons,
// /// and input fields.
// ThemeData darkTheme = ThemeData(
//   brightness: Brightness.dark,

//   /// AppBar theme settings
//   appBarTheme: AppBarTheme(
//     backgroundColor: Colors.black, // Background color for the AppBar
//   ),

//   /// Color scheme for the dark theme
//   colorScheme: ColorScheme.dark(
//     background: Colors.black, // Background color for the app
//     primary: Colors.grey[900]!, // Primary color for components
//     secondary: Colors.grey[800]!, // Secondary color for components
//     tertiary: Colors.white, // Color for tertiary elements
//   ),

//   /// Primary color for app elements
//   primaryColor: Colors.grey[900]!, // Used in components like navigation bars

//   /// Background color for scaffold components
//   scaffoldBackgroundColor: Colors.black, // Background color for the main layout

//   /// Icon theme settings
//   iconTheme: IconThemeData(
//     color: Colors.grey[600], // Color for icons
//   ),
// );
import 'package:flutter/material.dart';

/// Defines the dark theme for the application.
///
/// This theme is applied when the app is using the dark mode. It sets
/// various colors and styles for app components such as AppBar, buttons,
/// and input fields.
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,

  /// AppBar theme settings
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent, // Background color for the AppBar
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.teal[200]!), // Teal for dark mode
    titleTextStyle: TextStyle(
      color: Colors.teal[200]!, // Teal for dark mode
      fontSize: 20,
    ),
  ),

  /// Color scheme for the dark theme
  colorScheme: ColorScheme.dark(
    background: Colors.black, // Background color for the app
    primary: Colors.grey[900]!, // Primary color for components
    secondary: Colors.teal[200]!, // Teal for dark mode
    tertiary: Colors.grey[800]!, // Darker shade for tertiary elements
    surface: Colors.grey[900]!,
    onPrimary: Colors.teal[200]!, // Teal for dark mode
    onSecondary: Colors.white,
    onSurface: Colors.teal[200]!, // Teal for dark mode
    onBackground: Colors.teal[200]!, // Teal for dark mode
    onError: Colors.white,
  ),

  /// Primary color for app elements
  primaryColor: Colors.grey[900]!, // Used in components like navigation bars

  /// Background color for scaffold components
  scaffoldBackgroundColor: Colors.black, // Background color for the main layout

  /// Icon theme settings
  iconTheme: IconThemeData(
    color: Colors.teal[200]!, // Teal for icons in dark mode
  ),

  /// Text theme settings
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: Colors.teal[200]!, // Teal for dark mode
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(color: Colors.teal[200]!), // Teal for dark mode
    bodySmall: TextStyle(color: Colors.teal[200]!), // Teal for dark mode
    displayLarge: TextStyle(color: Colors.teal[200]!), // Teal for dark mode
    titleLarge: TextStyle(
      color: Colors.white, // White text color for large titles
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    labelLarge: TextStyle(color: Colors.teal[200]!), // Teal for dark mode
    headlineLarge: TextStyle(color: Colors.teal[200]!), // Teal for dark mode
  ),

  /// Button theme settings
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.grey[900]!, // Dark grey for button backgrounds
    textTheme: ButtonTextTheme.primary,
  ),

  /// Input decoration theme settings
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.teal[200]!), // Teal for dark mode
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[600]!),
    ),
  ),

  /// Bottom navigation bar theme settings
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.grey[900]!, // Dark grey for background
    selectedItemColor: Colors.teal[200]!, // Teal for selected item
    unselectedItemColor: Colors.grey[600],
    showSelectedLabels: true,
    showUnselectedLabels: true,
  ),

  /// Text selection theme settings
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white, // White cursor in dark mode
  ),
);
