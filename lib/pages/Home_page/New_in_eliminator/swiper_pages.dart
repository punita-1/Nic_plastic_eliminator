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
//             style: Theme.of(context).textTheme.bodyLarge,
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Container(
//             height: 150,
//             child: PageView(
//               controller: _pageController,
//               children: [
//                 _buildPage(
//                   'Upcomming Features',
//                   Theme.of(context).colorScheme.primary,
//                   Colors.black, // Text color for 'Upcomming Features'
//                 ),
//                 _buildPage(
//                   'Upcomming Features',
//                   Theme.of(context).colorScheme.primary,
//                   Colors.black, // Text color for other pages
//                 ),
//                 _buildPage(
//                   'Upcomming Features',
//                   Theme.of(context).colorScheme.primary,
//                   Colors.black, // Text color for other pages
//                 ),
//                 _buildPage(
//                   'Upcomming Features\nAchievements',
//                   Theme.of(context).colorScheme.primary,
//                   Colors.black, // Text color for other pages
//                 ),
//                 _buildPage(
//                   'Upcomming Features\nSccaner',
//                   Theme.of(context).colorScheme.primary,
//                   Colors.black, // Text color for other pages
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPage(String title, Color backgroundColor, Color textColor) {
//     return Container(
//       color: backgroundColor,
//       child: Center(
//         child: Text(
//           title,
//           style: Theme.of(context).textTheme.bodyLarge,
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import for localization

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
    final localizations =
        AppLocalizations.of(context)!; // Use the localization instance

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                localizations.plasticEliminator,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              Text(
                localizations.newInPlasticEliminator,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
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
                  localizations.upcomingFeatures,
                  Theme.of(context).colorScheme.primary,
                  Colors.black,
                ),
                _buildPage(
                  localizations.upcomingFeatures,
                  Theme.of(context).colorScheme.primary,
                  Colors.black,
                ),
                _buildPage(
                  localizations.upcomingFeatures,
                  Theme.of(context).colorScheme.primary,
                  Colors.black,
                ),
                _buildPage(
                  localizations.upcomingFeaturesAchievements,
                  Theme.of(context).colorScheme.primary,
                  Colors.black,
                ),
                _buildPage(
                  localizations.upcomingFeaturesScanner,
                  Theme.of(context).colorScheme.primary,
                  Colors.black,
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
          style:
              Theme.of(context).textTheme.bodyLarge?.copyWith(color: textColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
