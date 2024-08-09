import 'package:flutter/material.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/calculator/item_detail.dart';

class SummaryPage extends StatelessWidget {
  final Map<String, int> shoppingBag;

  const SummaryPage({super.key, required this.shoppingBag});

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
          : ListView(
              children: shoppingBag.entries.map((entry) {
                final item = entry.key;
                final quantity = entry.value;
                return ListTile(
                  title: Text('$item (x$quantity)'),
                  onTap: () => _navigateToItemDetail(context, item, quantity),
                );
              }).toList(),
            ),
      floatingActionButton: shoppingBag.isEmpty
          ? null
          : FloatingActionButton(
              onPressed: () {
                // Implement overall impact calculation if needed
              },
              child: const Icon(
                Icons.calculate,
                color: Colors.teal,
              ),
            ),
    );
  }
}
