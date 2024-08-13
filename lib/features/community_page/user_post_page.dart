// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plastic_eliminator/core/utils/format_date.dart';
import 'package:plastic_eliminator/features/community_page/media_community.dart';

/// A page that displays the user's own posts in the community.
///
/// This page fetches posts from the Firestore collection 'UserMediaPosts',
/// and displays them in a list. Posts are ordered by their timestamp
/// in descending order, meaning the most recent posts are shown first.
class UserPostsPage extends StatelessWidget {
  /// The ID of the user whose posts are to be displayed.
  final String userId;

  /// Constructs a [UserPostsPage].
  ///
  /// The [userId] parameter is required to identify the posts specific to the user.
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
            .orderBy("TimeStamp", descending: true) // Order posts by timestamp
            .snapshots(),
        builder: (context, snapshot) {
          // Show a loading indicator while waiting for data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Display an error message if there's an error in fetching data
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            // Display a message if there are no posts
            return Center(
              child: Text('No posts available.'),
            );
          }

          // If data is available, build the list of posts
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final post = snapshot.data!.docs[index];
                final mediaUrl =
                    post['MediaUrl']; // URL of the media in the post
                final mediaType =
                    post['MediaType']; // Type of media (e.g., image, video)
                final likes = (post.data() as Map<String, dynamic>)['Likes'] ??
                    0; // Number of likes

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
                          ? Image.network(
                              mediaUrl) // Display image if media type is image
                          : VideoPlayerWidget(
                              videoUrl:
                                  mediaUrl), // Display video if media type is video
                      SizedBox(height: 8),
                      Text(formatData(
                          post['TimeStamp'])), // Display formatted timestamp
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
