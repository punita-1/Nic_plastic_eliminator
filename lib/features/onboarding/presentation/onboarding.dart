// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:plastic_eliminator/features/auth/presentation/signup.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  // List of onboarding data with images and text
  final List<Map<String, String>> _onboardingData = [
    {
      'image': 'Assets/onboard_images/onboard1.png',
      'text':
          'Welcome to Plastic Eliminator!\nJoin us in the fight against plastic.\n',
    },
    {
      'image': 'Assets/onboard_images/onboard2.png',
      'text':
          'Participate in Events and earn rewards.\nSupport Plastic Free Community.',
    },
    {
      'image': 'Assets/onboard_images/onboard3.png',
      'text': 'Try Plastic Calculator,\nplastic free shopping \nand many more.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Onboarding image and text
          Expanded(
            flex: 3,
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Display onboarding image
                    Container(
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(20),
                          ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          _onboardingData[index]['image']!,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    // Display onboarding text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        _onboardingData[index]['text']!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w500),
                        // style: TextStyle(
                        //     fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // Page indicator and button
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Page indicator
                SmoothPageIndicator(
                  controller: _controller,
                  count: _onboardingData.length,
                  effect: WormEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotColor: Colors.teal,
                    dotColor: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                // Button to navigate or move to the next page
                Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 24),
                    ),
                    onPressed: () {
                      if (_currentPage < _onboardingData.length - 1) {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      }
                    },
                    child: Text(
                      _currentPage < _onboardingData.length - 1
                          ? 'Next'
                          : 'Join the Movement',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
