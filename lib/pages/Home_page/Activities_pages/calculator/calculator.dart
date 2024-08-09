// import 'package:flutter/material.dart';
// import 'package:plastic_eliminator/pages/Home_page/Activities_pages/calculator/footprint_calculator.dart';
// import 'package:plastic_eliminator/pages/Home_page/Activities_pages/calculator/plastic_final/plastic_dose_form.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:plastic_eliminator/pages/initial_pages/login.dart';

// class Calculator extends StatelessWidget {
//   const Calculator({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'Impact Calculator',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () async {
//                 User? user = FirebaseAuth.instance.currentUser;
//                 if (user != null) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => PlasticUsageForm()),
//                   );
//                 } else {
//                   _showLoginAlertDialog(context);
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(
//                     vertical: 15.0, horizontal: 20.0),
//                 backgroundColor: Colors.teal, // Background color
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 elevation: 5,
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.track_changes, color: Colors.white),
//                   const SizedBox(width: 10),
//                   Text(
//                     'Track Plastic Dose',
//                     style: TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNavigationButton(
//       BuildContext context, String label, IconData icon, Widget page) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: ListTile(
//         leading: Icon(icon, color: Colors.teal, size: 36.0),
//         title: Text(
//           label,
//           style: TextStyle(
//               fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
//         ),
//         tileColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => page),
//           );
//         },
//       ),
//     );
//   }

//   void _showLoginAlertDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Login Required'),
//           content: Text('You need to be logged in to access this feature.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text(
//                 'Cancel',
//                 style: TextStyle(color: Colors.teal),
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(
//                       builder: (context) =>
//                           Login()), // Navigate to your login page
//                 );
//               },
//               child: Text(
//                 'Login',
//                 style: TextStyle(color: Colors.teal),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/calculator/summary.dart';

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
              'Tap on the items you use daily to add them to your list.',
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
