import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerScreen extends StatelessWidget {
  final String videoId;

  PlayerScreen({required this.videoId});

  @override
  Widget build(BuildContext context) {
    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Column(
        children: [
          YoutubePlayer(controller: _controller),
        ],
      ),
    );
  }
}
