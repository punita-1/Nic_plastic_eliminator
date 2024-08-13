// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';

/// Formats a [Timestamp] from Firestore into a string with the format `DD/MM/YYYY`.
///
/// This function converts a [Timestamp] object into a `DateTime` object,
/// extracts the day, month, and year, and then formats it into a string
/// with the format `DD/MM/YYYY`.
///
/// [timestamp] - The [Timestamp] object to be formatted.
///
/// Returns a [String] in the format `DD/MM/YYYY`.
String formatData(Timestamp timestamp) {
  // Convert the Firestore Timestamp to a Dart DateTime object
  DateTime dateTime = timestamp.toDate();

  // Extract the year, month, and day from the DateTime object
  String year = dateTime.year.toString();
  String month = dateTime.month.toString().padLeft(2, '0'); // Ensure two digits
  String day = dateTime.day.toString().padLeft(2, '0'); // Ensure two digits

  // Format the date into the desired string format
  String formattedData = '$day/$month/$year';

  return formattedData;
}
