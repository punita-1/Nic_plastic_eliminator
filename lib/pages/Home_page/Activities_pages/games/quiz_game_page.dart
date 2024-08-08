import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizGamePage extends StatefulWidget {
  @override
  _QuizGamePageState createState() => _QuizGamePageState();
}

class _QuizGamePageState extends State<QuizGamePage> {
  List<Question> questions = [];
  int currentQuestionIndex = 0;
  int score = 0;
  Timer? _timer; 
  int _timeLeft = 60;

  final AudioPlayer _soundPlayer = AudioPlayer();
  final AudioPlayer _musicPlayer = AudioPlayer();
  bool _soundEnabled = true;
  bool _musicEnabled = true;

  @override
  void initState() {
    super.initState();
    questions = generateQuestions();
    _startTimer();
    _loadSettings();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _nextQuestion();
        }
      });
    });
  }

  void _resetTimer() {
    setState(() {
      _timeLeft = 60;
    });
  }

  void _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _soundEnabled = prefs.getBool('soundEnabled') ?? true;
      _musicEnabled = prefs.getBool('musicEnabled') ?? true;
    });
    _loadSounds();
    _playBackgroundMusic();
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('soundEnabled', _soundEnabled);
    await prefs.setBool('musicEnabled', _musicEnabled);
  }

  void _loadSounds() async {
    try {
      await _soundPlayer.setAsset('Assets/Sounds/correct.mp3');
      await _soundPlayer.setAsset('Assets/Sounds/wrong.mp3');
    } catch (e) {
      print('Error loading sound files: $e');
    }
  }

  Future<void> _playSound(String soundFileName) async {
    if (_soundEnabled) {
      try {
        await _soundPlayer.setAsset('Assets/Sounds/$soundFileName');
        _soundPlayer.play();
      } catch (e) {
        print('Error playing sound: $e');
      }
    }
  }

  void _playBackgroundMusic() async {
    if (_musicEnabled) {
      try {
        await _musicPlayer.setAsset('Assets/Sounds/music.mp3');
        _musicPlayer.setLoopMode(LoopMode.one);
        _musicPlayer.play();
      } catch (e) {
        print('Error playing background music: $e');
      }
    }
  }

  void _stopBackgroundMusic() {
    _musicPlayer.stop();
  }

  void _toggleBackgroundMusic() {
    setState(() {
      _musicEnabled = !_musicEnabled;
      if (_musicEnabled) {
        _playBackgroundMusic();
      } else {
        _stopBackgroundMusic();
      }
      _saveSettings();
    });
  }

  void _nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        _resetTimer();
      } else {
        _endGame();
      }
    });
  }

  void _endGame() {
    _timer?.cancel();
    _showSnackBar('Game Over! Your Score: $score');
  }

  void _checkAnswer(int selectedOption) {
    if (questions[currentQuestionIndex].correctOption == selectedOption) {
      _playSound('correct.mp3');
      setState(() {
        score++;
      });
    } else {
      _playSound('wrong.mp3');
    }
    _nextQuestion();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _soundPlayer.dispose();
    _musicPlayer.dispose();
    super.dispose();
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
        actions: [
          IconButton(
            icon: Icon(
              _musicEnabled ? Icons.music_note : Icons.music_off,
            ),
            onPressed: _toggleBackgroundMusic,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display score and timer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Score: $score',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Time: $_timeLeft',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              questions[currentQuestionIndex].question,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Column(
              children: questions[currentQuestionIndex].options.map((option) {
                int index =
                    questions[currentQuestionIndex].options.indexOf(option);
                return ElevatedButton(
                  onPressed: () => _checkAnswer(index),
                  child: Text(option, style: TextStyle(color: Colors.teal),),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  List<Question> generateQuestions() {
    return [
      Question(
        question: 'What is the capital of France?',
        options: ['Berlin', 'Madrid', 'Paris', 'Rome'],
        correctOption: 2,
      ),
      Question(
        question: 'Who wrote "To Kill a Mockingbird"?',
        options: [
          'Harper Lee',
          'Mark Twain',
          'Ernest Hemingway',
          'F. Scott Fitzgerald'
        ],
        correctOption: 0,
      ),
      Question(
        question: 'What is the chemical symbol for Hydrogen?',
        options: ['H', 'O', 'N', 'C'],
        correctOption: 0,
      ),
      // Add more questions here
    ];
  }
}

class Question {
  final String question;
  final List<String> options;
  final int correctOption;

  Question({
    required this.question,
    required this.options,
    required this.correctOption,
  });
}
