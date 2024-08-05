import 'package:flutter/material.dart';

void main() {
  runApp(PlasticSortingGame());
}

class PlasticSortingGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plastic Sorting Game',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SortingGameScreen(),
    );
  }
}

class SortingGameScreen extends StatefulWidget {
  @override
  _SortingGameScreenState createState() => _SortingGameScreenState();
}

class _SortingGameScreenState extends State<SortingGameScreen> {
  final List<WasteItem> wasteItems = [
    WasteItem('Plastic Bottle', 'Assets/images/water-bottle.png', true),
    WasteItem('Plastic Bag', 'Assets/images/plastic-bag.png', false),
    // Add more waste items
  ];

  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plastic Sorting Game'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: wasteItems
                .map((item) => Draggable<WasteItem>(
                      data: item,
                      child: WasteItemWidget(item: item),
                      feedback: WasteItemWidget(item: item),
                      childWhenDragging: Opacity(
                        opacity: 0.5,
                        child: WasteItemWidget(item: item),
                      ),
                    ))
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DragTarget<WasteItem>(
                builder: (context, candidateData, rejectedData) => BinWidget(
                  label: 'Recyclable',
                  imagePath: 'Assets/images/recycle-bin.png',
                ),
                onAccept: (item) {
                  if (item.isRecyclable) {
                    setState(() {
                      score++;
                    });
                  }
                },
              ),
              DragTarget<WasteItem>(
                builder: (context, candidateData, rejectedData) => BinWidget(
                  label: 'Non-Recyclable',
                  imagePath: 'Assets/images/non-biodegradable.png',
                ),
                onAccept: (item) {
                  if (!item.isRecyclable) {
                    setState(() {
                      score++;
                    });
                  }
                },
              ),
            ],
          ),
          Text(
            'Score: $score',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}

class WasteItem {
  final String name;
  final String imagePath;
  final bool isRecyclable;

  WasteItem(this.name, this.imagePath, this.isRecyclable);
}

class WasteItemWidget extends StatelessWidget {
  final WasteItem item;

  WasteItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(item.imagePath, width: 80, height: 80),
        Text(item.name),
      ],
    );
  }
}

class BinWidget extends StatelessWidget {
  final String label;
  final String imagePath;

  BinWidget({required this.label, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imagePath, width: 100, height: 100),
        Text(label),
      ],
    );
  }
}
