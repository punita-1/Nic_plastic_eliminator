import 'package:flutter/material.dart';

class ShowAll extends StatefulWidget {
  const ShowAll({super.key});

  @override
  State<ShowAll> createState() => _ShowAllState();
}

class _ShowAllState extends State<ShowAll> {
  final List<String> shops = [
    'Shop 1',
    'Shop 2',
    'Shop 3',
    'Shop 4',
    'Shop 5',
    'Shop 6',
    'Shop 7',
    'Shop 8',
    'Shop 9',
    'Shop 10',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shops'),
      ),
      body: ListView.builder(
        itemCount: shops.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(Icons.store),
              title: Text(shops[index]),
              subtitle: Text('Description of ${shops[index]}'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Handle shop item tap
              },
            ),
          );
        },
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Material App',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Material App Bar'),
//         ),
//         body: const Center(
//           child: Text('Hello World'),
//         ),
//       ),
//     );
//   }
// }