import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/games/quiz_game_page.dart';

class Game_Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.teal[100]!,
        title: Text(
          'Games',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GameBox(
              title: 'Quiz Game',
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
            SizedBox(
              height: 15,
            ),
            GameBox(
              title: 'Sorting Game',
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
  final Color color;
  final VoidCallback onTap;

  GameBox({required this.title, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}




//other game

class SortingGamePage extends StatefulWidget {
  @override
  _SortingGamePageState createState() => _SortingGamePageState();
}

class _SortingGamePageState extends State<SortingGamePage> {
  List<String> items = generateSortingItems();
  Map<String, String?> itemLocations = {};
  Map<String, bool> results = {};
  int score = 0;

  @override
  void initState() {
    super.initState();
    // Initialize itemLocations with the original positions of items.
    for (var item in items) {
      itemLocations[item] = 'original';
    }
  }

  void _checkResult() {
    score = results.values.where((result) => result).length;
    _showScoreDialog();
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sorting Completed'),
        content: Text('Your score is $score/${items.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              'OK',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.teal[100]!,
        title: Text(
          'Sorting Game',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  String item = items[index];
                  return Draggable<String>(
                    data: item,
                    onDragCompleted: () {
                      setState(() {
                        itemLocations[item] = null; // Clear item after dragging
                      });
                    },
                    child: ItemBox(
                      text: itemLocations[item] != null ? item : '',
                    ),
                    feedback: Material(
                      child: ItemBox(text: item),
                    ),
                    childWhenDragging: ItemBox(text: ''),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DragTarget<String>(
                  onAccept: (data) {
                    setState(() {
                      itemLocations[data] = 'biodegradable';
                      results[data] = isBiodegradable(data);
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey,
                      ),
                      height: 100,
                      width: 150,
                      child: Center(child: Text('Biodegradable')),
                    );
                  },
                ),
                DragTarget<String>(
                  onAccept: (data) {
                    setState(() {
                      itemLocations[data] = 'non-biodegradable';
                      results[data] = !isBiodegradable(data);
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey,
                      ),
                      child: Center(child: Text('Non-Biodegradable')),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // backgroundColor: Colors.purple[100], // Set the button color if needed
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      8.0), // Adjust this value for less curve
                ),
              ),
              onPressed: _checkResult,
              child: Text(
                'Check Score',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isBiodegradable(String item) {
    List<String> biodegradableItems = [
      'Apple Core',
      'Banana Peel',
      'Paper',
      'Cotton Cloth',
      'Leaves'
    ];
    return biodegradableItems.contains(item);
  }
}

class ItemBox extends StatelessWidget {
  final String text;

  ItemBox({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 100,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: text.isEmpty ? Colors.grey[300] : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: Text(text)),
    );
  }
}

List<String> generateSortingItems() {
  return [
    'Apple Core',
    'Plastic Bottle',
    'Banana Peel',
    'Glass Bottle',
    'Paper',
    'Styrofoam Cup',
    'Cotton Cloth',
    'Plastic Bag',
    'Leaves',
    'Food Waste'
  ];
}
