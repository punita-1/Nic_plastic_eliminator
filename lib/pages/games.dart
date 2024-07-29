import 'package:flutter/material.dart';
import 'package:plastic_eliminator/pages/game_quiz.dart';
// import 'quiz_game.dart';
import 'sorting_game.dart';

class Games extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Games'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Quiz Game'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizGame()),
              );
            },
          ),
          ListTile(
            title: Text('Sorting Game'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlasticSortingGame()),
              );
            },
          ),
        ],
      ),
    );
  }
}
