// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopDetailPage extends StatelessWidget {
  final String shopName;
  final String phoneNumber;
  final String address;
  final String description;
  final String homeDelivery;

  const ShopDetailPage({
    Key? key,
    required this.shopName,
    required this.phoneNumber,
    required this.address,
    required this.description,
    required this.homeDelivery,
  }) : super(key: key);

  // Method to launch URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
            InkWell(
              onTap: () {
                final phoneUrl = 'tel:$phoneNumber';
                _launchURL(phoneUrl);
              },
              child: Text(
                'Phone Number: $phoneNumber',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                final addressUrl =
                    'https://www.google.com/maps/search/?api=1&query=$address';
                _launchURL(addressUrl);
              },
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
            Text(
              'Description: $description',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Home Delivery: $homeDelivery',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
