// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:plastic_eliminator/pages/phone_no_update.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/widgets.dart';
// import 'package:plastic_eliminator/pages/allshops.dart';
// import 'package:plastic_eliminator/pages/news.dart';
// import 'package:plastic_eliminator/pages/shoplist.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:plastic_eliminator/pages/calculator.dart';
// import 'package:plastic_eliminator/pages/contact.dart';
// import 'package:plastic_eliminator/pages/events.dart';
// import 'package:plastic_eliminator/pages/games.dart';
// import 'package:plastic_eliminator/pages/gov_work.dart';
// import 'package:plastic_eliminator/pages/learn.dart';
// import 'package:plastic_eliminator/pages/challenge_type.dart';
// import 'package:plastic_eliminator/pages/sorting_game.dart';
// import 'package:plastic_eliminator/services/shared_pref.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Material App',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Material App Bar'),
//           backgroundColor: Color.fromARGB(255, 240, 248, 245),
//         ),
//         body: const Home(),
//       ),
//     );
//   }
// }

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
//   late final AnimationController _animationController;
//   late final Timer _timer;
//   final PageController _pageController = PageController();
//   // String? name, image;
//   String? photoURL;
//   String? userName;

//   @override
//   @override
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 60),
//     );

//     _animationController.addListener(() {});

//     _animationController.repeat();

//     _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
//       int nextPage = _pageController.page!.round() + 1;
//       if (nextPage >= 3) {
//         nextPage = 0;
//       }
//       _pageController.animateToPage(
//         nextPage,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     });

//     _loadUserData(); // Added this line to load user data
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     _timer.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

//   // Future<void> _loadUserData() async {
//   //   try {
//   //     User? user = FirebaseAuth.instance.currentUser;
//   //     if (user != null) {
//   //       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//   //           .collection('users')
//   //           .doc(user.uid)
//   //           .get();
//   //       if (userDoc.exists) {
//   //         setState(() {
//   //           photoURL = userDoc.get('photoURL');
//   //           userName = userDoc.get('userName');
//   //         });
//   //         print('User data loaded: $photoURL, $userName');
//   //       } else {
//   //         print('User document does not exist');
//   //       }
//   //     } else {
//   //       print('No user signed in');
//   //     }
//   //   } catch (e) {
//   //     print('Error loading user data: $e');
//   //   }
//   // }
//     Future<void> _loadUserData() async {
//     currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       final userDoc =
//           await _firestore.collection('users').doc(currentUser!.uid).get();
//       setState(() {
//         userName = userDoc.data()?['name'] ?? 'User';
//         email = currentUser!.email ?? 'Email not available';
//         phoneNumber =
//             userDoc.data()?['phoneNumber'] ?? 'Phone number not provided';
//         photoURL = userDoc.data()?['profileImageUrl'] ??
//             currentUser!.photoURL ??
//             'https://via.placeholder.com/150';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 224, 245, 244),
//       body: Container(
//         margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Hello,',
//                         style: TextStyle(
//                           fontSize: 24.0,
//                           fontWeight: FontWeight.w500,
//                           color: Color.fromARGB(188, 0, 0, 0),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 20,
//                             backgroundImage: NetworkImage(
//                                 photoURL ?? 'https://via.placeholder.com/150'),
//                             backgroundColor: Colors.transparent,
//                           ),
//                           const SizedBox(width: 8),
//                           Text(
//                             userName ?? 'Guest',
//                             style: const TextStyle(
//                               fontSize: 24.0,
//                               fontWeight: FontWeight.w500,
//                               color: Color.fromARGB(188, 0, 0, 0),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10.0),
//               const Divider(),
//               const SizedBox(height: 10),
//               Container(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Top Picks',
//                       style: TextStyle(
//                         fontSize: 22.0,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(height: 30.0),
//                     SizedBox(
//                       height: 200.0, // Adjust height as needed
//                       child: SwiperPage(pageController: _pageController),
//                     ),
//                     const SizedBox(height: 15.0),
//                     const Text(
//                       'Activities',
//                       style: TextStyle(
//                         fontSize: 22.0,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(height: 15.0),
//                     SizedBox(
//                       height: 165.0,
//                       child: ListView(
//                         scrollDirection: Axis.horizontal,
//                         children: [
//                           _buildActivityContainer(
//                             'Challenges',
//                             'DO',
//                             ChallengeType(),
//                             AssetImage('Assets/images/challenge.png'),
//                           ),
//                           const SizedBox(width: 15),
//                           _buildActivityContainer(
//                             'Games',
//                             'NOT',
//                             Games(),
//                             AssetImage('Assets/images/challenge.png'),
//                           ),
//                           const SizedBox(width: 15),
//                           _buildActivityContainer(
//                             'News',
//                             'USE',
//                             NewsPage(),
//                             AssetImage('Assets/images/challenge.png'),
//                           ),
//                           const SizedBox(width: 15),
//                           _buildActivityContainer(
//                             'Impact Calculator',
//                             'PLASTIC',
//                             Calculator(),
//                             AssetImage('Assets/images/challenge.png'),
//                           ),
//                           const SizedBox(width: 15),
//                           _buildActivityContainer(
//                             'Learnings',
//                             'AT',
//                             LearningsGrid(),
//                             AssetImage('Assets/images/challenge.png'),
//                           ),
//                           const SizedBox(width: 15),
//                           _buildActivityContainer(
//                             'Government',
//                             'ALL',
//                             PlasticSectionPage(),
//                             AssetImage('Assets/images/challenge.png'),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 15.0),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Shops',
//                           style: TextStyle(
//                             fontSize: 22.0,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         InkWell(
//                           child: Text(
//                             'Show All',
//                             style: TextStyle(
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xff7469B6),
//                             ),
//                           ),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => ShowAll()),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 15.0),
//                     ShopList(),
//                     SizedBox(height: 15.0),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildActivityContainer(
//       String label, String label1, Widget page, ImageProvider image) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => page),
//         );
//       },
//       child: Container(
//         width: 150.0,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.0),
//           color: Colors.white,
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 6.0,
//               offset: Offset(0.0, 6.0),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Add the image at the top
//             Image(
//               image: image,
//               width: 50.0, // Adjust the size as needed
//               height: 50.0, // Adjust the size as needed
//               fit: BoxFit.cover, // Adjust the fit as needed
//             ),
//             const SizedBox(height: 10.0),
//             Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 10.0),
//             Text(
//               label1,
//               style: const TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xff7469B6),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SwiperPage extends StatelessWidget {
//   final PageController pageController;

