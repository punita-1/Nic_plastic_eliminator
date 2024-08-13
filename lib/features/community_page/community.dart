import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plastic_eliminator/data/datasources/shared_preferences_data_source.dart';
// import 'package:plastic_eliminator/src/features/community_page/posts.dart';
import 'package:plastic_eliminator/core/utils/format_date.dart';
import 'package:plastic_eliminator/features/auth/presentation/login.dart';
import 'package:plastic_eliminator/features/community_page/media_community.dart';
import 'package:plastic_eliminator/features/community_page/most_liked_post.dart';
import 'package:plastic_eliminator/features/community_page/posts.dart';
import 'package:plastic_eliminator/features/community_page/user_post_page.dart';

/// A stateful widget that represents the Community page.
///
/// The Community page allows users to view and post messages to the community.
/// It includes a tabbed interface with a general community tab and a media
/// community tab. Users must be logged in to post messages or view their posts.
class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community>
    with SingleTickerProviderStateMixin {
  /// Controller for handling text input in the message field.
  final TextEditingController textController = TextEditingController();

  /// The currently logged-in user.
  User? currentUser;

  /// Controller for managing the tab navigation.
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _checkLoginState(); // Check if the user is logged in when the widget is initialized.
  }

  /// Checks the login state of the user and updates the [currentUser] accordingly.
  Future<void> _checkLoginState() async {
    final isLoggedIn = await SharedPreferanceHelper().getLoginState();
    if (isLoggedIn) {
      setState(() {
        currentUser = FirebaseAuth.instance.currentUser;
      });
    }
  }

  /// Posts a message to the community if the [textController] is not empty
  /// and the user is logged in.
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
    // If the user is not logged in, show a login prompt.
    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            child: Text(
              'Login to Access This Feature',
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
          ),
        ),
      );
    }

    // If the user is logged in, show the community page with tabs.
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
            icon: Icon(Icons.post_add), // Icon for user posts
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
                // Show a message if the user is not logged in.
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

/// A stateless widget that represents the content of the Community tab.
///
/// The Community tab allows users to view posts from the community and
/// post their own messages. The tab displays posts in a list and includes
/// a text field for posting new messages.
class CommunityTab extends StatelessWidget {
  /// Controller for handling text input in the message field.
  final TextEditingController textController;

  /// The currently logged-in user.
  final User? currentUser;

  /// Callback function to post a message.
  final VoidCallback postMessage;

  /// Creates a [CommunityTab] widget.
  ///
  /// The [textController], [currentUser], and [postMessage] parameters are
  /// required to manage the state and behavior of the tab.
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
