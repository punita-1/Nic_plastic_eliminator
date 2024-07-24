import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:plastic_eliminator/pages/home.dart';
import 'package:plastic_eliminator/pages/signup.dart';

// class Onboarding extends StatefulWidget {
//   const Onboarding({super.key});

//   @override
//   State<Onboarding> createState() => _OnboardingState();
// }

// class _OnboardingState extends State<Onboarding> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF6F1F1),
//       body: Container(
//         margin: EdgeInsets.only(top: 120),
//         child: Column(
//           children: [
//             Container(
//               child: Image.asset('Assets/images/Onboarding_noBG.png'),
//             ),
//             SizedBox(
//               height: 0,
//             ),
//             Container(
//               child: Text(
//                 'Welcome to Plastic Eliminator!',
//                 style: TextStyle(fontSize: 15),
//               ),
//             ),
//             Container(
//               child: Text('"Fight plastic waste with us. Every action counts"',
//                   style: TextStyle(fontSize: 15)),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Signup()),
//                 );
//               },
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Text(
//                   'Join the Movement',
//                   style: TextStyle(
//                       fontSize: 20.0,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:smooth_page_indicator/src/effects/worm_effect.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'image': 'Assets/images/bagfight_onboard.png',
      'text':
          'Welcome to Plastic Eliminator!\n Join us in the fight against plastic.',
    },
    {
      'image': 'Assets/images/mountain_onboard.png',
      'text':
          'Enjoy exciting, games.\nParticipate in Events and earn \nrewards.',
    },
    {
      'image': 'Assets/images/tortoise_onboard.png',
      'text':
          'Try Our Tools to Make a Difference:\nPlastic Calculator, Community, Scanner.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F1F1),
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
                            height: 400,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          _onboardingData[index]['text']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
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
                      activeDotColor: Color(0xff7469B6),
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
                            fontSize: 18,
                            color: Colors.white), // Set text color to pink
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xff7469B6), // Set background color to purple
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15), // Set less rounded corners
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
