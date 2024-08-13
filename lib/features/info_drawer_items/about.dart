import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// A screen that displays information about the app and its mission.
///
/// This widget provides details on the app's mission, features, team, and contact information.
/// It uses a [Scaffold] to create a layout with an [AppBar] and a [SingleChildScrollView] to allow for
/// scrolling content.
class About extends StatelessWidget {
  // Function to launch the phone dialer with the provided phone number.
  Future<void> _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The [AppBar] at the top of the screen displays the title 'About Us'
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'About Us',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      // The main content of the About screen is wrapped in a [SingleChildScrollView] to enable scrolling.
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section displaying the app's mission
            Center(
              child: Text(
                'Our Mission',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Our mission is to raise awareness about the harmful effects of plastic pollution on the environment and to encourage sustainable practices. We aim to provide resources, tools, and a community platform to help individuals and organizations contribute to a greener planet.',
              style: TextStyle(fontSize: 16),
            ),
            Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Divider()),
            SizedBox(height: 12),

            // Section listing the app's features
            Center(
              child: Text(
                'Features',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '1. Games: Fun and endless games promoting eco-friendly habits.\n'
              '2. Challenges: Daily, weekly, and monthly challenges to reduce plastic use.\n'
              '3. News: Latest updates on plastic waste and environmental protection.\n'
              '4. Plastic Calculator: Assess the environmental impact of plastic waste.\n'
              '5. Gov Actions: Information on governmental policies and actions.\n'
              '6. Events: Upcoming events focused on reducing plastic pollution.\n'
              '7. Community: Share tips, tutorials, and success stories, and interact with others.\n'
              '8. Plastic Tutorials: Learn creative ways to transform plastic waste.\n'
              '9. Support Plastic Free Shopping: Find Plastic free shops.\n'
              '10. Find nearest Drop off: Find Plastic Drop off near you.\n'
              '11. Register Schools: Checkout actions taken by school students against plastic waste reduction.\n',
              style: TextStyle(fontSize: 16),
            ),
            Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Divider()),
            // SizedBox(height: 15),

            // Section introducing the team
            Center(
              child: Text(
                'About Developers',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // SizedBox(height: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'In association with the National Informatics Center, under the guidance of:-',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Mr. Vinod Kr. Singla, District Informatics Officer Kurukshetra, \nMr. Rajiv\nMrs. Hema\nMr. Mohit',
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () => _launchPhone('8168670903'),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Student Developers:',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text('Punita Gaba (BTech CSE, DCRUST Murthal) '),
                      Text(
                        'Phone: 8168670903',
                        style: TextStyle(
                            // fontSize: 16,
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Divider()),
            // Section providing contact information
            Center(
              child: Text(
                'Contact Us',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'If you have any questions, feedback, or suggestions, please feel free to contact us. Together, we can make a positive impact on our environment.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            // A closing message to the users
            Center(
              child: Text(
                'Thank you for being a part of our journey towards a greener planet!',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
