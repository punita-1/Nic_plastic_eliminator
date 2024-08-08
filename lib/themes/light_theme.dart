import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Color(0xFF00ACC1)), // Teal
    titleTextStyle: TextStyle(color: Color(0xFF00ACC1), fontSize: 20), // Teal
  ),
  colorScheme: ColorScheme.light(
    background: Color(0xFFE0F7FA), // Light Aqua
    primary: Colors.white, // Updated color
    secondary: Color(0xFF00ACC1), // Teal
    tertiary: Color(0xFFB2EBF2), // Pale Blue
    surface: Colors.white,
    onPrimary: Color(0xFF00ACC1), // Teal
    onSecondary: Colors.white,
    onSurface: Color(0xFF00ACC1), // Teal
    onBackground: Color(0xFF00ACC1), // Teal
    onError: Colors.white,
  ),
  primaryColor: Colors.white, // Updated color
  scaffoldBackgroundColor: Color(0xFFE0F7FA), // Light Aqua
  iconTheme: IconThemeData(color: Color(0xFF00ACC1)), // Teal
  textTheme: TextTheme(
    bodyLarge: TextStyle(
        color: Color(0xFF00ACC1), fontWeight: FontWeight.bold), // Teal
    bodyMedium: TextStyle(color: Color(0xFF00ACC1)), // Teal
    bodySmall: TextStyle(color: Color(0xFF00ACC1)), // Teal
    displayLarge: TextStyle(color: Color(0xFF00ACC1)), // Teal
    titleLarge: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), // Teal
    labelLarge: TextStyle(color: Color(0xFF00ACC1)), // Teal
    headlineLarge: TextStyle(color: Color(0xFF00ACC1)), // Teal
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.white, // Updated color
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
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white, // Updated color
    selectedItemColor: Color(0xFF00ACC1), // Teal
    unselectedItemColor: Colors.grey[600],
    showSelectedLabels: true,
    showUnselectedLabels: true,
  ),
);
