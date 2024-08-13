import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SchoolDetailPage extends StatelessWidget {
  final String schoolName;
  final String schoolCode;
  final String activities;
  final String ngoInvolved;
  final String clerkName;
  final String ngoHeadOfSchool;
  final String phoneNumber;
  final String address;
  final Map<String, String> socialMedia;

  const SchoolDetailPage({
    super.key,
    required this.schoolName,
    required this.schoolCode,
    required this.activities,
    required this.ngoInvolved,
    required this.clerkName,
    required this.ngoHeadOfSchool,
    required this.phoneNumber,
    required this.address,
    required this.socialMedia,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(schoolName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'School Code:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(schoolCode),
            SizedBox(height: 16),
            Text(
              'Address:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(address),
            SizedBox(height: 16),
            Text(
              'Phone Number:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(phoneNumber),
            SizedBox(height: 16),
            Text(
              'Activities Done by School:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(activities),
            SizedBox(height: 16),
            Text(
              'NGO Involved:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(ngoInvolved),
            SizedBox(height: 16),
            Text(
              'Clerk Name:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(clerkName),
            SizedBox(height: 16),
            Text(
              'NGO Head of School:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(ngoHeadOfSchool),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (socialMedia.containsKey('facebook'))
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.facebook),
                    onPressed: () {
                      _launchURL(socialMedia['facebook']!);
                    },
                  ),
                if (socialMedia.containsKey('twitter'))
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.twitter),
                    onPressed: () {
                      _launchURL(socialMedia['twitter']!);
                    },
                  ),
                if (socialMedia.containsKey('instagram'))
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.instagram),
                    onPressed: () {
                      _launchURL(socialMedia['instagram']!);
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
