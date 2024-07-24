// import 'package:flutter/material.dart';
// import 'package:plastic_eliminator/pages/game_quiz.dart';
// // import 'quiz_game.dart';  // Import the QuizGame screen

// class GamesList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Games List'),
//       ),
//       body: ListView(
//         children: [
//           ListTile(
//             title: Text('Plastic Eradication Quiz'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => QuizGame()),
//               );
//             },
//           ),
//           // Add more games here in a similar manner
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
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
                MaterialPageRoute(builder: (context) => SortingGame()),
              );
            },
          ),
          ListTile(
            title: Text('Sorting Game'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SortingGame()),
              );
            },
          ),
        ],
      ),
    );
  }
}
