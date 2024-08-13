// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// A screen that displays a YouTube video player.
class PlayerScreen extends StatefulWidget {
  /// The YouTube video ID to be played.
  final String videoId;

  /// Constructs a [PlayerScreen] with the given [videoId].
  const PlayerScreen({super.key, required this.videoId});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  /// Controller for managing YouTube player functionalities.
  late final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: widget.videoId,
    flags: const YoutubePlayerFlags(
      autoPlay: true, // Automatically starts the video.
      mute: false, // Video is not muted initially.
    ),
  );

  @override
  void dispose() {
    _controller
        .dispose(); // Dispose of the controller when the widget is destroyed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'), // Title of the AppBar.
      ),
      body: Column(
        children: [
          /// Embeds the YouTube player in the screen.
          YoutubePlayer(
            controller: _controller,
          ),
          const Center(
            child:
                Text('some text'), // Placeholder text below the video player.
          ),
        ],
      ),
    );
  }
}
