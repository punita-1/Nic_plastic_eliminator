// ignore_for_file: unused_local_variable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:plastic_eliminator/core/utils/format_date.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plastic_eliminator/features/community_page/comment_button.dart';
import 'package:plastic_eliminator/features/community_page/comments.dart';
import 'package:plastic_eliminator/features/community_page/delete_button.dart';
import 'package:plastic_eliminator/features/community_page/like_button.dart';

/// A widget that represents an individual post in the community section.
///
/// This widget displays the post message, the user who posted it, and the
/// time it was posted. It also includes options for liking, commenting, and
/// deleting the post.
class Posts extends StatefulWidget {
  final String message;
  final String user;
  final String time;
  final String postID;
  final List<String> likes;

  const Posts({
    super.key,
    required this.message,
    required this.postID,
    required this.likes,
    required this.user,
    required this.time,
  });

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  final User currentUser = FirebaseAuth.instance.currentUser!;
  late bool isLiked;
  final TextEditingController _commentTextController = TextEditingController();
  bool areCommentsVisible = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  /// Toggles the like status of the post and updates it in Firestore.
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection('UserPosts').doc(widget.postID);

    if (isLiked) {
      postRef.update({
        'likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postRef.update({
        'likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  /// Shows a dialog for adding a comment to the post.
  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add comment'),
        content: TextField(
          controller: _commentTextController,
          decoration: const InputDecoration(hintText: "Write a comment.."),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _commentTextController.clear();
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
          ),
          TextButton(
            onPressed: () {
              addComment(_commentTextController.text);
              Navigator.pop(context);
              _commentTextController.clear();
            },
            child: Text(
              'Post',
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
          ),
        ],
      ),
    );
  }

  /// Adds a comment to the post in Firestore.
  void addComment(String commentText) {
    FirebaseFirestore.instance
        .collection("UserPosts")
        .doc(widget.postID)
        .collection("Comments")
        .add({
      "CommentText": commentText,
      "CommentedBy": currentUser.email,
      "CommentTime": Timestamp.now(),
    });
  }

  /// Returns a stream of the number of comments on the post.
  Stream<int> getCommentCountStream() {
    return FirebaseFirestore.instance
        .collection("UserPosts")
        .doc(widget.postID)
        .collection("Comments")
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  /// Deletes the post and its comments from Firestore.
  void deletePost() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Post'),
        content: const Text('Are you sure you want to delete this post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
          ),
          TextButton(
            onPressed: () async {
              final commentDocs = await FirebaseFirestore.instance
                  .collection("UserPosts")
                  .doc(widget.postID)
                  .collection("Comments")
                  .get();

              for (var doc in commentDocs.docs) {
                await FirebaseFirestore.instance
                    .collection("UserPosts")
                    .doc(widget.postID)
                    .collection("Comments")
                    .doc(doc.id)
                    .delete();
              }

              await FirebaseFirestore.instance
                  .collection("UserPosts")
                  .doc(widget.postID)
                  .delete()
                  .then((value) => print("Post deleted"))
                  .catchError(
                      (error) => print("Failed to delete the post: $error"));

              Navigator.pop(context);
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with user information and delete button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.user,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (widget.user == currentUser.email)
                DeleteButton(onTap: deletePost),
            ],
          ),
          // Post message
          Container(
            width: 260,
            child: Text(
              widget.message,
              style: const TextStyle(color: Colors.teal
                  // Theme.of(context).colorScheme.tertiary
                  ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.time,
            // style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            // mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  LikeButton(isliked: isLiked, onTap: toggleLike),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.likes.length.toString(),
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              StreamBuilder<int>(
                stream: getCommentCountStream(),
                builder: (context, snapshot) {
                  final commentCount = snapshot.data ?? 0;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommentButton(
                        onTap: () {
                          setState(() {
                            areCommentsVisible = !areCommentsVisible;
                          });
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          Visibility(
            visible: areCommentsVisible,
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("UserPosts")
                      .doc(widget.postID)
                      .collection("Comments")
                      .orderBy("CommentTime", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: snapshot.data!.docs.map((doc) {
                        final commentData = doc.data() as Map<String, dynamic>;
                        return Comments(
                          text: commentData["CommentText"],
                          time: formatData(commentData["CommentTime"]),
                          user: commentData["CommentedBy"],
                        );
                      }).toList(),
                    );
                  },
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: showCommentDialog,
                    ),
                    Text('Add Comment'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
