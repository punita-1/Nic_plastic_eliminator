import 'package:flutter/material.dart';

class ShopDetailPage extends StatelessWidget {
  final String shopName;
  final String phoneNumber;
  final String address;

  const ShopDetailPage({
    Key? key,
    required this.shopName,
    required this.phoneNumber,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shopName),
        backgroundColor: Color.fromARGB(255, 240, 248, 245),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shop Name: $shopName',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Phone Number: $phoneNumber',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Address: $address',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
