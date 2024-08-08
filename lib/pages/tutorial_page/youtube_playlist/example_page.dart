import 'package:flutter/material.dart';
import 'video_list.dart'; // Adjust the import to match your file structure

class ExamplePage extends StatelessWidget {
  final String category = 'Home Recycling'; // Example category
  final String playlistId = 'PLxHWbyWxvx_ISvUfn0ND5aUPAUOID7Man';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoList(
                  category: category,
                  playlistId: playlistId,
                ),
              ),
            );
          },
          child: Text(
            'Open Video List',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
        ),
      ),
    );
  }
}
