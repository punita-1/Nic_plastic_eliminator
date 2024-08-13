import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plastic_eliminator/features/auth/presentation/login.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:share_plus/share_plus.dart'; // Import share_plus
import 'dart:io';

import 'package:plastic_eliminator/core/utils/format_date.dart';
// import 'package:plastic_eliminator/src/features/auth/presentation/login.dart';
import 'package:plastic_eliminator/data/datasources/shared_preferences_data_source.dart'; // Import SharedPreferanceHelper

class MediaCommunityPage extends StatefulWidget {
  const MediaCommunityPage({Key? key}) : super(key: key);

  @override
  State<MediaCommunityPage> createState() => _MediaCommunityPageState();
}

class _MediaCommunityPageState extends State<MediaCommunityPage> {
  User? currentUser;
  File? _media;
  bool _isUploading = false;
  Map<String, bool> _showComments = {}; // Map to track visibility of comments

  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  Future<void> _checkLoginState() async {
    final isLoggedIn = await SharedPreferanceHelper().getLoginState();
    if (isLoggedIn) {
      setState(() {
        currentUser = FirebaseAuth.instance.currentUser;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  Future<void> _pickMedia(ImageSource source, {bool isVideo = false}) async {
    final picker = ImagePicker();
    XFile? pickedFile;
    if (isVideo) {
      pickedFile = await picker.pickVideo(source: source);
    } else {
      pickedFile = await picker.pickImage(source: source);
    }
    if (pickedFile != null) {
      setState(() {
        _media = File(pickedFile!.path);
      });
    }
  }

  Future<void> _uploadMedia() async {
    if (_media == null || currentUser == null) return;

    setState(() {
      _isUploading = true;
    });

    try {
      final storageRef = FirebaseStorage.instance.ref().child(
          'user_posts/${currentUser!.uid}/${DateTime.now().toIso8601String()}');
      final uploadTask = storageRef.putFile(_media!);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('UserMediaPosts').add({
        'UserEmail': currentUser!.email,
        'MediaUrl': downloadUrl,
        'TimeStamp': Timestamp.now(),
        'MediaType': _media!.path.endsWith('.mp4') ? 'video' : 'image',
        'Likes': 0,
        'Comments': [],
      });

      setState(() {
        _media = null;
        _isUploading = false;
      });
    } catch (e) {
      print('Error uploading media: $e');
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<void> _toggleLike(DocumentSnapshot post) async {
    if (currentUser == null) return;

    final postDoc =
        FirebaseFirestore.instance.collection('UserMediaPosts').doc(post.id);
    final data = post.data() as Map<String, dynamic>;
    final currentLikes = data['Likes'] as int? ?? 0;

    // Convert the LikedByUsers map to a Map<String, bool>
    final likedByUsers = (data['LikedByUsers'] as Map<String, dynamic>? ?? {})
        .map((key, value) => MapEntry(key, value as bool));

    if (likedByUsers.containsKey(currentUser!.uid)) {
      // User has already liked the post, so unlike it
      await postDoc.update({
        'Likes': currentLikes - 1,
        'LikedByUsers.${currentUser!.uid}': FieldValue.delete(),
      });
    } else {
      // User has not liked the post, so like it
      await postDoc.update({
        'Likes': currentLikes + 1,
        'LikedByUsers.${currentUser!.uid}': true,
      });
    }
  }

  Future<void> _addComment(DocumentSnapshot post, String comment) async {
    final data = post.data() as Map<String, dynamic>;
    final currentComments = List<String>.from(data['Comments'] ?? []);
    currentComments.add(comment);
    await FirebaseFirestore.instance
        .collection('UserMediaPosts')
        .doc(post.id)
        .update({'Comments': currentComments});
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            child: Text('Login to Access'),
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("UserMediaPosts")
                      .orderBy("TimeStamp", descending: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final post = snapshot.data!.docs[index];
                          final mediaUrl = post['MediaUrl'];
                          final mediaType = post['MediaType'];
                          final likes =
                              (post.data() as Map<String, dynamic>)['Likes'] ??
                                  0;
                          final comments = List<String>.from((post.data()
                                  as Map<String, dynamic>)['Comments'] ??
                              []);
                          final postId = post.id;

                          // Track whether to show comments for this post
                          if (!_showComments.containsKey(postId)) {
                            _showComments[postId] = false;
                          }

                          // Safely cast the LikedByUsers map
                          final likedByUsers = (post.data()
                                      as Map<String, dynamic>)['LikedByUsers']
                                  as Map<String, dynamic>? ??
                              {};
                          final hasLiked =
                              likedByUsers.containsKey(currentUser?.uid);

                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post['UserEmail'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                mediaType == 'image'
                                    ? Image.network(mediaUrl)
                                    : VideoPlayerWidget(videoUrl: mediaUrl),
                                SizedBox(height: 8),
                                Text(formatData(post['TimeStamp'])),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(hasLiked
                                              ? Icons.thumb_up
                                              : Icons.thumb_up_off_alt),
                                          onPressed: () => _toggleLike(post),
                                        ),
                                        Text('$likes'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.comment),
                                          onPressed: () {
                                            setState(() {
                                              _showComments[postId] =
                                                  !_showComments[postId]!;
                                            });
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.share),
                                          onPressed: () {
                                            Share.share(
                                                'Check out this post by ${post['UserEmail']}: $mediaUrl');
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                if (_showComments[postId]!)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ...comments.map((comment) => Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Text(comment),
                                          )),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.add),
                                            onPressed: () =>
                                                _showCommentDialog(post),
                                          ),
                                          Text('Add Comment'),
                                        ],
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error loading posts'));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              if (_media != null)
                Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _media!.path.endsWith('.mp4')
                          ? AspectRatio(
                              aspectRatio: 16 / 9,
                              child: VideoPlayerWidget(
                                videoUrl: _media!.path,
                                isLocalFile: true,
                              ),
                            )
                          : Image.file(_media!),
                      if (_isUploading) CircularProgressIndicator(),
                      if (!_isUploading)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _media = null;
                                });
                              },
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: _uploadMedia,
                              child: Text('Upload'),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: _isUploading
          ? null
          : FloatingActionButton(
              onPressed: () => _showMediaPicker(context),
              child: Icon(Icons.add),
            ),
    );
  }

  Future<void> _showMediaPicker(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Take a photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickMedia(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickMedia(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.videocam),
                title: Text('Take a video'),
                onTap: () {
                  Navigator.pop(context);
                  _pickMedia(ImageSource.camera, isVideo: true);
                },
              ),
              ListTile(
                leading: Icon(Icons.video_library),
                title: Text('Choose video from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickMedia(ImageSource.gallery, isVideo: true);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCommentDialog(DocumentSnapshot post) {
    final TextEditingController commentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add a Comment'),
          content: TextField(
            controller: commentController,
            decoration: InputDecoration(hintText: 'Enter your comment'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final comment = commentController.text.trim();
                if (comment.isNotEmpty) {
                  _addComment(post, comment);
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final bool isLocalFile;

  const VideoPlayerWidget({
    Key? key,
    required this.videoUrl,
    this.isLocalFile = false,
  }) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    if (widget.isLocalFile) {
      _controller = VideoPlayerController.file(File(widget.videoUrl));
    } else {
      _controller = VideoPlayerController.network(widget.videoUrl);
    }
    await Future.wait([
      _controller.initialize(),
    ]);
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: false,
      looping: false,
    );
    setState(() {});
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
        ? Chewie(
            controller: _chewieController!,
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
