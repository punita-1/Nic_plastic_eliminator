import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SortingGamePage extends StatefulWidget {
  @override
  _SortingGamePageState createState() => _SortingGamePageState();
}

class _SortingGamePageState extends State<SortingGamePage> {
  List<String> items = [];
  Map<String, String?> itemLocations = {};
  Map<String, bool> results = {};
  int score = 0;
  Set<String> pickedItems = {}; // Set to track picked items

  final AudioPlayer _soundPlayer = AudioPlayer();
  final AudioPlayer _musicPlayer = AudioPlayer();
  bool _soundEnabled = true; // Variable to control sound on/off
  bool _musicEnabled = true; // Variable to control background music on/off

  @override
  void initState() {
    super.initState();
    items = generateSortingItems();
    _initializeGame();
    _loadSettings();
  }

  void _initializeGame() {
    // Initialize itemLocations with the original positions of items.
    for (var item in items) {
      itemLocations[item] = 'original';
    }
  }

  Future<void> _loadSettings() async {
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
      await _soundPlayer.setAsset('Assets/Sounds/drop.mp3');
    } catch (e) {
      print('Error loading sound files: $e');
    }
  }

  Future<void> _playSound(String soundFileName) async {
    if (_soundEnabled) {
      try {
        await _soundPlayer.setAsset('Assets/Sounds/$soundFileName');
        _soundPlayer.play();
        print('Playing sound: $soundFileName');
      } catch (e) {
        print('Error playing sound: $e');
      }
    } else {
      print('Sound is disabled. Not playing: $soundFileName');
      await _soundPlayer.stop(); // Ensure sound stops
    }
  }

  void _playBackgroundMusic() async {
    if (_musicEnabled) {
      try {
        await _musicPlayer.setAsset('Assets/Sounds/music.mp3');
        _musicPlayer.setLoopMode(LoopMode.one); // Loop the background music
        _musicPlayer.play();
        print('Playing background music');
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

  void _updateScore(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        score += 1; // Increment score for correct answers
      }
    });
  }

  void _checkResult() {
    // No need to calculate score here, as score is updated directly
    _showSnackBar(
        'Game Completed!'); // Show a snackbar when the game is completed
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _removeItem(String item) {
    setState(() {
      items.remove(item);
      itemLocations.remove(item);
      results.remove(item);
      pickedItems.remove(item);

      // Check if game is completed
      if (items.isEmpty) {
        _addNewItems(); // Add new items to continue the game
      }
    });
  }

  void _addNewItems() {
    List<String> allItems = getAllPossibleItems();
    List<String> newItems = generateNewItems(allItems, items);
    setState(() {
      items.addAll(newItems);
      _initializeGame(); // Reinitialize item locations for new items
    });
  }

  void _restartGame() {
    setState(() {
      items = generateSortingItems(); // Reset the items list
      _initializeGame(); // Reinitialize item locations
      results.clear(); // Clear results
      pickedItems.clear(); // Clear picked items
      score = 0; // Reset score
    });
  }

  @override
  void dispose() {
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
          'Sorting Game',
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Display score and restart button at the top
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Score: $score',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: _restartGame,
                ),
              ],
            ),
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
                      _playSound('drop.mp3'); // Play sound when item is dropped
                    },
                    child: ItemBox(
                      text: pickedItems.contains(item) ? '' : item,
                    ),
                    feedback: Material(
                      child: ItemBox(text: item),
                    ),
                    childWhenDragging: ItemBox(text: ''),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DragTarget<String>(
                    onAccept: (data) {
                      setState(() {
                        itemLocations[data] = 'biodegradable';
                        bool isCorrect = isBiodegradable(data);
                        results[data] = isCorrect;
                        _playSound(
                            'drop.mp3'); // Play sound when item is dropped into this target
                        _showSnackBar(isCorrect
                            ? 'Correct: $data is Biodegradable'
                            : 'Incorrect: $data is not Biodegradable');
                        _updateScore(
                            isCorrect); // Update score based on correctness
                        _removeItem(data); // Remove item after it's sorted
                      });
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
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
                        bool isCorrect = !isBiodegradable(data);
                        results[data] = isCorrect;
                        _playSound(
                            'drop.mp3'); // Play sound when item is dropped into this target
                        _showSnackBar(isCorrect
                            ? 'Correct: $data is Non-Biodegradable'
                            : 'Incorrect: $data is Biodegradable');
                        _updateScore(
                            isCorrect); // Update score based on correctness
                        _removeItem(data); // Remove item after it's sorted
                      });
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Center(child: Text('Non-Biodegradable')),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Display the current score
            Text(
              'Score: $score',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  List<String> generateSortingItems() {
    return [
      'Apple',
      'Plastic Bottle',
      'Paper',
      'Banana Peel',
      'Glass',
      'Metal Can',
      'Wood',
      'Cardboard',
    ];
  }

  bool isBiodegradable(String item) {
    return ['Apple', 'Paper', 'Banana Peel', 'Wood', 'Cardboard']
        .contains(item);
  }

  List<String> getAllPossibleItems() {
    return [
      'Apple',
      'Plastic Bottle',
      'Paper',
      'Banana Peel',
      'Glass',
      'Metal Can',
      'Wood',
      'Cardboard',
      // Add more items here if needed
    ];
  }

  List<String> generateNewItems(
      List<String> allItems, List<String> currentItems) {
    // Return a new list of items, excluding the current items
    return allItems.where((item) => !currentItems.contains(item)).toList();
  }
}

class ItemBox extends StatelessWidget {
  final String text;

  const ItemBox({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.teal),
        ),
      ),
    );
  }
}
