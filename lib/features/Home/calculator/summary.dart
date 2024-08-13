import 'package:flutter/material.dart';
import 'package:plastic_eliminator/features/Home/calculator/item_detail.dart';

class SummaryPage extends StatelessWidget {
  final Map<String, int> shoppingBag;

 SummaryPage({super.key, required this.shoppingBag});

  // Example data for calculation - replace with accurate data
  final Map<String, int> degradationTimes = {
    'Plastic Bottle': 500, // in years
    'Plastic Bag': 200, // in years
    'Straw': 200, // in years
    // Add more items and their degradation times
  };

  final Map<String, double> pollutionValues = {
    'Plastic Bottle': 1.5, // pollution units
    'Plastic Bag': 0.5, // pollution units
    'Straw': 0.2, // pollution units
    // Add more items and their pollution values
  };

  void _navigateToItemDetail(BuildContext context, String item, int quantity) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemDetailPage(item: item, quantity: quantity),
      ),
    );
  }

  void _navigateBackToSelection(BuildContext context) {
    Navigator.pop(context);
  }

  // Calculate total degradation time and pollution based on selected items
  Map<String, dynamic> _calculateImpact() {
    int totalDegradationTime = 0;
    double totalPollution = 0.0;

    shoppingBag.forEach((item, quantity) {
      final degradationTime = degradationTimes[item] ?? 0;
      final pollutionValue = pollutionValues[item] ?? 0.0;

      totalDegradationTime += degradationTime * quantity;
      totalPollution += pollutionValue * quantity;
    });

    return {
      'totalDegradationTime': totalDegradationTime,
      'totalPollution': totalPollution,
      'degradationDetails': shoppingBag.map((item, quantity) {
        final degradationTime = degradationTimes[item] ?? 0;
        return MapEntry(item, degradationTime * quantity);
      }),
    };
  }

  void _showImpactDialog(BuildContext context) {
    final impact = _calculateImpact();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Impact Summary'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...impact['degradationDetails']!.entries.map((entry) {
                final item = entry.key;
                final totalDegradationTime = entry.value;
                return Text(
                  '$item: ${totalDegradationTime} years',
                  style: const TextStyle(fontSize: 16),
                );
              }).toList(),
              const SizedBox(height: 10),
              Text('Total Degradation Time: ${impact['totalDegradationTime']} years'),
              Text('Total Pollution: ${impact['totalPollution'].toStringAsFixed(2)} units'),
              const SizedBox(height: 10),
              Text(
                'Pollution Value Explanation:',
                // style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 5),
             
              const SizedBox(height: 10),
              Text(
                'Interesting Fact:',
                // style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 5),
              Text(
                'Did you know? A single plastic bottle can take up to 500 years to decompose in a landfill. By switching to reusable alternatives, you can significantly reduce the amount of plastic waste and its impact on the environment. Consider using glass or metal bottles instead!',
                // style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
      ),
      body: shoppingBag.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No items selected!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => _navigateBackToSelection(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text(
                      'Go Back and Select Items',
                      style: TextStyle(color: Colors.teal),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            )
          : Column(
            children: [
               Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Tap on items to view details',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
          ),
              Expanded(
                child: ListView(
                    children: shoppingBag.entries.map((entry) {
                      final item = entry.key;
                      final quantity = entry.value;
                      return ListTile(
                        title: Text('$item (x$quantity)'),
                        onTap: () => _navigateToItemDetail(context, item, quantity),
                      );
                    }).toList(),
                  ),
              ),
            ],
          ),
    );
  }
}
