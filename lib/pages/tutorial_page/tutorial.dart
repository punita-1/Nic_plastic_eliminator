// import 'package:flutter/material.dart';
// import 'package:plastic_eliminator/pages/tutorial_page/scanner.dart';

// class Categories extends StatelessWidget {
//   final List<String> categories = [
//     'Home Recycling',
//     'Plastic Management',
//     'Creative Reuse',
//     'Environmental Impact',
//     'DIY Projects',
//     'Sustainable Living',
//     'Community Efforts',
//     'Educational Resources'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           "Let's Learn",
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: categories.length,
//         itemBuilder: (context, index) {
//           return Column(
//             children: [
//               ListTile(
//                 title: Text(
//                   categories[index],
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold), // Increased font size
//                 ),
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           VideoList(category: categories[index]),
//                     ),
//                   );
//                 },
//               ),
//               Divider()
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
