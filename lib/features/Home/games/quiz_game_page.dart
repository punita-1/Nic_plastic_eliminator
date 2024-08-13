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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => _checkAnswer(index),
                    child: Text(option),
                  ),
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
        question:
            'What percentage of plastic waste is actually recycled globally?',
        options: ['9%', '30%', '50%', '70%'],
        correctOption: 0,
      ),
      Question(
        question:
            'What is the most commonly found type of plastic waste in the ocean?',
        options: [
          'Plastic bottles',
          'Plastic bags',
          'Cigarette butts',
          'Plastic straws'
        ],
        correctOption: 2,
      ),
      Question(
        question: 'How long does it take for a plastic bottle to decompose?',
        options: ['10 years', '100 years', '450 years', '1,000 years'],
        correctOption: 2,
      ),
      Question(
        question: 'Which country produces the most plastic waste?',
        options: ['China', 'United States', 'India', 'Brazil'],
        correctOption: 1,
      ),
      Question(
        question:
            'What is the main reason for the low rate of plastic recycling?',
        options: [
          'High cost of recycling',
          'Lack of recycling facilities',
          'Contamination of plastic waste',
          'All of the above'
        ],
        correctOption: 3,
      ),
      Question(
        question:
            'Which of the following is a major environmental impact of microplastics?',
        options: [
          'Water pollution',
          'Harm to marine life',
          'Entering the food chain',
          'All of the above'
        ],
        correctOption: 3,
      ),
      Question(
        question: 'What is a common alternative to single-use plastic bags?',
        options: ['Paper bags', 'Metal bags', 'Glass bags', 'Plastic bags'],
        correctOption: 0,
      ),
      Question(
        question:
            'Which of these items is a significant contributor to plastic waste?',
        options: [
          'Disposable cutlery',
          'Wooden spoons',
          'Glass bottles',
          'Ceramic plates'
        ],
        correctOption: 0,
      ),
      Question(
        question:
            'What initiative encourages the reduction of plastic straw usage?',
        options: [
          'Strawless Ocean',
          'Plastic-Free July',
          'The Straw Ban',
          'Clean Seas'
        ],
        correctOption: 0,
      ),
      Question(
        question:
            'Which material is often proposed as a sustainable alternative to plastic packaging?',
        options: [
          'Biodegradable plastics',
          'Aluminum',
          'Cardboard',
          'All of the above'
        ],
        correctOption: 3,
      ),
      Question(
        question:
            'What type of plastic is most commonly used for water bottles?',
        options: [
          'Polyethylene Terephthalate (PET)',
          'Polyvinyl Chloride (PVC)',
          'Polystyrene (PS)',
          'Polypropylene (PP)'
        ],
        correctOption: 0,
      ),
      Question(
        question:
            'Which organization leads the global campaign "Break Free From Plastic"?',
        options: [
          'Greenpeace',
          'World Wildlife Fund (WWF)',
          'Ocean Conservancy',
          'United Nations'
        ],
        correctOption: 0,
      ),
      Question(
        question:
            'What is the Great Pacific Garbage Patch primarily composed of?',
        options: ['Wood debris', 'Fishing nets', 'Plastic waste', 'Metal cans'],
        correctOption: 2,
      ),
      Question(
        question:
            'What is the main component of microbeads found in some personal care products?',
        options: ['Polyethylene', 'Polypropylene', 'Nylon', 'Polystyrene'],
        correctOption: 0,
      ),
      Question(
        question: 'How much plastic waste enters the oceans each year?',
        options: [
          '1 million tons',
          '5 million tons',
          '8 million tons',
          '12 million tons'
        ],
        correctOption: 2,
      ),
      // Add more questions as needed
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
