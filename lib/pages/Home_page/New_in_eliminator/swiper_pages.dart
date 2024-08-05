// import 'dart:async';
// import 'package:flutter/material.dart';

// class SwiperPageNew extends StatefulWidget {
//   const SwiperPageNew({super.key});

//   @override
//   State<SwiperPageNew> createState() => _SwiperPageNewState();
// }

// class _SwiperPageNewState extends State<SwiperPageNew> {
//   final PageController _pageController = PageController();
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     _startAutoSwipe();
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

//   void _startAutoSwipe() {
//     _timer = Timer.periodic(Duration(seconds: 4), (timer) {
//       int nextPage = _pageController.page!.toInt() + 1;
//       if (nextPage >= 5) {
//         nextPage = 0;
//       }
//       _pageController.animateToPage(
//         nextPage,
//         duration: Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'New in PlasticEliminator',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Container(
//             height: 150,
//             child: PageView(
//               controller: _pageController,
//               children: [
//                 _buildPage('Upcomming Features',
//                     Theme.of(context).colorScheme.primary),
//                 _buildPage(
//                     'Page 2: Contact', Theme.of(context).colorScheme.primary),
//                 _buildPage(
//                     'Page 3: Feedback', Theme.of(context).colorScheme.primary),
//                 _buildPage(
//                     'Page 4: Tutorials', Theme.of(context).colorScheme.primary),
//                 _buildPage(
//                     'Page 5: Map', Theme.of(context).colorScheme.primary),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPage(String title, Color color) {
//     return Container(
//       color: color,
//       child: Center(
//         child: Text(
//           title,
//           style: TextStyle(fontSize: 24, color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';

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
          Text(
            'New in PlasticEliminator',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 150,
            child: PageView(
              controller: _pageController,
              children: [
                _buildPage(
                  'Upcomming Features',
                  Theme.of(context).colorScheme.primary,
                  Colors.black, // Text color for 'Upcomming Features'
                ),
                _buildPage(
                  'Upcomming Features',
                  Theme.of(context).colorScheme.primary,
                  Colors.black, // Text color for other pages
                ),
                _buildPage(
                  'Upcomming Features',
                  Theme.of(context).colorScheme.primary,
                  Colors.black, // Text color for other pages
                ),
                _buildPage(
                  'Upcomming Features',
                  Theme.of(context).colorScheme.primary,
                  Colors.black, // Text color for other pages
                ),
                _buildPage(
                  'Upcomming Features',
                  Theme.of(context).colorScheme.primary,
                  Colors.black, // Text color for other pages
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(String title, Color backgroundColor, Color textColor) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 24, color: textColor),
        ),
      ),
    );
  }
}
