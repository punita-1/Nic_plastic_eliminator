import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plastic_eliminator/pages/community_page/media_community.dart';
import 'package:plastic_eliminator/pages/community_page/most_liked_post.dart';
import 'package:plastic_eliminator/pages/community_page/user_post_page.dart';
import 'package:plastic_eliminator/pages/initial_pages/login.dart';
import 'package:plastic_eliminator/services/shared_pref.dart';
import 'package:plastic_eliminator/pages/community_page/posts.dart';
import 'package:plastic_eliminator/pages/idk_pages/helper_method.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community>
    with SingleTickerProviderStateMixin {
  final TextEditingController textController = TextEditingController();
  User? currentUser;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
          actions: [
            TextButton(
                onPressed: () {
                  if (currentUser != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UserPostsPage(userId: currentUser!.uid),
                      ),
                    );
                  } else {
                    // Handle the case where the user is not logged in
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Please log in to view your posts')),
                    );
                  }
                },
                child: Icon(Icons.abc)),
          ],
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Community',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MostLikedPostPage()),
              );
            },
            icon: Icon(Icons.star),
          ),
          IconButton(
            icon: Icon(Icons.post_add), // Change the icon as needed
            onPressed: () {
              if (currentUser != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UserPostsPage(userId: currentUser!.uid),
                  ),
                );
              } else {
                // Handle the case where the user is not logged in
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please log in to view your posts')),
                );
              }
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Community"),
            Tab(text: "Media Community"),
          ],
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold), // Style for selected tab
          unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal), // Style for unselected tabs
          labelColor: Theme.of(context).colorScheme.onBackground,
          // unselectedLabelColor: Colors.grey, // Color for unselected tabs
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CommunityTab(
            textController: textController,
            currentUser: currentUser,
            postMessage: postMessage,
          ),
          MediaCommunityPage(),
        ],
      ),
    );
  }
}

class CommunityTab extends StatelessWidget {
  final TextEditingController textController;
  final User? currentUser;
  final VoidCallback postMessage;

  const CommunityTab({
    required this.textController,
    required this.currentUser,
    required this.postMessage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("UserPosts")
                  .orderBy("TimeStamp", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data!.docs[index];
                      final likes = List<String>.from(
                        post.data().containsKey('likes') ? post['likes'] : [],
                      );
                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Posts(
                          time: formatData(post['TimeStamp']),
                          message: post['Message'],
                          postID: post.id,
                          likes: likes,
                          user: post['UserEmail'],
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
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: textController,
                        decoration: InputDecoration(
                          hintText: 'Text here',
                          hintStyle: TextStyle(color: Colors.teal),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                          ),
                          fillColor: Theme.of(context).colorScheme.primary,
                          filled: true,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: postMessage,
                      icon: Icon(Icons.arrow_circle_up),
                      color: Colors.teal,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text("Logged in as: ${currentUser!.email!}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
