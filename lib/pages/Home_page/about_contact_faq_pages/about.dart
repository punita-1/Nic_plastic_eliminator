import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'About Us',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Plastic Eliminator',
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            // ),
            // SizedBox(height: 16),
            Text(
              'Our Mission',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Our mission is to raise awareness about the harmful effects of plastic pollution on the environment and to encourage sustainable practices. We aim to provide resources, tools, and a community platform to help individuals and organizations contribute to a greener planet.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Features',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              '8. Plastic Tutorials: Learn creative ways to transform plastic waste.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Team',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Our team is passionate about creating a sustainable future. We are a group of developers, designers, and environmental enthusiasts committed to making a difference through technology and education.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'If you have any questions, feedback, or suggestions, please feel free to contact us at support@plasticeliminator.com. Together, we can make a positive impact on our environment.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
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
