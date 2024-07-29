import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, 0.05),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildCategoryCard(String title, String videoUrl) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: InkWell(
          onTap: () {
            // Handle the tap to open the video link, for now, it prints the URL
            print('Video URL: $videoUrl');
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.play_circle_fill,
                  color: Colors.green,
                  size: 50,
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Watch Tutorial',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plastic Waste Categories'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              buildCategoryCard('Plastic Recycling Basics',
                  'https://www.youtube.com/watch?v=example1'),
              const SizedBox(height: 20),
              buildCategoryCard('Types of Plastics',
                  'https://www.youtube.com/watch?v=example2'),
              const SizedBox(height: 20),
              buildCategoryCard('Plastic Waste Management',
                  'https://www.youtube.com/watch?v=example3'),
              const SizedBox(height: 20),
              buildCategoryCard('Innovative Plastic Solutions',
                  'https://www.youtube.com/watch?v=example4'),
            ],
          ),
        ),
      ),
    );
  }
}