//   const SwiperPage({Key? key, required this.pageController}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final List<String> images = [
//       'Assets/images/tortoise_onboard.png',
//       'Assets/images/tortoise_onboard.png',
//       'Assets/images/tortoise_onboard.png',
//     ];

//     final List<String> pageTitles = [
//       'Events',
//       'Events',
//       'Contact',
//     ];

//     return Column(
//       children: [
//         Expanded(
//           child: PageView.builder(
//             controller: pageController,
//             itemCount: images.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 10.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.0),
//                   color: Colors.white,
//                   image: DecorationImage(
//                     image: AssetImage(images[index]), // Use image from the list
//                     fit: BoxFit.cover,
//                   ),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 6.0,
//                       offset: Offset(0.0, 6.0),
//                     ),
//                   ],
//                 ),
//                 child: Stack(
//                   children: [
//                     Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             pageTitles[index], // Use page title from the list
//                             style: const TextStyle(
//                               fontSize: 24.0,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           const SizedBox(height: 20.0),
//                           ElevatedButton(
//                             onPressed: () {
//                               // Navigate to different pages based on the index
//                               switch (index) {
//                                 case 0:
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => Events()),
//                                   );
//                                   break;
//                                 case 1:
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => Events()),
//                                   );
//                                   break;
//                                 case 2:
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => FeedbackPage()),
//                                   );
//                                   break;
//                               }
//                             },
//                             style: ElevatedButton.styleFrom(// Button color
//                                 ),
//                             child: Text(pageTitles[index]),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//         const SizedBox(height: 15.0),
//         SmoothPageIndicator(
//           controller: pageController,
//           count: images.length,
//           effect: const ExpandingDotsEffect(
//             activeDotColor: Color(0xff7469B6),
//             dotColor: Colors.grey,
//             dotHeight: 10.0,
//             dotWidth: 10.0,
//             expansionFactor: 4,
//             spacing: 5.0,
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:plastic_eliminator/pages/phone_no_update.dart';
import 'package:plastic_eliminator/pages/allshops.dart';
import 'package:plastic_eliminator/pages/news.dart';
import 'package:plastic_eliminator/pages/shoplist.dart';
import 'package:plastic_eliminator/pages/calculator.dart';
import 'package:plastic_eliminator/pages/contact.dart';
import 'package:plastic_eliminator/pages/events.dart';
import 'package:plastic_eliminator/pages/games.dart';
import 'package:plastic_eliminator/pages/gov_work.dart';
import 'package:plastic_eliminator/pages/learn.dart';
import 'package:plastic_eliminator/pages/challenge_type.dart';
import 'package:plastic_eliminator/pages/sorting_game.dart';
import 'package:plastic_eliminator/services/shared_pref.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plastic Eliminator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plastic Eliminator'),
          backgroundColor: Color.fromARGB(255, 240, 248, 245),
        ),
        body: const Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Timer _timer;
  final PageController _pageController = PageController();
  String? photoURL;
  String? userName;
  String? email;
  String? phoneNumber;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );

    _animationController.addListener(() {});

    _animationController.repeat();

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      int nextPage = _pageController.page!.round() + 1;
      if (nextPage >= 3) {
        nextPage = 0;
      }
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });

    _loadUserData(); // Load user data
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      setState(() {
        userName = userDoc.data()?['name'] ?? 'User';
        email = currentUser.email ?? 'Email not available';
        phoneNumber =
            userDoc.data()?['phoneNumber'] ?? 'Phone number not provided';
        photoURL = userDoc.data()?['profileImageUrl'] ??
            currentUser.photoURL ??
            'https://via.placeholder.com/150';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 224, 245, 244),
      body: Container(
        margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 10.0),
              const Divider(),
              const SizedBox(height: 10),
              _buildContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hello,',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(188, 0, 0, 0),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      photoURL ?? 'https://via.placeholder.com/150'),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(width: 8),
                Text(
                  userName ?? 'Guest',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(188, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Top Picks',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 30.0),
        SizedBox(
          height: 200.0, // Adjust height as needed
          child: SwiperPage(pageController: _pageController),
        ),
        const SizedBox(height: 15.0),
        const Text(
          'Activities',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 15.0),
        SizedBox(
          height: 165.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildActivityContainer(
                'Challenges',
                'DO',
                ChallengeType(),
                AssetImage('Assets/images/challenge.png'),
              ),
              const SizedBox(width: 15),
              _buildActivityContainer(
                'Games',
                'NOT',
                Games(),
                AssetImage('Assets/images/challenge.png'),
              ),
              const SizedBox(width: 15),
              _buildActivityContainer(
                'News',
                'USE',
                NewsPage(),
                AssetImage('Assets/images/challenge.png'),
              ),
              const SizedBox(width: 15),
              _buildActivityContainer(
                'Impact Calculator',
                'PLASTIC',
                Calculator(),
                AssetImage('Assets/images/challenge.png'),
              ),
              const SizedBox(width: 15),
              _buildActivityContainer(
                'Learnings',
                'AT',
                LearningsGrid(),
                AssetImage('Assets/images/challenge.png'),
              ),
              const SizedBox(width: 15),
              _buildActivityContainer(
                'Government',
                'ALL',
                PlasticSectionPage(),
                AssetImage('Assets/images/challenge.png'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Shops',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            InkWell(
              child: const Text(
                'Show All',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff7469B6),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShowAll()),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 15.0),
        ShopList(),
        const SizedBox(height: 15.0),
      ],
    );
  }

  Widget _buildActivityContainer(
      String label, String label1, Widget page, ImageProvider image) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        width: 150.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              offset: Offset(0.0, 6.0),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: image,
              width: 50.0,
              height: 50.0,
            ),
            const SizedBox(height: 10.0),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              label1,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SwiperPage extends StatelessWidget {
  final PageController pageController;
  const SwiperPage({Key? key, required this.pageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: pageController,
          children: const [
            EventPage(),
            ContactPage(),
            FeedbackPage(),
          ],
        ),
        Positioned(
          bottom: 8.0,
          left: 16.0,
          right: 16.0,
          child: Center(
            child: SmoothPageIndicator(
              controller: pageController,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.black,
                dotColor: Colors.black12,
                dotHeight: 8.0,
                dotWidth: 8.0,
                spacing: 4.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: const Center(
        child: Text('Events Page'),
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: const Center(
        child: Text('Contact Page'),
      ),
    );
  }
}

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Center(
        child: Text('Feedback Page'),
      ),
    );
  }
}
