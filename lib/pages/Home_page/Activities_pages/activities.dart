import 'package:flutter/material.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/calculator.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/challenge_home.dart';
// import 'package:plastic_eliminator/pages/extra_pages/game_home.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/games/games_home.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/gov_work.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/learn_pages/learn.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/news.dart';

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Activities',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _ActivityContainer(
                    text: 'Challenges',
                    imagePath: 'Assets/images/government.png',
                    destinationPage: ChallengeHome(),
                  ),
                  _ActivityContainer(
                    text: 'Government',
                    imagePath: 'Assets/images/government.png',
                    destinationPage: PlasticSectionPage(),
                  ),
                  _ActivityContainer(
                    text: 'Games',
                    imagePath: 'Assets/images/government.png',
                    destinationPage: Game_Home(),
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
                    text: 'News',
                    imagePath: 'Assets/images/government.png',
                    destinationPage: NewsPage(),
                  ),
                  _ActivityContainer(
                    text: 'Calculator',
                    imagePath: 'Assets/images/government.png',
                    destinationPage: Calculator(),
                  ),
                  _ActivityContainer(
                    text: 'Learn',
                    imagePath: 'Assets/images/government.png',
                    destinationPage: LearningsGrid(),
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

  const _ActivityContainer({
    required this.text,
    required this.imagePath,
    required this.destinationPage,
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
        width: 100,
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
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
