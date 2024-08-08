import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopDetailsPage extends StatelessWidget {
  final String shopName;
  final String phoneNumber;
  final String address;
  final String description;

  const ShopDetailsPage({
    required this.shopName,
    required this.phoneNumber,
    required this.address,
    required this.description,
    super.key,
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
        title: Text(shopName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: $shopName',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: _launchPhone,
              child: Text(
                'Phone: $phoneNumber',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    decoration: TextDecoration.underline),
              ),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: _launchMaps,
              child: Text(
                'Address: $address',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    decoration: TextDecoration.underline),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Description: $description',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
