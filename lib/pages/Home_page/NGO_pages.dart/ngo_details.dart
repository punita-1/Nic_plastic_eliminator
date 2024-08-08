// import 'package:flutter/material.dart';

// class NGODetailPage extends StatelessWidget {
//   final String name;
//   final String address;
//   final String phoneNumber;

//   const NGODetailPage({
//     super.key,
//     required this.name,
//     required this.address,
//     required this.phoneNumber,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(name),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Name: $name',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Address: $address',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Phone Number: $phoneNumber',
//               style: TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NGODetailPage extends StatelessWidget {
  final String name;
  final String address;
  final String phoneNumber;

  const NGODetailPage({
    super.key,
    required this.name,
    required this.address,
    required this.phoneNumber,
  });

  void _launchPhone() async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle the error appropriately
      print('Could not launch $url');
    }
  }

  void _launchMaps() async {
    final url = 'geo:0,0?q=$address';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle the error appropriately
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: $name',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: _launchMaps,
              child: Text(
                'Address: $address',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: _launchPhone,
              child: Text(
                'Phone Number: $phoneNumber',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
