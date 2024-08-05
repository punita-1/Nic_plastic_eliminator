import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plastic_eliminator/pages/idk_pages/helper_method.dart';
import 'package:plastic_eliminator/pages/community_page/posts.dart';
import 'package:plastic_eliminator/pages/initial_pages/login.dart';
import 'package:plastic_eliminator/services/shared_pref.dart'; // Import SharedPreferanceHelper

class Community extends StatefulWidget {
  // final String postID; // Add the 'postID' field

  const Community({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Community',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) => Theme.of(context).colorScheme.primary,
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            child: Text(
              'Login to Access',
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Community',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
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
                            time: formatData(post['TimeStamp']),
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
                        decoration: InputDecoration(
                            hintText: 'Text here',
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            fillColor: Theme.of(context).colorScheme.primary,
                            filled: true),
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
