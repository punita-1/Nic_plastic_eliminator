import 'package:flutter/material.dart';

class SustainableAlternativesDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          'Sustainable Alternatives',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  height: 150,
                  width: 150,
                  child: Image.asset(
                    'Assets/images/ecology.png', // Replace with your image asset
                    height: 200.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Sustainable Alternatives',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Explore eco-friendly alternatives to common products and practices.',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            _buildInfoCard(
              context,
              title: 'Reusable Bags',
              description: 'Switch to reusable bags to reduce plastic waste.',
              icon: Icons.shopping_bag,
              color: colors[0], // Light Blue
            ),
            _buildInfoCard(
              context,
              title: 'Eco-friendly Packaging',
              description:
                  'Choose biodegradable or compostable packaging options.',
              icon: Icons.local_shipping,
              color: colors[1], // Light Green
            ),
            _buildInfoCard(
              context,
              title: 'Sustainable Fashion',
              description: 'Opt for clothing made from sustainable materials.',
              icon: Icons.checkroom,
              color: colors[2], // Light Yellow
            ),
            _buildInfoCard(
              context,
              title: 'Renewable Energy',
              description:
                  'Explore solar, wind, and other renewable energy sources.',
              icon: Icons.wb_sunny,
              color: colors[3], // Light Orange
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                child: Text('Learn More'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // Button color
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                  textStyle: TextStyle(fontSize: 18.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8.0), // Adjust this value for less curve
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context,
      {required String title,
      required String description,
      required IconData icon,
      required Color color}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 5.0,
      color: color, // Apply pastel colors
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40.0, color: Colors.black),
            SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
