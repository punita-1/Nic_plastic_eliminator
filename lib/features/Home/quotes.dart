import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:async';

/// A widget that displays and rotates through inspiring quotes fetched from Firestore.
///
/// Quotes are rotated every 5 seconds, and users can share the current quote using the share button.
class QuotesWidget extends StatefulWidget {
  @override
  _QuotesWidgetState createState() => _QuotesWidgetState();
}

class _QuotesWidgetState extends State<QuotesWidget> {
  List<String> quotes = []; // List of quotes fetched from Firestore
  int currentIndex = 0; // Index of the currently displayed quote
  Timer? _timer; // Timer for rotating quotes

  @override
  void initState() {
    super.initState();
    fetchQuotes();
  }

  /// Fetches quotes from Firestore and starts the quote rotation.
  Future<void> fetchQuotes() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('quotes').get();
      setState(() {
        quotes = querySnapshot.docs.map((doc) => doc['text'] as String).toList();
        _startQuoteRotation();
      });
    } catch (e) {
      print("Error fetching quotes: $e");
    }
  }

  /// Starts rotating through the quotes every 5 seconds.
  void _startQuoteRotation() {
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (quotes.isNotEmpty) {
        setState(() {
          currentIndex = (currentIndex + 1) % quotes.length;
        });
      }
    });
  }

  /// Shares the given quote using the Share plugin.
  void _shareQuote(String quote) {
    Share.share(quote);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            'Inspiring Quotes', // Heading
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: quotes.isEmpty
                ? CircularProgressIndicator() // Show loading indicator while quotes are being fetched
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          quotes[currentIndex],
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.share, size: 20),
                        onPressed: () => _shareQuote(quotes[currentIndex]),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
