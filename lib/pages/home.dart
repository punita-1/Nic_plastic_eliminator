import 'package:flutter/material.dart';
import 'package:plastic_eliminator/pages/calculator.dart';
import 'package:plastic_eliminator/pages/events.dart';
import 'package:plastic_eliminator/pages/games.dart';
// import 'package:plastic_eliminator/pages/challenge_type.dart';
import 'package:plastic_eliminator/services/shared_pref.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? name, image;

  Future<void> getthedatafromsharedpref() async {
    name = await SharedPreferanceHelper().getUserName();
    image = await SharedPreferanceHelper().getUserImage();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getthedatafromsharedpref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F1F1),
      body: Container(
        margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                      Text(
                        name ?? 'Loading...',
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: image != null
                        ? Image.network(
                            'https://user-images.githubusercontent.com/55682574/146731502-9f57b365-6375-4d16-9344-2bc471386c7d.png',
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'Assets/images/girl_profile.png',
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              const Divider(),
              const SizedBox(height: 10),
              const Text(
                'Activities',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15.0),
              // Ensure ListView has bounded height
              SizedBox(
                height: 200.0, // Adjust height as needed
                child: SwiperPage(),
              ),
              Text(
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
                // widget:20,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: 165,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('Assets/images/challenges_home.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // height: 20,
                      // color: Colors.black,
                      child: Center(
                        child: Text(
                          'Challenges',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Games()));
                      },
                      child: Container(
                        width: 165,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('Assets/images/games_home.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Games',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 165,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('Assets/images/newspaper_home.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // height: 20,
                      // color: Colors.black,
                      child: Center(
                        child: Text(
                          'News',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CalculatorPage()));
                      },
                      child: Container(
                        width: 165,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('Assets/images/calculator_home.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // height: 20,
                        // color: Colors.black,

                        child: Center(
                          child: Text(
                            'Impact Calculator',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 165,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('Assets/images/learn_home.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // height: 20,
                      // color: Colors.black,
                      child: Center(
                        child: Text(
                          'Learnings',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 165,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('Assets/images/government_home.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // height: 20,
                      // color: Colors.black,
                      child: Center(
                        child: Text(
                          'Goverment',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shops',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Show All',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff7469B6),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              SizedBox(
                height: 90.0,
                // widget:20,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: 60, // Adjusted width to fit text
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60, // Adjusted height for better layout
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'Assets/images/shop1_home.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(100),
                              color: Color(0xffAD88C6),
                            ),
                          ),
                          SizedBox(height: 8), // Space between image and text
                          Text(
                            'Shop 1', // Your text here
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 60, // Adjusted width to fit text
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60, // Adjusted height for better layout
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'Assets/images/shop1_home.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(100),
                              color: Color(0xffAD88C6),
                            ),
                          ),
                          SizedBox(height: 8), // Space between image and text
                          Text(
                            'Shop 1', // Your text here
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 60, // Adjusted width to fit text
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60, // Adjusted height for better layout
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'Assets/images/shop1_home.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(100),
                              color: Color(0xffAD88C6),
                            ),
                          ),
                          SizedBox(height: 8), // Space between image and text
                          Text(
                            'Shop 1', // Your text here
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 60, // Adjusted width to fit text
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60, // Adjusted height for better layout
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'Assets/images/shop1_home.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(100),
                              color: Color(0xffAD88C6),
                            ),
                          ),
                          SizedBox(height: 8), // Space between image and text
                          Text(
                            'Shop 1', // Your text here
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 60, // Adjusted width to fit text
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60, // Adjusted height for better layout
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'Assets/images/shop1_home.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(100),
                              color: Color(0xffAD88C6),
                            ),
                          ),
                          SizedBox(height: 8), // Space between image and text
                          Text(
                            'Shop 1', // Your text here
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 60, // Adjusted width to fit text
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60, // Adjusted height for better layout
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'Assets/images/shop1_home.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(100),
                              color: Color(0xffAD88C6),
                            ),
                          ),
                          SizedBox(height: 8), // Space between image and text
                          Text(
                            'Shop 1', // Your text here
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}

class SwiperPage extends StatefulWidget {
  @override
  _SwiperPageState createState() => _SwiperPageState();
}

class _SwiperPageState extends State<SwiperPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('Assets/images/events_home.jpg'),
                    fit: BoxFit.cover,
                  ),
                  color: Color(0xff7469B6),
                ),
                width: 20,
                height: 150,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't miss out on the fun and\n the chance to be rewarded",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Register Now!',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Events()));
                            },
                            child: Text('Events'))
                      ],
                    ),
                  ],
                )),
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('Assets/images/plastic_home.jpg'),
                    fit: BoxFit.cover,
                  ),
                  color: Color(0xff7469B6),
                ),
                width: 20,
                height: 150,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Got plastic waste at home?\n Submit it through our app.",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          ' Start your journey towards a plastic-free life. ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        ElevatedButton(
                            onPressed: () {}, child: Text('Got plastic?'))
                      ],
                    ),
                  ],
                )),
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('Assets/images/contact_us.jpg'),
                    fit: BoxFit.cover,
                  ),
                  color: Color(0xff7469B6),
                ),
                width: 20,
                height: 150,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Got queries, feedback or need \nassistance our team is here to help.",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          ' Contact us',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        ElevatedButton(
                            onPressed: () {}, child: Text('Got plastic?'))
                      ],
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        SmoothPageIndicator(
          controller: _pageController,
          count: 3,
          effect: ExpandingDotsEffect(
            activeDotColor: Color(0xff7469B6),
            dotColor: Colors.grey,
            dotHeight: 8,
            dotWidth: 8,
            spacing: 16,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
