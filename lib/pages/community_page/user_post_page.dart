import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plastic_eliminator/pages/community_page/media_community.dart';
import 'package:plastic_eliminator/pages/idk_pages/helper_method.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class UserPostsPage extends StatelessWidget {
  final String userId;

  UserPostsPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Posts',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("UserMediaPosts")
            .orderBy("TimeStamp",
                descending: true) // Ensure ordering is correct
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No posts available.'),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final post = snapshot.data!.docs[index];
                final mediaUrl = post['MediaUrl'];
                final mediaType = post['MediaType'];
                final likes =
                    (post.data() as Map<String, dynamic>)['Likes'] ?? 0;

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FirebaseAuth.instance.currentUser!.email!,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      mediaType == 'image'
                          ? Image.network(mediaUrl)
                          : VideoPlayerWidget(videoUrl: mediaUrl),
                      SizedBox(height: 8),
                      Text(formatData(post['TimeStamp'])),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.thumb_up),
                          Text('$likes'),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
