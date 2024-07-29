

import 'package:flutter/material.dart';

class Products_usedetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> alternatives = [
      {
        'title': 'Reusable Bags',
        'description': 'Use reusable cloth bags instead of plastic bags.',
      },
      {
        'title': 'Stainless Steel Bottles',
        'description': 'Opt for stainless steel bottles over plastic ones.',
      },
      {
        'title': 'Bamboo Toothbrushes',
        'description': 'Switch to bamboo toothbrushes instead of plastic ones.',
      },
      {
        'title': 'Glass Containers',
        'description': 'Use glass containers for storage rather than plastic ones.',
      },
      {
        'title': 'Beeswax Wraps',
        'description': 'Use beeswax wraps instead of plastic wrap.',
      },
      {
        'title': 'Metal Straws',
        'description': 'Choose metal straws over single-use plastic straws.',
      },
      {
        'title': 'Silicone Food Covers',
        'description': 'Use silicone food covers instead of plastic ones.',
      },
      {
        'title': 'Compostable Cutlery',
        'description': 'Opt for compostable cutlery instead of plastic utensils.',
      },
      {
        'title': 'Fabric Napkins',
        'description': 'Use fabric napkins instead of paper ones.',
      },
      {
        'title': 'Wooden Toys',
        'description': 'Choose wooden toys over plastic ones.',
      },
    ];

    // Define a list of pastel colors
    final List<Color> colors = [
      Color(0xFFB3E5FC), // Light Blue
      Color(0xFFC8E6C9), // Light Green
      Color(0xFFFFF9C4), // Light Yellow
      Color(0xFFFFAB91), // Light Orange
      Color(0xFFE1BEE7), // Light Purple
      Color(0xFFE0F2F1), // Light Teal
      Color(0xFFFFF59D), // Light Lime
      Color(0xFFCFD8DC), // Light Grey
      Color(0xFFB9FBC0), // Light Mint
      Color(0xFFFFF8E1), // Light Cream
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Sustainable Alternatives'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: alternatives.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            color: colors[index % colors.length], // Apply pastel colors
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              title: Text(
                alternatives[index]['title']!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              subtitle: Text(
                alternatives[index]['description']!,
                style: TextStyle(color: Colors.black54),
              ),
            ),
          );
        },
      ),
    );
  }
}
