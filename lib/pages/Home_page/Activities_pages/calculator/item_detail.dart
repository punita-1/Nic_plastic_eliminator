// import 'package:flutter/material.dart';

// class ItemDetailPage extends StatelessWidget {
//   final String item;
//   final int quantity;

//   const ItemDetailPage({super.key, required this.item, required this.quantity});

//   @override
//   Widget build(BuildContext context) {
//     // Example data for decomposition time, impact, and pollution per item
//     final Map<String, Map<String, dynamic>> itemData = {
//       'Toothbrush': {
//         'decompositionTime': 400, // years
//         'environmentalImpact': 'High',
//         'pollution': 'Significant',
//       },
//       'Comb': {
//         'decompositionTime': 500, // years
//         'environmentalImpact': 'Moderate',
//         'pollution': 'Moderate',
//       },
//       'Disposable Dishes': {
//         'decompositionTime': 50, // years
//         'environmentalImpact': 'Low',
//         'pollution': 'Low',
//       },
//       'Plastic Bags': {
//         'decompositionTime': 1000, // years
//         'environmentalImpact': 'High',
//         'pollution': 'Severe',
//       },
//       'Plastic Bottles': {
//         'decompositionTime': 450, // years
//         'environmentalImpact': 'High',
//         'pollution': 'Significant',
//       },
//       // Add more items here...
//     };

//     final itemDetail = itemData[item];

//     // Use the decomposition time as-is, regardless of quantity
//     final decompositionTime = itemDetail?['decompositionTime'] ?? 'Unknown';
//     final environmentalImpact = itemDetail?['environmentalImpact'] ?? 'Unknown';
//     final pollution = itemDetail?['pollution'] ?? 'Unknown';

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$item Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               '$item Decomposition Details',
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10.0),
//             Text('Quantity: $quantity'),
//             SizedBox(height: 10.0),
//             Text(
//                 'Decomposition Time: $decompositionTime years (regardless of quantity)'),
//             Text('Environmental Impact: $environmentalImpact'),
//             Text('Pollution: $pollution'),
//             SizedBox(height: 20.0),

//             // Add easy-to-understand graphs here

//             // Action Buttons
//             ElevatedButton(
//               onPressed: () {
//                 // Implement navigation to drop-off locations
//               },
//               child: Text(
//                 'Help Us Drop Your Plastic Waste Here',
//                 style: TextStyle(color: Colors.teal),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement navigation to alternatives
//               },
//               child: Text(
//                 'Here Are Some Alternatives',
//                 style: TextStyle(color: Colors.teal),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Display fun fact
//                 showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     title: Text(
//                       'Fun Fact',
//                       style: TextStyle(color: Colors.teal),
//                     ),
//                     content: Text(
//                       'If 100 people did the same as you, it would result in a large amount of plastic waste that would still take $decompositionTime years to decompose.',
//                       style: TextStyle(color: Colors.teal),
//                     ),
//                     actions: [
//                       TextButton(
//                         onPressed: () => Navigator.of(context).pop(),
//                         child: Text('OK', style: TextStyle(color: Colors.teal)),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               child: Text('Fun Fact'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class ItemDetailPage extends StatelessWidget {
  final String item;
  final int quantity;

  const ItemDetailPage({super.key, required this.item, required this.quantity});

  @override
  Widget build(BuildContext context) {
    // Example data for decomposition time, impact, and pollution per item
    final Map<String, Map<String, dynamic>> itemData = {
      'Toothbrush': {
        'decompositionTime': 400, // years
        'environmentalImpact': 'High',
        'pollution': 'Significant',
      },
      'Comb': {
        'decompositionTime': 500, // years
        'environmentalImpact': 'Moderate',
        'pollution': 'Moderate',
      },
      'Disposable Dishes': {
        'decompositionTime': 50, // years
        'environmentalImpact': 'Low',
        'pollution': 'Low',
      },
      'Plastic Bags': {
        'decompositionTime': 1000, // years
        'environmentalImpact': 'High',
        'pollution': 'Severe',
      },
      'Plastic Bottles': {
        'decompositionTime': 450, // years
        'environmentalImpact': 'High',
        'pollution': 'Significant',
      },
      // Add more items here...
    };

    final itemDetail = itemData[item];

    // Decomposition time and environmental impact multiplied by the quantity
    final decompositionTime = (itemDetail?['decompositionTime'] ?? 0) * quantity;
    final environmentalImpact = itemDetail?['environmentalImpact'] ?? 'Unknown';
    final pollution = itemDetail?['pollution'] ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(
        title: Text('$item Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$item Decomposition Details',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text('You have selected: $quantity item(s)'),
            const SizedBox(height: 10.0),
            Text(
                'Decomposition Time: $decompositionTime years'),
            Text('Environmental Impact: $environmentalImpact'),
            Text('Pollution: $pollution'),
            const SizedBox(height: 20.0),

            // Comparison Graphs (Using placeholder text for now)
            Text(
              'Comparison with Other Items:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Container(
              height: 150,
              color: Colors.grey[200], // Placeholder for a graph
              child: Center(child: Text('Graph comparing decomposition times')),
            ),
            const SizedBox(height: 20.0),
            Container(
              height: 150,
              color: Colors.grey[200], // Placeholder for a graph
              child: Center(child: Text('Graph comparing environmental impact')),
            ),
            const SizedBox(height: 20.0),

            // Action Buttons
            ElevatedButton(
              onPressed: () {
                // Implement navigation to drop-off locations
              },
              child: const Text(
                'Help Us Drop Your Plastic Waste Here',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement navigation to alternatives
              },
              child: const Text(
                'Here Are Some Alternatives',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Display fun fact
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      'Fun Fact',
                      style: TextStyle(color: Colors.teal),
                    ),
                    content: Text(
                      'If 100 people did the same as you, it would result in ${decompositionTime * 100} years of plastic waste in the environment. That’s a long time for something we only use briefly!',
                      style: const TextStyle(color: Colors.teal),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('OK', style: TextStyle(color: Colors.teal)),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Fun Fact'),
            ),
          ],
        ),
      ),
    );
  }
}
