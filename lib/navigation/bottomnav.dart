// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:plastic_eliminator/features/community_page/community.dart';
import 'package:plastic_eliminator/features/Home/home.dart';
import 'package:plastic_eliminator/features/map/presentation/mapnerby.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:plastic_eliminator/features/tutorials/categories.dart';

/// A widget that displays a bottom navigation bar with multiple pages.
///
/// This widget uses a [CurvedNavigationBar] for navigation between different pages of the app.
class Bottomnav extends StatefulWidget {
  /// Creates a [Bottomnav] widget.
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  /// List of pages to be displayed in the bottom navigation bar.
  late List<Widget> pages;

  /// Home page instance.
  late Home _homePage;

  /// Community page instance.
  late Community _communityPage;

  /// Maps page instance.
  late Maps _mapsPage;

  /// Categories page instance.
  late Categories _categoriesPage;

  /// Index of the currently selected tab.
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize pages
    _homePage = Home();
    _communityPage = Community();
    _mapsPage = Maps();
    _categoriesPage = Categories();

    // Set up the list of pages
    pages = [
      _homePage,
      _communityPage,
      _categoriesPage,
      _mapsPage,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // Curved navigation bar for bottom navigation
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        color: theme.primaryColor,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
        backgroundColor: theme.scaffoldBackgroundColor,
        items: const [
          Icon(Icons.home),
          Icon(Icons.chat),
          Icon(Icons.play_circle),
          Icon(Icons.location_on),
        ],
      ),
      // Display the current page based on the selected tab
      body: pages[_currentTabIndex],
    );
  }
}
