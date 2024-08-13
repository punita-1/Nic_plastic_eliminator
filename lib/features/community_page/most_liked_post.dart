import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:share_plus/share_plus.dart';

class MostLikedPostPage extends StatefulWidget {
  const MostLikedPostPage({Key? key}) : super(key: key);

  @override
  _MostLikedPostPageState createState() => _MostLikedPostPageState();
}

class _MostLikedPostPageState extends State<MostLikedPostPage> {
  DocumentSnapshot? _mostLikedPost;

  @override
  void initState() {
    super.initState();
    _fetchMostLikedPost();
  }

  // Fetch the post with the highest number of likes from Firestore
  Future<void> _fetchMostLikedPost() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('UserMediaPosts')
        .orderBy('Likes', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      setState(() {
        _mostLikedPost = querySnapshot.docs.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Most Liked Post"),
      ),
      body: _mostLikedPost == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildPostContent(_mostLikedPost!),
            ),
    );
  }

  // Build the content of the most liked post
  Widget _buildPostContent(DocumentSnapshot post) {
    final mediaUrl = post['MediaUrl'];
    final mediaType = post['MediaType'];
    final likes = post['Likes'];
    final comments = List<String>.from(post['Comments'] ?? []);
    final userEmail = post['UserEmail'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Posted by: $userEmail',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        mediaType == 'image'
            ? Image.network(mediaUrl)
            : VideoPlayerWidget(videoUrl: mediaUrl),
        SizedBox(height: 8),
        Text('Likes: $likes'),
        SizedBox(height: 8),
        Text('Comments:', style: TextStyle(fontWeight: FontWeight.bold)),
        ...comments.map((comment) => Text('- $comment')).toList(),
        SizedBox(height: 8),
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () {
            Share.share('Check out this post by $userEmail: $mediaUrl');
          },
        ),
      ],
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    // Initialize the video player controller and Chewie controller
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _controller,
            aspectRatio: _controller.value.aspectRatio,
            autoPlay: false,
            looping: false,
          );
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized
        ? SizedBox(
            height: 200,
            child: Chewie(
              controller: _chewieController!,
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
