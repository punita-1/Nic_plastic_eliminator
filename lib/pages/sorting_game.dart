import 'package:flutter/material.dart';
import 'dart:async';

class SortingGame extends StatefulWidget {
  @override
  _SortingGameState createState() => _SortingGameState();
}

class _SortingGameState extends State<SortingGame> {
  final List<String> items = ['Plastic Bottle', 'Paper', 'Glass', 'Metal Can'];
  final List<String> recyclable = ['Plastic Bottle', 'Paper', 'Glass', 'Metal Can'];
  List<String> currentList = [];
  int score = 0;
  Timer? _timer;
  int _start = 120; // 2 minutes

  @override
  void initState() {
    super.initState();
    currentList = List.from(items)..shuffle();
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            showFinalScore();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  void checkItem(String item) {
    if (recyclable.contains(item)) {
      setState(() {
        score++;
        currentList.remove(item);
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Correct!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wrong!')));
    }

    if (currentList.isEmpty) {
      _timer?.cancel();
      showFinalScore();
    }
  }

  void showFinalScore() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Time's Up!"),
          content: Text('Your final score is $score'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sorting Game'),
      ),
      body: Column(
        children: [
          Text('Score: $score', style: TextStyle(fontSize: 24)),
          Text('Time Left: $_start seconds', style: TextStyle(fontSize: 24)),
          Expanded(
            child: ListView.builder(
              itemCount: currentList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(currentList[index]),
                  onTap: () => checkItem(currentList[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
