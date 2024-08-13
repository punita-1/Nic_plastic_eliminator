import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:plastic_eliminator/features/Home/calculator/calculator.dart';
import 'package:plastic_eliminator/features/Home/challenge_home.dart';
import 'package:plastic_eliminator/features/Home/games/games_home.dart';
import 'package:plastic_eliminator/features/Home/gov_work.dart'; // Correct localization import

/// A screen that displays various activities available in the app.
///
/// This page uses a [Column] layout to present different activities with corresponding images
/// and navigation options. Activities are displayed in a grid format using rows.
class ActivitiesPage extends StatelessWidget {
  /// Creates an instance of [ActivitiesPage].
  const ActivitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the localization instance for this context
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      // The body of the scaffold contains the main content of the activities page
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title of the activities page, localized
          Text(
            localizations.activities,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          // Container for activity items arranged in rows
          Column(
            children: [
              // First row of activity items
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _ActivityContainer(
                    text: 'Tips and Tricks',
                    imagePath: 'Assets/images/challenge.png',
                    destinationPage: PlasticReductionTipsPage(),
                    textStyle: Theme.of(context).textTheme.bodyLarge!,
                    textAlign: TextAlign.center,
                  ),
                  _ActivityContainer(
                    text: localizations.government,
                    imagePath: 'Assets/images/government.png',
                    destinationPage: PlasticSectionPage(),
                    textStyle: Theme.of(context).textTheme.bodyLarge!,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              // Second row of activity items
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _ActivityContainer(
                    text: localizations.games,
                    imagePath: 'Assets/images/console.png',
                    destinationPage: Game_Home(),
                    textStyle: Theme.of(context).textTheme.bodyLarge!,
                    textAlign: TextAlign.center,
                  ),
                  _ActivityContainer(
                    text: localizations.calculator,
                    imagePath: 'Assets/images/calculator.png',
                    destinationPage: PlasticItemScreen(),
                    textStyle: Theme.of(context).textTheme.bodyLarge!,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A container widget for displaying an activity item with an image and text.
///
/// This widget is used to present an individual activity within the [ActivitiesPage].
/// When tapped, it navigates to the specified [destinationPage].
class _ActivityContainer extends StatelessWidget {
  /// The text to display in the container.
  final String text;

  /// The path to the image asset for the container.
  final String imagePath;

  /// The page to navigate to when the container is tapped.
  final Widget destinationPage;

  /// The style of the text displayed in the container.
  final TextStyle textStyle;

  /// The alignment of the text within the container.
  final TextAlign textAlign;

  /// Creates an instance of [_ActivityContainer].
  const _ActivityContainer({
    required this.text,
    required this.imagePath,
    required this.destinationPage,
    required this.textStyle,
    required this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Navigate to the destination page when the container is tapped
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child: Container(
        height: 90,
        width: 162,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the image asset
            Image.asset(
              imagePath,
              height: 40,
              width: 40,
            ),
            SizedBox(height: 8),
            // Display the text with the specified style and alignment
            Text(
              text,
              style: textStyle,
              textAlign: textAlign,
            ),
          ],
        ),
      ),
    );
  }
}
