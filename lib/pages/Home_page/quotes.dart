import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:async';

class QuotesWidget extends StatefulWidget {
  @override
  _QuotesWidgetState createState() => _QuotesWidgetState();
}

class _QuotesWidgetState extends State<QuotesWidget> {
  List<String> quotes = [];
  int currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchQuotes();
  }

  Future<void> fetchQuotes() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('quotes').get();
      setState(() {
        quotes =
            querySnapshot.docs.map((doc) => doc['text'] as String).toList();
        _startQuoteRotation();
      });
    } catch (e) {
      print("Error fetching quotes: $e");
    }
  }

  void _startQuoteRotation() {
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (quotes.isNotEmpty) {
        setState(() {
          currentIndex = (currentIndex + 1) % quotes.length;
        });
      }
    });
  }

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
          padding: const EdgeInsets.only(top: 10),
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
                ? CircularProgressIndicator()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        quotes[currentIndex],
                        style: TextStyle(fontWeight: FontWeight.bold
                            // , fontSize: 18.0
                            ),
                        textAlign: TextAlign.center,
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
