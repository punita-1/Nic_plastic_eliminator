import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class QuizGame extends StatefulWidget {
  @override
  _QuizGameState createState() => _QuizGameState();
}

class _QuizGameState extends State<QuizGame> {
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Which one is recyclable?',
      'answers': ['Plastic Bags', 'Plastic Bottles', 'Styrofoam', 'All of these'],
      'correctAnswer': 'Plastic Bottles'
    },
    {
      'question': 'Which country is suffering from too much plastic pollution?',
      'answers': ['USA', 'India', 'China', 'All of these'],
      'correctAnswer': 'All of these'
    },
    {
      'question': 'Which of the following is a plastic waste management method?',
      'answers': ['Recycling', 'Burning', 'Dumping in ocean', 'All of these'],
      'correctAnswer': 'Recycling'
    },
    {
      'question': 'How long does it take for plastic to decompose?',
      'answers': ['10 years', '50 years', '100 years', '450 years'],
      'correctAnswer': '450 years'
    },
    {
      'question': 'What is the Great Pacific Garbage Patch primarily composed of?',
      'answers': ['Metal', 'Glass', 'Plastic', 'Organic Waste'],
      'correctAnswer': 'Plastic'
    },
    {
      'question': 'Which of these can help reduce plastic waste?',
      'answers': ['Using reusable bags', 'Recycling', 'Avoiding single-use plastics', 'All of these'],
      'correctAnswer': 'All of these'
    },
    {
      'question': 'What is a common source of microplastics in the ocean?',
      'answers': ['Fishing nets', 'Plastic bottles', 'Cosmetic products', 'All of these'],
      'correctAnswer': 'All of these'
    },
    {
      'question': 'What percentage of plastic is actually recycled worldwide?',
      'answers': ['Less than 10%', '25%', '50%', '75%'],
      'correctAnswer': 'Less than 10%'
    },
    {
      'question': 'Which organization is known for its work against plastic pollution?',
      'answers': ['Greenpeace', 'NASA', 'WHO', 'UNICEF'],
      'correctAnswer': 'Greenpeace'
    },
    {
      'question': 'What is the most effective way to reduce plastic pollution?',
      'answers': ['Recycling', 'Reducing plastic use', 'Cleaning beaches', 'Using more plastic'],
      'correctAnswer': 'Reducing plastic use'
    },
  ];

  late List<Map<String, dynamic>> _shuffledQuestions;
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isAnswered = false;
  String _selectedAnswer = '';
  int _timer = 30;
  late Timer _countdownTimer;

  @override
  void initState() {
    super.initState();
    _shuffledQuestions = List.from(_questions)..shuffle(Random());
    _startTimer();
  }

  void _startTimer() {
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timer > 0) {
        setState(() {
          _timer--;
        });
      } else {
        _nextQuestion();
      }
    });
  }

  void _stopTimer() {
    _countdownTimer.cancel();
  }

  void _nextQuestion() {
    if (_isAnswered) {
      if (_selectedAnswer == _shuffledQuestions[_currentQuestionIndex]['correctAnswer']) {
        _score++;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Correct!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Wrong! The correct answer is ${_shuffledQuestions[_currentQuestionIndex]['correctAnswer']}.')),
        );
      }
    }

    if (_currentQuestionIndex < _shuffledQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _isAnswered = false;
        _selectedAnswer = '';
        _timer = 30;
        _startTimer();
      });
    } else {
      _stopTimer();
      _showScoreDialog();
    }
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quiz Completed'),
        content: Text('You scored $_score out of ${_shuffledQuestions.length}'),
        actions: [
          TextButton(
            child: Text('Restart'),
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _shuffledQuestions = List.from(_questions)..shuffle(Random());
                _currentQuestionIndex = 0;
                _score = 0;
                _isAnswered = false;
                _selectedAnswer = '';
                _timer = 30;
                _startTimer();
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plastic Eradication Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Score: $_score',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              'Time Left: $_timer seconds',
              style: TextStyle(fontSize: 24, color: Colors.red),
            ),
            SizedBox(height: 16),
            Text(
              _shuffledQuestions[_currentQuestionIndex]['question'],
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 16),
            ..._shuffledQuestions[_currentQuestionIndex]['answers'].map<Widget>((answer) {
              return ListTile(
                title: Text(answer),
                leading: Radio(
                  value: answer,
                  groupValue: _selectedAnswer,
                  onChanged: (value) {
                    if (!_isAnswered) {
                      setState(() {
                        _selectedAnswer = value as String;
                        _isAnswered = true;
                      });
                      _stopTimer();
                      _nextQuestion();
                    }
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
