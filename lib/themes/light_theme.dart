import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.black)),
  colorScheme: ColorScheme.light(
      background: Colors.grey[300]!,
      primary: Colors.grey[200]!,
      secondary: Colors.grey[400]!,
      tertiary: Colors.black),

  primaryColor:
      Colors.grey[200]!, // This is the blue color for the navigation bar
  scaffoldBackgroundColor: Colors.grey[300], // This is the background color
  iconTheme: IconThemeData(color: Colors.grey[600]), // This sets the icon color
);








// import 'package:flutter/material.dart';

// final ThemeData lightTheme = ThemeData(
//   brightness: Brightness.light,
//   primaryColor: Colors.blue,
//   scaffoldBackgroundColor: Colors.white,
//   appBarTheme: AppBarTheme(
//     color: Colors.blue,
//     iconTheme: IconThemeData(color: Colors.white), toolbarTextStyle: TextTheme(
//       titleLarge: TextStyle(color: Colors.white, fontSize: 20),
//     ).bodyMedium, titleTextStyle: TextTheme(
//       titleLarge: TextStyle(color: Colors.white, fontSize: 20),
//     ).titleLarge,
//   ),
//   textTheme: TextTheme(
//     bodyLarge: TextStyle(color: Colors.black),
//     bodyMedium: TextStyle(color: Colors.black54),
//     displayLarge: TextStyle(color: Colors.black),
//     titleLarge: TextStyle(color: Colors.black),
//   ),
//   buttonTheme: ButtonThemeData(
//     buttonColor: Colors.blue,
//     textTheme: ButtonTextTheme.primary,
//   ),
//   inputDecorationTheme: InputDecorationTheme(
//     border: OutlineInputBorder(),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: Colors.blue),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: Colors.black54),
//     ),
//   ),
//   iconTheme: IconThemeData(color: Colors.black54),
//    colorScheme: ColorScheme.light(
//     primary: Colors.blue,
//     secondary: Colors.blueAccent,
//     surface: Colors.white,
//     error: Colors.red,
//     onPrimary: Colors.white,
//     onSecondary: Colors.white,
//     onSurface: Colors.black,
//     onError: Colors.white,
//     brightness: Brightness.light,
//   ),
// );

