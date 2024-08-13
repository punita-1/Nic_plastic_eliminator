import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plastic_eliminator/features/info_drawer_items/contact.dart';

class SwiperPageNew extends StatefulWidget {
  const SwiperPageNew({super.key});

  @override
  State<SwiperPageNew> createState() => _SwiperPageNewState();
}

class _SwiperPageNewState extends State<SwiperPageNew> {
  final PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSwipe();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSwipe() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      int nextPage = _pageController.page!.toInt() + 1;
      if (nextPage >= 5) {
        nextPage = 0;
      }
      _pageController.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Your custom text instead of localized text
          Text(
            'What\'s New',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 170,
            child: PageView(
              controller: _pageController,
              children: [
                _buildPage(
                  'Do you want to Register your Shop with us?\nContact Us',
                  Theme.of(context).colorScheme.primary,
                  Colors.teal,
                  Icons.store, // Replace with appropriate icon
                ),
                _buildPage(
                  'Do you want to Register your School with us?\nContact Us',
                  Theme.of(context).colorScheme.primary,
                  Colors.teal,
                  Icons.school, // Replace with appropriate icon
                ),
                _buildPage(
                  'Do you want to work with NGOs?\nContact Us',
                  Theme.of(context).colorScheme.primary,
                  Colors.teal,
                  Icons.group, // Replace with appropriate icon
                ),
                _buildPage(
                  'Need Help?\nContact Us',
                  Theme.of(context).colorScheme.primary,
                  Colors.teal,
                  Icons.help, // Replace with appropriate icon
                ),
                _buildPage(
                  'New updates will be released soon. #Challenges #Your Plastic Tracker',
                  Theme.of(context).colorScheme.primary,
                  Colors.teal,
                  Icons.update, // Replace with appropriate icon
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(
      String title, Color backgroundColor, Color textColor, IconData iconData) {
    final String displayTitle = title.contains('Contact Us')
        ? title.split('\n')[0] // First line as title
        : title;

    final bool showContactUs = title.contains('Contact Us');

    return Container(
      decoration: BoxDecoration( color: backgroundColor,borderRadius: BorderRadius.all(Radius.circular(8))),
      padding: EdgeInsets.all(20),
     
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 50, // Adjust the size of the icon as needed
              color: textColor, // Set icon color
            ),
            SizedBox(height: 10),
            Text(
              displayTitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: textColor, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            if (showContactUs) // Check if "Contact Us" should be displayed
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FeedbackPage()));
                },
                child: Text(
                  'Contact Us',
                  style: TextStyle(
                    color: Colors.blue, // Make the text stand out
                    decoration: TextDecoration
                        .underline, // Optional: underline the text
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
