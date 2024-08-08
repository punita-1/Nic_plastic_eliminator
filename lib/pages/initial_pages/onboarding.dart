import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:plastic_eliminator/pages/initial_pages/signup.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'image': 'Assets/logo_image/onboardin1.png',
      'text':
          'Welcome to Plastic Eliminator!\nJoin us in the fight against plastic.\n ',
    },
    {
      'image': 'Assets/logo_image/onboard2.png',
      'text':
          'Participate in Events and earn rewards.\nSupport Plastic Free Shopping.',
    },
    {
      'image': 'Assets/logo_image/onboarding3.png',
      'text':
          'Try Plastic Calculator, Community\n Join Clubs.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
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
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            _onboardingData[index]['image']!,
                            height: 180,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          _onboardingData[index]['text']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage < 2) {
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
                        _currentPage < 2 ? 'Next' : 'Join the Movement',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
