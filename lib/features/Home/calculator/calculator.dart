import 'package:flutter/material.dart';
import 'package:plastic_eliminator/features/Home/calculator/summary.dart';
// import 'package:plastic_eliminator/src/features/Home/calculator/summary.dart';
// import 'package:plastic_eliminator/pages/Activities_pages/calculator/summary.dart';

class PlasticItemScreen extends StatefulWidget {
  const PlasticItemScreen({super.key});

  @override
  _PlasticItemScreenState createState() => _PlasticItemScreenState();
}

class _PlasticItemScreenState extends State<PlasticItemScreen> {
  final Map<String, int> _shoppingBag = {};

  final List<Map<String, dynamic>> _items = [
    {'name': 'Toothbrush', 'icon': Icons.brush},
    {'name': 'Comb', 'icon': Icons.straighten},
    {'name': 'Disposable Dishes', 'icon': Icons.dining},
    {'name': 'Plastic Bags', 'icon': Icons.shopping_bag},
    {'name': 'Plastic Bottles', 'icon': Icons.local_drink},
    {'name': 'Cutlery', 'icon': Icons.restaurant},
    {'name': 'Straws', 'icon': Icons.no_drinks},
    {'name': 'Food Containers', 'icon': Icons.kitchen},
    {'name': 'Packaging Material', 'icon': Icons.all_inbox},
    {'name': 'Plastic Wrap', 'icon': Icons.wrap_text},
  ];

  void _addToBag(String item) {
    setState(() {
      if (_shoppingBag.containsKey(item)) {
        _shoppingBag[item] = (_shoppingBag[item] ?? 0) + 1;
      } else {
        _shoppingBag[item] = 1;
      }
    });
  }

  void _removeFromBag(String item) {
    setState(() {
      if (_shoppingBag.containsKey(item)) {
        if (_shoppingBag[item]! > 1) {
          _shoppingBag[item] = _shoppingBag[item]! - 1;
        } else {
          _shoppingBag.remove(item);
        }
      }
    });
  }

  void _navigateToSummary() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryPage(shoppingBag: _shoppingBag),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Select Your Plastic Items'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Tap on the Plastic items you use to add them to your list.',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                final itemName = item['name'];
                final itemCount = _shoppingBag[itemName] ?? 0;

                return ListTile(
                  leading: Icon(item['icon'], color: Colors.teal),
                  title: Text(itemName),
                  subtitle: itemCount > 0
                      ? Text('Selected $itemCount time(s)',
                          style: TextStyle(color: Colors.grey[600]))
                      : null,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, color: Colors.red),
                        onPressed: itemCount > 0
                            ? () => _removeFromBag(itemName)
                            : null,
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.teal),
                        onPressed: () => _addToBag(itemName),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (_shoppingBag.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total items selected: ${_shoppingBag.values.fold(0, (sum, itemCount) => sum + itemCount)}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToSummary,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
