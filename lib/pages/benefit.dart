import 'package:flutter/material.dart';

class Benefits_detailePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> benefits = [
      {
        'title': 'Healthier Oceans',
        'description': 'Reduced plastic pollution leads to cleaner and healthier oceans, benefiting marine life.',
      },
      {
        'title': 'Wildlife Protection',
        'description': 'Decreased plastic waste helps protect wildlife from ingestion and entanglement.',
      },
      {
        'title': 'Reduced Carbon Footprint',
        'description': 'Using sustainable alternatives reduces the carbon footprint associated with plastic production.',
      },
      {
        'title': 'Cleaner Beaches',
        'description': 'Less plastic waste means cleaner, more enjoyable beaches for everyone.',
      },
      {
        'title': 'Economic Benefits',
        'description': 'Less plastic waste can reduce cleanup costs and create green jobs.',
      },
      {
        'title': 'Improved Human Health',
        'description': 'Reducing plastic use can decrease exposure to harmful chemicals found in plastics.',
      },
      {
        'title': 'Enhanced Tourism',
        'description': 'Cleaner environments can boost tourism and local economies.',
      },
      {
        'title': 'Sustainable Future',
        'description': 'Promoting sustainable practices ensures a healthier planet for future generations.',
      },
      {
        'title': 'Resource Conservation',
        'description': 'Using alternatives to plastic conserves natural resources and reduces waste.',
      },
      {
        'title': 'Positive Community Impact',
        'description': 'Communities can benefit from cleaner, healthier environments and increased environmental awareness.',
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
        title: Text('Benefits of Plastic Eradication'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: benefits.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            color: colors[index % colors.length], // Use a color from the list
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              title: Text(
                benefits[index]['title']!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              subtitle: Text(
                benefits[index]['description']!,
                style: TextStyle(color: Colors.black54),
              ),
            ),
          );
        },
      ),
    );
  }
}
