import 'package:flutter/material.dart';

class Challenges extends StatefulWidget {
  String challengetype;
  Challenges({required this.challengetype});

  @override
  State<Challenges> createState() => _ChallengesState();
}

class _ChallengesState extends State<Challenges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F1F1),
      body: Container(
        margin: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black,
                  size: 30.0,
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              widget.challengetype,
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500),
            ),
            Text(
              'Challenges',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
