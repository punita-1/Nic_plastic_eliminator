import 'package:flutter/material.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/calculator/calculator.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/challenge_home.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/games/games_home.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/gov_work.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/learn_pages/learn.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/news.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Correct localization import

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations =
        AppLocalizations.of(context)!; // Use the localization instance

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.activities,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _ActivityContainer(
                    text: localizations.challenges,
                    imagePath: 'Assets/images/challenge.png',
                    destinationPage: ChallengeHome(),
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
                height: 15,
              ),
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
                    destinationPage: Calculator(),
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

class _ActivityContainer extends StatelessWidget {
  final String text;
  final String imagePath;
  final Widget destinationPage;
  final TextStyle textStyle;
  final TextAlign textAlign;

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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child: Container(
        height: 100,
        width: 150,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 50,
              width: 50,
            ),
            SizedBox(height: 8),
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
