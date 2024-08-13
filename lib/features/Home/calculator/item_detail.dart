import 'package:flutter/material.dart';
import 'package:plastic_eliminator/features/map/presentation/mapnerby.dart';

class ItemDetailPage extends StatelessWidget {
  final String item;
  final int quantity;

  const ItemDetailPage({super.key, required this.item, required this.quantity});

  @override
  Widget build(BuildContext context) {
    // Example data for degradation time, pollution, and alternatives
    final Map<String, Map<String, dynamic>> itemData = {
      'Toothbrush': {
        'degradationTime': 500, // in years
        'pollution': 0.1, // pollution units per item
        'alternatives': [
          'Bamboo Toothbrush',
          'Electric Toothbrush',
        ],
      },
      'Comb': {
        'degradationTime': 300, // in years
        'pollution': 0.05, // pollution units per item
        'alternatives': [
          'Wooden Comb',
          'Metal Comb',
        ],
      },
      'Disposable Dishes': {
        'degradationTime': 100, // in years
        'pollution': 0.15, // pollution units per item
        'alternatives': [
          'Reusable Plates',
          'Biodegradable Dishes',
        ],
      },
      'Plastic Bags': {
        'degradationTime': 1000, // in years
        'pollution': 0.2, // pollution units per item
        'alternatives': [
          'Reusable Bags',
          'Paper Bags',
        ],
      },
      'Plastic Bottles': {
        'degradationTime': 500, // in years
        'pollution': 0.25, // pollution units per item
        'alternatives': [
          'Glass Bottles',
          'Metal Cans',
        ],
      },
    };

    final itemDetail = itemData[item];

    // Degradation time, pollution, and alternatives
    final degradationTime = itemDetail?['degradationTime'] ?? 0;
    final pollutionPerItem = itemDetail?['pollution'] ?? 0.0;
    final alternatives = itemDetail?['alternatives'] ?? [];

    // Calculate total pollution caused by the user
    final totalPollution = pollutionPerItem * quantity;

    return Scaffold(
      appBar: AppBar(
        title: Text('$item Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$item Impact Details',
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Text('You have selected: $quantity item(s)'),
              const SizedBox(height: 10.0),
              Text('Degradation Time per Item: $degradationTime years'),
              const SizedBox(height: 10.0),
              Text(
                'Total Pollution Caused:',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                  'The total pollution caused by using $quantity $item(s) is ${totalPollution.toStringAsFixed(2)} pollution units. This represents the cumulative environmental impact of the selected items.'),
              const SizedBox(height: 20.0),

              // Alternatives List
              Text(
                'Alternatives to Consider:',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              ...alternatives.take(2).map((alternative) {
                return ListTile(
                  title: Text(alternative),
                );
              }).toList(),
              const SizedBox(height: 20.0),

              // Action Buttons
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //         context, MaterialPageRoute(builder: (context) => Maps()));
              //   },
              //   child: const Text(
              //     'Drop Your Plastic Waste Here',
              //     // style: TextStyle(color: Colors.teal),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
