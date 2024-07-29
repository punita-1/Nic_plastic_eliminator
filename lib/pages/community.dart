import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plastic_eliminator/pages/posts.dart';
import 'package:plastic_eliminator/pages/login.dart';
import 'package:plastic_eliminator/services/shared_pref.dart'; // Import SharedPreferanceHelper

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  final TextEditingController textController = TextEditingController();
  User? currentUser;

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

  void postMessage() {
    if (textController.text.isNotEmpty && currentUser != null) {
      FirebaseFirestore.instance.collection('UserPosts').add({
        'UserEmail': currentUser!.email,
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
        'likes': [], // Initialize the likes field as an empty list
      });
      textController.clear(); // Clear the text field after posting
    }
  }

  // void addComment(String commentText) {
  //   FirebaseFirestore.instance
  //       .collection("UserPosts")
  //       .doc(widget.postId)
  //       .collection("Comments")
  //       .add({
  //     "CommentText": commentText,
  //     "CommentedBy": currentUser.email,
  //     "CommentTime": Timestamp.now()
  //   });
  // }

  // void ShowCommentDialog() {
  //   showDialog(context: context, builder: (context) => AlertDialog(
  //     title: Text('add comment'),
  //     content: TextField(),
  //     controller
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('The Wall'),
          leading: Icon(Icons.arrow_back_ios_new_outlined),
        ),
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
      appBar: AppBar(
        title: Text('The Wall'),
        leading: Icon(Icons.arrow_back_ios_new_outlined),
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("UserPosts")
                      .orderBy(
                        "TimeStamp",
                        descending: false,
                      )
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final post = snapshot.data!.docs[index];
                          final likes = List<String>.from(
                            post.data().containsKey('likes')
                                ? post['likes']
                                : [],
                          );
                          return Posts(
                            message: post['Message'],
                            postID: post.id,
                            likes: likes,
                            user: post['UserEmail'],
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
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: textController,
                        decoration: InputDecoration(hintText: 'Text here'),
                      ),
                    ),
                    IconButton(
                      onPressed: postMessage,
                      icon: Icon(Icons.arrow_circle_up),
                    ),
                  ],
                ),
              ),
              Text("Logged in as: ${currentUser!.email!}"),
            ],
          ),
        ),
      ),
    );
  }
}
