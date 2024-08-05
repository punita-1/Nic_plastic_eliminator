import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:plastic_eliminator/local_notifier.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/activities.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/challenge_home.dart';
import 'package:plastic_eliminator/pages/Home_page/NGO_pages.dart/All_ngo.dart';
import 'package:plastic_eliminator/pages/Home_page/about_contact_faq_pages/about.dart';
import 'package:plastic_eliminator/pages/Home_page/about_contact_faq_pages/contact.dart';
import 'package:plastic_eliminator/pages/Home_page/about_contact_faq_pages/faq.dart';
import 'package:plastic_eliminator/pages/Home_page/events_pages/events.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/games/games_home.dart';
import 'package:plastic_eliminator/pages/map_page/mapnerby.dart';
import 'package:plastic_eliminator/pages/tutorial_page/scanner.dart';
import 'package:plastic_eliminator/pages/Home_page/New_in_eliminator/swiper_pages.dart';
import 'package:plastic_eliminator/pages/tutorial_page/tutorial.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:plastic_eliminator/pages/Home_page/shops_page/allshops.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/news.dart';
import 'package:plastic_eliminator/pages/Home_page/shops_page/shoplist.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/calculator.dart';
import 'package:plastic_eliminator/pages/extra_pages/games.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/gov_work.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/learn_pages/learn.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_localization/flutter_localization.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plastic Eliminator',
      home: Scaffold(
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
      int nextPage = (_pageController.page ?? 0).round() + 1;
      if (nextPage >= 3) {
        nextPage = 0;
      }
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });

    _loadUserData();
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
      appBar: AppBar(
        leading: Container(
            margin: EdgeInsets.only(left: 10),
            child: Image.asset(
              'Assets/logo_image/logo.png',
              height: 40,
            )),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 10.0),
            // Text(
            //   'PlasticEliminator',
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            Text(AppLocalizations.of(context)!.plasticEliminator),
            Row(
              children: [
                // IconButton(
                //   icon: const Icon(Icons.language,
                //       color: Color.fromARGB(188, 0, 0, 0)),
                //   onPressed: () {
                //     // Add language change functionality here
                //   },
                // ),
                Column(
                  mainAxisSize: MainAxisSize
                      .min, // Ensure the Column only takes up as much vertical space as its children
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize
                          .min, // Ensure the Row only takes up as much horizontal space as its children
                      children: [
                        IconButton(
                          icon: const Icon(Icons.language,
                              color: Color.fromARGB(188, 0, 0, 0)),
                          onPressed: () {
                            final localeNotifier = Provider.of<LocaleNotifier>(
                                context,
                                listen: false);
                            final currentLocale = localeNotifier.locale;

                            // Toggle between English and Hindi
                            final newLocale = currentLocale.languageCode == 'en'
                                ? Locale('hi')
                                : Locale('en');
                            localeNotifier.setLocale(newLocale);
                          },
                        ),
                        // Text(
                        //   'en/hi',
                        //   style: TextStyle(
                        //       fontSize: 10), // Adjust font size as needed
                        // ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      body: Container(
        // margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Join Events to earn rewards',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      child: Text(
                        'more then millions of indians are changing for better',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      width: 390,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Events()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Events\nGet Involved in Events, \nMake a Difference \nand Win Rewards!',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Lottie.asset(
                                'Animations/Animation - 1722421094685 (1).json')
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const SizedBox(height: 10),
                    _buildContent(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        SizedBox(
          height: 190.0,
          child: SwiperPage(pageController: _pageController),
        ),
        Container(
          margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            'Top Picks',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Categories()));
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'Assets/images/government.png',
                              height: 30,
                            ),
                            Text(
                              'Transform Plastic Waste!',
                              style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Tutorials',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Maps()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'Assets/images/government.png',
                            height: 30,
                          ),
                          Text(
                            'Plastic Drop-off points',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'Nearby',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowAllNGOs()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'Assets/images/government.png',
                            height: 30,
                          ),
                          Text(
                            'Our NGO Partners',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'NGO',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 15.0),
        Container(
          height: 260,
          child: ActivitiesPage(),
        ),
        SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shops',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Let's Support Plastic free Shopping",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            InkWell(
              child: Text(
                'Show All',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
        SizedBox(height: 10.0),
        Container(height: 190, child: SwiperPageNew()),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                height: 40,
                width: 100,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => About()), // Remove 'const'
                    );
                  },
                  child: Center(
                      child:
                          Text('About Us', style: TextStyle(fontSize: 14.0))),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                height: 40,
                width: 100,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FeedbackPage()), // Remove 'const'
                    );
                  },
                  child: Center(
                      child:
                          Text('Contact Us', style: TextStyle(fontSize: 14.0))),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                height: 40,
                width: 100,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FAQ()));
                  },
                  child: Center(
                      child: Text('FAQs', style: TextStyle(fontSize: 14.0))),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
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
      color: Theme.of(context).colorScheme.secondary,
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Column(
              children: [
                // Text(
                //   'Plastic-free planet',
                //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                // ),
                Text(AppLocalizations.of(context)!.plasticFreePlanet),
                Text(AppLocalizations.of(context)!.startsWithYou),
                // Text(
                //   'starts with you',
                //   style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                // ),
              ],
            ),
          ),
          SizedBox(
            width: 22,
          ),
          Container(
              height: 95,
              child: Image(
                  image: AssetImage('Assets/home_images/swiper_bottle.png'))),
        ],
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Text(
                  'Small actions today,',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'for a plastic-free tomorrow',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
              height: 100,
              child: Image(
                  image: AssetImage('Assets/home_images/swiper_turtle.png'))),
        ],
      ),
    );
  }
}

class Blue extends StatelessWidget {
  const Blue({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Text(
                  'Clean Oceans,',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Brighter Future',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
              height: 120,
              child: Image(
                  image: AssetImage('Assets/home_images/swiper_water.png'))),
        ],
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
        ClipRRect(
          borderRadius:
              const BorderRadius.only(bottomRight: Radius.elliptical(800, 250)),
          child: PageView(
            controller: pageController,
            children: const [
              EventPage(),
              ContactPage(),
              Blue(),
            ],
          ),
        ),
        Positioned(
          bottom: 8.0,
          left: 20,
          // right: 100.0,
          child: Center(
            child: SmoothPageIndicator(
              controller: pageController,
              count: 3,
              effect: CustomizableEffect(
                activeDotDecoration: DotDecoration(
                  color: Colors.grey[600]!, // Active dot color
                  // size: Size(12, 12),
                  borderRadius: BorderRadius.circular(12),
                ),
                dotDecoration: DotDecoration(
                  color: Colors.grey, // Inactive dot color
                  // size: Size(8, 8),
                  borderRadius: BorderRadius.circular(8),
                ),
                spacing: 8,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildActivityContainer(String label, ImageProvider image) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.orange[200], // Background color
      borderRadius: BorderRadius.circular(10), // Rounded corners
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.transparent, // Make the container transparent
                ),
                child: Center(
                  child: Image(
                    image: image,
                    width: 35, // Image width
                    height: 35, // Image height
                  ),
                ),
              ),
            ],
          ),
        ),
        // Bottom label
        Container(
          color: Colors.blue[200], // Background color for label
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}
