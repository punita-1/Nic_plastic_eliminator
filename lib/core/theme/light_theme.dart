import 'package:flutter/material.dart';

/// Defines the light theme for the application.
///
/// This theme is applied when the app is using the light mode. It sets
/// various colors and styles for app components such as AppBar, buttons,
/// and input fields.
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Color(0xFF00ACC1)), // Teal
    titleTextStyle: TextStyle(
      color: Color(0xFF00ACC1), // Teal
      fontSize: 20,
    ),
  ),
  colorScheme: ColorScheme.light(
    background: Color(0xFFE0F7FA), // Light Aqua
    primary: Colors.white, // Background color of primary widgets
    secondary: Color(0xFF00ACC1), // Teal
    tertiary: Color(0xFFB2EBF2), // Pale Blue
    surface: Colors.white,
    onPrimary: Color(0xFF00ACC1), // Teal
    onSecondary: Colors.white,
    onSurface: Color(0xFF00ACC1), // Teal
    onBackground: Color(0xFF00ACC1), // Teal
    onError: Colors.white,
  ),
  primaryColor: Colors.white, // Background color for primary components
  scaffoldBackgroundColor: Color(0xFFE0F7FA), // Light Aqua
  iconTheme: IconThemeData(color: Color(0xFF00ACC1)), // Teal
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: Color(0xFF00ACC1), // Teal
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(color: Color(0xFF00ACC1)), // Teal
    bodySmall: TextStyle(color: Color(0xFF00ACC1)), // Teal
    displayLarge: TextStyle(color: Color(0xFF00ACC1)), // Teal
    titleLarge: TextStyle(
      color: Colors.white, // Text color for large titles
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    labelLarge: TextStyle(color: Color(0xFF00ACC1)), // Teal
    headlineLarge: TextStyle(color: Color(0xFF00ACC1)), // Teal
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.white, // Background color for buttons
    textTheme: ButtonTextTheme.primary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF00ACC1)), // Teal
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black54),
    ),
    isDense: true,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black, // Set the cursor color to black
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white, // Background color for bottom navigation
    selectedItemColor: Color(0xFF00ACC1), // Teal
    unselectedItemColor: Colors.grey[600],
    showSelectedLabels: true,
    showUnselectedLabels: true,
  ),

  // Add theme for ElevatedButton with curved corners and custom text style
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStatePropertyAll(EdgeInsetsDirectional.only(top: 15, bottom: 15, end: 20, start: 20)),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      foregroundColor: MaterialStateProperty.all<Color>(
          Color(0xFF00ACC1)), // Teal text color
      textStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(
          fontWeight: FontWeight.bold, // Bold text
          fontSize: 20, // Font size 20
        ),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Set the curve radius to 8
        ),
      ),
    ),
  ),
);
