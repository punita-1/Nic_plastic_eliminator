import 'package:flutter/material.dart';

class RecyclingDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define a list of pastel colors
    final List<Color> pastelColors = [
      Color(0xFFB3E5FC), // Light Blue
      Color(0xFFC8E6C9), // Light Green
      Color(0xFFFFF9C4), // Light Yellow
      Color(0xFFFFAB91), // Light Orange
      Color(0xFFE1BEE7), // Light Purple
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Recycling Details'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              // Handle info icon press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  height: 200,
                  width: 200,
                  child: Image.asset(
                    'Assets/images/recycle.png', // Replace with your image asset
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
                'Recycling Guide',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Learn how to properly recycle different materials and reduce your environmental impact.',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            _buildInfoCard(
              context,
              title: 'Plastic',
              description: 'Separate plastics by type and ensure they are clean and dry.',
              icon: Icons.recycling,
              color: pastelColors[0], // Light Blue
            ),
            _buildInfoCard(
              context,
              title: 'Paper',
              description: 'Remove any staples or tapes before recycling paper products.',
              icon: Icons.article,
              color: pastelColors[1], // Light Green
            ),
            _buildInfoCard(
              context,
              title: 'Glass',
              description: 'Sort glass by color and avoid mixing with other materials.',
              icon: Icons.wine_bar,
              color: pastelColors[2], // Light Yellow
            ),
            _buildInfoCard(
              context,
              title: 'Metal',
              description: 'Rinse metal cans and containers before recycling.',
              icon: Icons.kitchen,
              color: pastelColors[3], // Light Orange
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
                  backgroundColor: Color(0xFFE1BEE7),
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                  textStyle: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, {required String title, required String description, required IconData icon, required Color color}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 5.0,
      color: color, // Apply pastel colors
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40.0, color: Colors.purple),
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
