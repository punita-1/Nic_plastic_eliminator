import 'package:flutter/material.dart';

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
            Text(
              'Phone: $phoneNumber',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Address: $address',
              style: TextStyle(fontSize: 16),
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
