import 'package:flutter/material.dart';
import 'package:plastic_eliminator/features/Home/games/quiz_game_page.dart';
import 'package:plastic_eliminator/features/Home/games/sortinggame.dart';
// import 'package:plastic_eliminator/pages/Activities_pages/games/quiz_game_page.dart';
// import 'package:plastic_eliminator/pages/Activities_pages/games/sortinggame.dart';

class Game_Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Games',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GameBox(
              title: 'Quiz Game',
              icon: Icons.quiz,
              color: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizGamePage(),
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            GameBox(
              title: 'Sorting Game',
              icon: Icons.sort,
              color: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SortingGamePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GameBox extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  GameBox({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                // color: Colors.white,
              ),
              SizedBox(height: 5),
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  // color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
