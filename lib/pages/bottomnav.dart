import 'package:flutter/material.dart';
import 'package:plastic_eliminator/pages/community.dart';
import 'package:plastic_eliminator/pages/home.dart';
import 'package:plastic_eliminator/pages/mapnerby.dart';
import 'package:plastic_eliminator/pages/profile.dart';
import 'package:plastic_eliminator/pages/scanner.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  late List<Widget> pages;

  late Home Homepage;
  late Profile profile;
  late Community community;
  late Maps nearby;
  late Scanner scanner;
  int currentTabIndex = 0;

  @override
  void initState() {
    Homepage = Home();
    profile = Profile();
    community = Community();
    nearby = Maps();
    scanner = Scanner();
    pages = [Homepage, community, scanner, nearby, profile];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        color: Color(0xff7469B6),
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        backgroundColor: Color(0xFFF6F1F1),
        items: [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.chat, color: Colors.white),
          Icon(Icons.scanner, color: Colors.white),
          Icon(Icons.map, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
