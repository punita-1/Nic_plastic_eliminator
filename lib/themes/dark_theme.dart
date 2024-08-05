import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(backgroundColor: Colors.black),
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: Colors.grey[900]!,
    secondary: Colors.grey[800]!,
    tertiary: Colors.white,
  ),

  primaryColor:
      Colors.grey[900]!, // This is the blue color for the navigation bar
  scaffoldBackgroundColor: Colors.black, // This is the background color
  iconTheme: IconThemeData(color: Colors.grey[600]), // This sets the icon color
);




// // import 'package:flutter/material.dart';

// // ThemeData darkTheme = ThemeData(
// //   brightness: Brightness.dark,
// //   appBarTheme: AppBarTheme(
// //     backgroundColor: Colors.black,
// //     elevation: 0,
// //     iconTheme: IconThemeData(color: Colors.white),
// //     titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.0),
// //   ),
// //   colorScheme: ColorScheme.dark(
// //     surface: Colors.black,
// //     primary: Colors.grey[800]!,
// //     secondary: Colors.grey[700]!,
// //     onSurface: Colors.white,
// //     error: Colors.red[400]!,
// //   ),
// //   primaryColor: Colors.grey[800]!,
// //   secondaryHeaderColor: Colors.grey[700]!,
// //   elevatedButtonTheme: ElevatedButtonThemeData(
// //     style: ElevatedButton.styleFrom(
// //       foregroundColor: Colors.white,
// //       backgroundColor: Colors.grey[800],
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(20),
// //       ),
// //       padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
// //     ),
// //   ),
// //   textButtonTheme: TextButtonThemeData(
// //     style: TextButton.styleFrom(foregroundColor: Colors.white),
// //   ),
// //   textTheme: TextTheme(
// //     // bodyText2: TextStyle(color: Colors.white, fontSize: 14.0),
// //     // headline5: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
// //   ),
// // );
// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';

// final ThemeData darkTheme = ThemeData(
//   brightness: Brightness.dark,
//   primaryColor: Colors.grey[900],
//   scaffoldBackgroundColor: Colors.grey[850],
//   appBarTheme: AppBarTheme(
//     color: Colors.grey[900],
//     iconTheme: IconThemeData(color: Colors.white), toolbarTextStyle: TextTheme(
//       titleLarge: TextStyle(color: Colors.white, fontSize: 20),
//     ).bodyMedium, titleTextStyle: TextTheme(
//       titleLarge: TextStyle(color: Colors.white, fontSize: 20),
//     ).titleLarge,
//   ),
//   textTheme: TextTheme(
//     bodyLarge: TextStyle(color: Colors.white),
//     bodyMedium: TextStyle(color: Colors.white70),
//     displayLarge: TextStyle(color: Colors.white),
//     titleLarge: TextStyle(color: Colors.white),
//   ),
//   buttonTheme: ButtonThemeData(
//     buttonColor: Colors.tealAccent,
//     textTheme: ButtonTextTheme.primary,
//   ),
//   inputDecorationTheme: InputDecorationTheme(
//     border: OutlineInputBorder(),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: Colors.tealAccent),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: Colors.white70),
//     ),
//   ),
//   iconTheme: IconThemeData(color: Colors.white70),
//   colorScheme: ColorScheme.dark(
//     primary: Colors.grey[900]!,
//     secondary: Colors.tealAccent,
//     surface: Colors.grey[800]!,
//     error: Colors.red[400]!,
//     onPrimary: Colors.white,
//     onSecondary: Colors.black,
//     onSurface: Colors.white,
//     onError: Colors.black,
//     brightness: Brightness.dark,
//   ),
// );
