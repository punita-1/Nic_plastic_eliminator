import 'package:flutter/material.dart';

class Benefits_detailePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> benefits = [
      {
        'title': 'Healthier Oceans',
        'description':
            'Reduced plastic pollution leads to cleaner and healthier oceans, benefiting marine life.',
      },
      {
        'title': 'Wildlife Protection',
        'description':
            'Decreased plastic waste helps protect wildlife from ingestion and entanglement.',
      },
      {
        'title': 'Reduced Carbon Footprint',
        'description':
            'Using sustainable alternatives reduces the carbon footprint associated with plastic production.',
      },
      {
        'title': 'Cleaner Beaches',
        'description':
            'Less plastic waste means cleaner, more enjoyable beaches for everyone.',
      },
      {
        'title': 'Economic Benefits',
        'description':
            'Less plastic waste can reduce cleanup costs and create green jobs.',
      },
      {
        'title': 'Improved Human Health',
        'description':
            'Reducing plastic use can decrease exposure to harmful chemicals found in plastics.',
      },
      {
        'title': 'Enhanced Tourism',
        'description':
            'Cleaner environments can boost tourism and local economies.',
      },
      {
        'title': 'Sustainable Future',
        'description':
            'Promoting sustainable practices ensures a healthier planet for future generations.',
      },
      {
        'title': 'Resource Conservation',
        'description':
            'Using alternatives to plastic conserves natural resources and reduces waste.',
      },
      {
        'title': 'Positive Community Impact',
        'description':
            'Communities can benefit from cleaner, healthier environments and increased environmental awareness.',
      },
    ];

    // Define a list of pastel colors
    final List<Color> colors = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.teal[100]!,
        title: Text(
          'Benefits',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
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
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
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
