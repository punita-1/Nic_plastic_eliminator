import 'package:flutter/material.dart';
import 'package:plastic_eliminator/pages/community_page/community.dart';
import 'package:plastic_eliminator/pages/Home_page/home.dart';
import 'package:plastic_eliminator/pages/map_page/mapnerby.dart';
import 'package:plastic_eliminator/pages/profile_page/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:plastic_eliminator/pages/tutorial_page/youtube_playlist/categories.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  late List<Widget> pages;

  late Home Homepage;
  late Community community;
  late Maps nearby;
  late Categories categories;
  int currentTabIndex = 0;

  @override
  void initState() {
    Homepage = Home();
    // profile = Profile();
    community = Community();
    nearby = Maps();
    categories = Categories();
    pages = [
      Homepage,
      community,
      categories,
      nearby,
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        color: theme.primaryColor,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        backgroundColor: theme.scaffoldBackgroundColor,
        items: [
          Icon(Icons.home),
          Icon(
            Icons.chat,
          ),
          Icon(
            Icons.play_circle,
          ),
          Icon(
            Icons.location_on,
          ),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
