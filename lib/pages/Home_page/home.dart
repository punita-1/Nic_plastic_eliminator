import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:plastic_eliminator/pages/Home_page/quotes.dart';
import 'package:plastic_eliminator/pages/clubs.dart';
import 'package:plastic_eliminator/pages/profile_page/leader_board.dart';
import 'package:plastic_eliminator/pages/profile_page/profile.dart';
import 'package:plastic_eliminator/themes/theme_provider.dart';
import 'package:share/share.dart';
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
// import 'package:plastic_eliminator/pages/tutorial_page/tutorial.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:plastic_eliminator/pages/Home_page/shops_page/allshops.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/news.dart';
import 'package:plastic_eliminator/pages/Home_page/shops_page/shoplist.dart';
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
      home: const Home(),
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

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      int nextPage = (_pageController.page ?? 0).round() + 1;
      if (nextPage >= 3) {
        nextPage = 0;
      }
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 200),
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open the drawer
              },
            );
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 10.0),
            Text(
              AppLocalizations.of(context)!.plasticEliminator,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.language, color: Colors.white),
                          onPressed: () {
                            // Toggle between English and Hindi
                            final newLocale = context
                                        .read<LocaleNotifier>()
                                        .locale
                                        .languageCode ==
                                    'en'
                                ? Locale('hi')
                                : Locale('en');
                            context.read<LocaleNotifier>().setLocale(newLocale);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        Container(
          height: 260, // Adjust height as needed
          color: Theme.of(context).colorScheme.secondary,
          child: DrawerHeader(
            margin: EdgeInsets.zero, // Remove default margin
            padding: EdgeInsets.all(16.0), // Adjust padding if needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      photoURL ?? 'https://via.placeholder.com/150'),
                  backgroundColor: Colors.grey[200],
                ),
                SizedBox(height: 15),
                // SizedBox(height: 16), // Add spacing if needed
                Text(
                  userName ?? 'User',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 16, // Adjust font size as needed
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Add spacing if needed
                Text(
                  email ?? 'Email not available',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 14, // Adjust font size as needed
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // SizedBox(height: 16), // Add spacing if needed
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Profile(), // Navigate to the Profile page
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.visitProfile,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 15,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LeaderboardPage(),
              ),
            );
          },
          title: Container(
            margin: EdgeInsets.only(right: 20),
            child: Row(
              children: [
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.leaderBoard,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        AppLocalizations.of(context)!.getInTouchWithUs,
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.list)
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Club()));
          },
          title: Container(
            margin: EdgeInsets.only(right: 20),
            child: Row(
              children: [
                SizedBox(width: 10), // Adds space between the image and text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.clubs,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        AppLocalizations.of(context)!.joinClubsMakeADifference,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.group)
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ShowAllNGOs()));
          },
          title: Container(
            margin: EdgeInsets.only(right: 20),
            child: Row(
              children: [
                SizedBox(width: 10), // Adds space between the image and text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.ngo,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        AppLocalizations.of(context)!.ourNGOPartners,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
                Icon(Icons.handshake)
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsPage(),
              ),
            );
          },
          title: Container(
            margin: EdgeInsets.only(right: 20),
            child: Row(
              children: [
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.news,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        AppLocalizations.of(context)!.getInTouchWithUs,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
                Icon(Icons.pages)
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LearningsGrid(),
              ),
            );
          },
          title: Container(
            margin: EdgeInsets.only(right: 20),
            child: Row(
              children: [
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.learning,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        AppLocalizations.of(context)!.getInTouchWithUs,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.book_outlined)
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => About(),
              ),
            );
          },
          title: Container(
            margin: EdgeInsets.only(right: 20),
            child: Row(
              children: [
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.aboutUs,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        AppLocalizations.of(context)!.getInTouchWithUs,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
                Icon(Icons.help_center_outlined)
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          onTap: () {
            themeProvider.toggleTheme();
          },
          title: Container(
            margin: EdgeInsets.only(right: 20),
            child: Row(
              children: [
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.toggleTheme,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        AppLocalizations.of(context)!
                            .switchBetweenLightAndDarkMode,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
                Icon(Icons.brightness_6),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          onTap: () {
            final appLink = 'https://example.com'; // Placeholder URL
            Share.share('Check out this app: $appLink');
          },
          title: Container(
            margin: EdgeInsets.only(right: 20),
            child: Row(
              children: [
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.share,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        AppLocalizations.of(context)!.shareThisAppWithOthers,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
                Icon(Icons.share)
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FAQ(),
              ),
            );
          },
          title: Container(
            margin: EdgeInsets.only(right: 20),
            child: Row(
              children: [
                SizedBox(
                    width:
                        10), // Adds space between the icon and text if needed
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.faqs,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        AppLocalizations.of(context)!.getInTouchWithUs,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
                Icon(Icons.question_answer)
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FeedbackPage(),
              ),
            );
          },
          title: Container(
            margin: EdgeInsets.only(right: 20),
            child: Row(
              children: [
                SizedBox(width: 10), // Adds space between the image and text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.contactUs,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        AppLocalizations.of(context)!.getInTouchWithUs,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
                Icon(Icons.call)
              ],
            ),
          ),
        ),
        SizedBox(
          height: 18,
        ),
      ])),
      body: Container(
        // margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _buildHeader(),
              Column(
                children: [
                  _buildHeader(),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(20))),
                    child: Stack(
                      children: [
                        Container(
                          color: Theme.of(context).colorScheme.secondary,
                          height: 150,
                          width: 500,
                        ),
                        Column(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Text(
                                    AppLocalizations.of(context)!
                                        .joinEventsToEarnRewards,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  )),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .moreThanMillionsOfIndians,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    width: 390,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          bottomRight: Radius.circular(50)),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    padding: const EdgeInsets.all(10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Events()));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            // crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .events,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(AppLocalizations.of(
                                                          context)!
                                                      .getInvolvedInEvents),
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .andWinRewards,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 100,
                                            child: Lottie.asset(
                                                'Animations/Animation1.json'),
                                          )
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
                      ],
                    ),
                  ),
                ],
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
          height: 160.0,
          child: SwiperPage(pageController: _pageController),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width, // Full width of the screen
          height: 57, // Fixed height
          child: QuotesWidget(),
        ),
        SizedBox(height: 10.0),
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
                  AppLocalizations.of(context)!.shops,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 3,
                ),
              ],
            ),
            InkWell(
              child: Text(
                AppLocalizations.of(context)!.showAll,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
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
        Text(
          AppLocalizations.of(context)!.letsSupportPlasticFreeShopping,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 15.0),
        ShopList(),
        SizedBox(height: 10.0),
        Container(height: 190, child: SwiperPageNew()),
        SizedBox(
          height: 10,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(
          //   width: 20,
          // ),
          Container(
              // margin: EdgeInsets.only(top: 10),
              child: Text(
            AppLocalizations.of(context)!.discoverExcitingEventsPlus,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          )),
          SizedBox(
            width: 10,
          ),
          Container(
              height: 95,
              child:
                  Image(image: AssetImage('Assets/logo_image/onboardin1.png'))),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!
                .bePartOfClubsCommittedToReducingPlasticWaste,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: 10,
          ),
          Container(
              height: 100,
              child:
                  Image(image: AssetImage('Assets/logo_image/onboard2.png'))),
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
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.greenYourShopping +
                '\n' +
                AppLocalizations.of(context)!.discoverPlasticFreeBrands,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: 10,
          ),
          Container(
              height: 120,
              child: Image(
                  image: AssetImage('Assets/logo_image/onboarding3.png'))),
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
          child: PageView(
            controller: pageController,
            scrollDirection: Axis.vertical,
            children: const [
              EventPage(),
              ContactPage(),
              Blue(),
            ],
          ),
        ),
      ],
    );
  }
}
