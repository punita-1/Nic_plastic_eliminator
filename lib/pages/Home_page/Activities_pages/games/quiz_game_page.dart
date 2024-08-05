import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class QuizGamePage extends StatefulWidget {
  const QuizGamePage({super.key});

  @override
  State<QuizGamePage> createState() => _QuizGamePageState();
}

class _QuizGamePageState extends State<QuizGamePage> {
  int currentQuestion = 0;
  int score = 0;
  List<Question> questions = generateQuestions();
  Timer? _timer;
  int _remainingTime = 60; // 60 seconds for the timer
  late AudioPlayer _backgroundMusicPlayer;
  final AudioCache _audioCache = AudioCache();

  @override
  void initState() {
    super.initState();
    _startTimer();
    _playBackgroundMusic();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
          _showScoreDialog();
        }
      });
    });
  }

  void _playBackgroundMusic() async {
    try {
      final player = AudioPlayer();
      player.setReleaseMode(ReleaseMode.loop);
      await player.setSource(AssetSource('Assets/Sounds/music.mp3'));
      await player.resume();
      _backgroundMusicPlayer = player;
    } catch (e) {
      print('Error playing background music: $e');
    }
  }

  Future<void> _playSound(String soundFileName) async {
    try {
      final player = AudioPlayer();
      await player.setSource(AssetSource('Assets/Sounds/$soundFileName'));
      await player.resume();
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  void _answerQuestion(int selectedOption) async {
    try {
      if (questions[currentQuestion].correctOption == selectedOption) {
        score++;
        await _playSound('correct.mp3');
      } else {
        await _playSound('wrong.mp3');
      }
      setState(() {
        if (currentQuestion < questions.length - 1) {
          currentQuestion++;
        } else {
          _timer?.cancel();
          _showScoreDialog();
        }
      });
    } catch (e) {
      print('Error answering question: $e');
    }
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quiz Completed'),
        content: Text('Your score is $score/${questions.length}'),
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
        title: Text(
          'Quiz Game',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Time Remaining: $_remainingTime seconds',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              questions[currentQuestion].questionText,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            for (int i = 0; i < 3; i++)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: getPastelColor(i),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  _answerQuestion(i);
                  _showAnswerDialog(
                    questions[currentQuestion].options[i],
                    questions[currentQuestion].correctOption == i,
                  );
                },
                child: Text(
                  questions[currentQuestion].options[i],
                  style: TextStyle(color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showAnswerDialog(String selectedOption, bool isCorrect) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isCorrect ? 'Correct!' : 'Wrong!'),
        content: Text('You selected: $selectedOption'),
        actions: [
          TextButton(
            onPressed: () {
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

  Color getPastelColor(int index) {
    List<Color> pastelColors = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
    return pastelColors[index % pastelColors.length];
  }

  @override
  void dispose() {
    _timer?.cancel();
    _backgroundMusicPlayer.dispose();
    super.dispose();
  }
}

class Question {
  final String questionText;
  final List<String> options;
  final int correctOption;

  Question({
    required this.questionText,
    required this.options,
    required this.correctOption,
  });
}

List<Question> generateQuestions() {
  return [
    Question(
      questionText: 'Which of the following is biodegradable?',
      options: ['Plastic Bag', 'Apple Core', 'Styrofoam Cup'],
      correctOption: 1,
    ),
    Question(
      questionText: 'Which material takes the longest to decompose?',
      options: ['Glass', 'Paper', 'Food Waste'],
      correctOption: 0,
    ),
    // Add more questions as needed
  ];
}
