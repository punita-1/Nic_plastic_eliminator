import 'package:flutter/material.dart';
import 'package:plastic_eliminator/pages/community_page/comment_button.dart';
import 'package:plastic_eliminator/pages/community_page/comments.dart';
import 'package:plastic_eliminator/pages/community_page/delete_button.dart';
import 'package:plastic_eliminator/pages/idk_pages/helper_method.dart';
import 'package:plastic_eliminator/pages/community_page/like_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final currentUser = FirebaseAuth.instance.currentUser!;
  late bool isLiked;
  final _commntTextController = TextEditingController();
  bool areCommentsVisible = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

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

  void showCommentDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Add comment'),
              content: TextField(
                controller: _commntTextController,
                decoration: InputDecoration(hintText: "Write a comment.."),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _commntTextController.clear();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary),
                    )),
                TextButton(
                    onPressed: () {
                      addComment(_commntTextController.text);
                      Navigator.pop(context);
                      _commntTextController.clear();
                    },
                    child: Text(
                      'Post',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary),
                    )),
              ],
            ));
  }

  void addComment(String commentText) {
    FirebaseFirestore.instance
        .collection("UserPosts")
        .doc(widget.postID)
        .collection("Comments")
        .add({
      "CommentText": commentText,
      "CommentedBy": currentUser.email,
      "CommentTime": Timestamp.now()
    });
  }

  Stream<int> getCommentCountStream() {
    return FirebaseFirestore.instance
        .collection("UserPosts")
        .doc(widget.postID)
        .collection("Comments")
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  void deletePost() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Delete Post'),
              content: Text('Are you sure you want to delete this post?'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary),
                    )),
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
                      FirebaseFirestore.instance
                          .collection("UserPosts")
                          .doc(widget.postID)
                          .delete()
                          .then((value) => print("Post deleted"))
                          .catchError((error) =>
                              print("Failed to delete the post: $error"));

                      Navigator.pop(context);
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary),
                    ))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 290,
                child: Text(
                  widget.message,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ),
              ),
              if (widget.user == currentUser.email)
                DeleteButton(
                  onTap: deletePost,
                ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                widget.user,
                style: TextStyle(color: Colors.grey[600]),
              ),
              Text(
                " . ",
                style: TextStyle(color: Colors.grey[600]),
              ),
              Text(
                widget.time,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  LikeButton(isliked: isLiked, onTap: toggleLike),
                  Text(
                    widget.likes.length.toString(),
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
              SizedBox(
                width: 5,
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
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero, // Remove padding
                          minimumSize:
                              Size(0, 0), // Remove minimum size constraints
                          tapTargetSize: MaterialTapTargetSize
                              .shrinkWrap, // Shrink tap area
                        ),
                        onPressed: () {
                          setState(() {
                            areCommentsVisible = !areCommentsVisible;
                          });
                        },
                        child: Text(
                          '$commentCount',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: 5,
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
                SizedBox(height: 10),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.grey[600]),
                  onPressed: showCommentDialog,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
