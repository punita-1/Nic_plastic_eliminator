// // // // // import 'dart:js_interop';
// // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import 'package:plastic_eliminator/pages/posts.dart';

// // // // class Community extends StatefulWidget {
// // // //   const Community({super.key});

// // // //   @override
// // // //   State<Community> createState() => _CommunityState();
// // // // }

// // // // class _CommunityState extends State<Community> {
// // // //   final TextEditingController textController = TextEditingController();
// // // //   final currentUser = FirebaseAuth.instance.currentUser!;

// // // //   void postMessage() {
// // // //     if (textController.text.isNotEmpty) {
// // // //       FirebaseFirestore.instance.collection('User Posts').add({
// // // //         'UserEmail': currentUser.email,
// // // //         'Message': textController.text,
// // // //         'TimeStamp': Timestamp.now(),
// // // //       });
// // // //     }
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('the wall'),
// // // //         leading: Icon(Icons.arrow_back_ios_new_outlined),
// // // //       ),
// // // //       body: Container(
// // // //         margin: EdgeInsets.only(bottom: 20),
// // // //         // margin: EdgeInsets.only(left: 20, right: 20),
// // // //         child: Center(
// // // //           child: Column(
// // // //             children: [
// // // //               Expanded(
// // // //                   child: StreamBuilder(
// // // //                       stream: FirebaseFirestore.instance
// // // //                           .collection("UserPosts")
// // // //                           .orderBy(
// // // //                             "TimeStamp",
// // // //                             descending: false,
// // // //                           )
// // // //                           .snapshots(),
// // // //                       builder: (context, snapshot) {
// // // //                         if (snapshot.hasData) {
// // // //                           return ListView.builder(
// // // //                               itemCount: snapshot.data!.docs.length,
// // // //                               itemBuilder: (context, index) {
// // // //                                 final post = snapshot.data!.docs[index];
// // // //                                 return Posts(
// // // //                                     message: post['message'],
// // // //                                     user: post['userEmail']);
// // // //                               });
// // // //                         } else if (snapshot.hasError) {
// // // //                           return Center(
// // // //                             child: Text('Error:' + snapshot.error.toString()),
// // // //                           );
// // // //                         }
// // // //                         return const Center(
// // // //                           child: CircularProgressIndicator(),
// // // //                         );
// // // //                       })),
// // // //               Container(
// // // //                 padding: EdgeInsets.all(20),
// // // //                 child: Row(
// // // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //                   children: [
// // // //                     Expanded(
// // // //                       child: TextFormField(
// // // //                         controller: textController,
// // // //                         decoration: InputDecoration(hintText: 'text here'),
// // // //                       ),
// // // //                     ),
// // // //                     IconButton(
// // // //                         onPressed: () {}, icon: Icon(Icons.arrow_circle_up)),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //               Text("Logged in as :" + currentUser.email!),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:plastic_eliminator/pages/posts.dart';

// // // class Community extends StatefulWidget {
// // //   const Community({super.key});

// // //   @override
// // //   State<Community> createState() => _CommunityState();
// // // }

// // // class _CommunityState extends State<Community> {
// // //   final TextEditingController textController = TextEditingController();
// // //   final currentUser = FirebaseAuth.instance.currentUser!;

// // //   void postMessage() {
// // //     if (textController.text.isNotEmpty) {
// // //       FirebaseFirestore.instance.collection('UserPosts').add({
// // //         'userEmail': currentUser.email,
// // //         'message': textController.text,
// // //         'timestamp': Timestamp.now(),
// // //         'likes': []
// // //       });
// // //       textController.clear(); // Clear the text field after posting
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('the wall'),
// // //         leading: Icon(Icons.arrow_back_ios_new_outlined),
// // //       ),
// // //       body: Container(
// // //         margin: EdgeInsets.only(bottom: 20),
// // //         child: Center(
// // //           child: Column(
// // //             children: [
// // //               Expanded(
// // //                 child: StreamBuilder(
// // //                   stream: FirebaseFirestore.instance
// // //                       .collection("UserPosts")
// // //                       .orderBy("timestamp", descending: false)
// // //                       .snapshots(),
// // //                   builder: (context, snapshot) {
// // //                     if (snapshot.hasData) {
// // //                       return ListView.builder(
// // //                         itemCount: snapshot.data!.docs.length,
// // //                         itemBuilder: (context, index) {
// // //                           final post = snapshot.data!.docs[index];
// // //                           return Posts(
// // //                             message: post['message'],
// // //                             user: post['userEmail'],
// // //                             // PostID: post.id,
// // //                             postID: post.id,
// // //                             likes: List<String>.from(post['Likes'] ?? []),

// // //                             // time: post['timestamp']
// // //                             // .toDate()
// // //                             // .toString(), // Assuming you want to show the timestamp as well
// // //                           );
// // //                         },
// // //                       );
// // //                     } else if (snapshot.hasError) {
// // //                       return Center(
// // //                         child: Text('Error: ' + snapshot.error.toString()),
// // //                       );
// // //                     }
// // //                     return const Center(
// // //                       child: CircularProgressIndicator(),
// // //                     );
// // //                   },
// // //                 ),
// // //               ),
// // //               Container(
// // //                 padding: EdgeInsets.all(20),
// // //                 child: Row(
// // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                   children: [
// // //                     Expanded(
// // //                       child: TextFormField(
// // //                         controller: textController,
// // //                         decoration: InputDecoration(hintText: 'text here'),
// // //                       ),
// // //                     ),
// // //                     IconButton(
// // //                       onPressed: postMessage,
// // //                       icon: Icon(Icons.arrow_circle_up),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //               Text("Logged in as: " + currentUser.email!),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:plastic_eliminator/pages/posts.dart';

// // class Community extends StatefulWidget {
// //   const Community({super.key});

// //   @override
// //   State<Community> createState() => _CommunityState();
// // }

// // class _CommunityState extends State<Community> {
// //   final TextEditingController textController = TextEditingController();
// //   final currentUser = FirebaseAuth.instance.currentUser!;

// //   void postMessage() {
// //     if (textController.text.isNotEmpty) {
// //       FirebaseFirestore.instance.collection('UserPosts').add({
// //         'UserEmail': currentUser.email,
// //         'Message': textController.text,
// //         'TimeStamp': Timestamp.now(),
// //         'likes': [], // Initialize the likes field as an empty list
// //       });
// //       textController.clear(); // Clear the text field after posting
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('the wall'),
// //         leading: Icon(Icons.arrow_back_ios_new_outlined),
// //       ),
// //       body: Container(
// //         margin: EdgeInsets.only(bottom: 20),
// //         child: Center(
// //           child: Column(
// //             children: [
// //               Expanded(
// //                 child: StreamBuilder(
// //                   stream: FirebaseFirestore.instance
// //                       .collection("UserPosts")
// //                       .orderBy(
// //                         "TimeStamp",
// //                         descending: false,
// //                       )
// //                       .snapshots(),
// //                   builder: (context, snapshot) {
// //                     if (snapshot.hasData) {
// //                       return ListView.builder(
// //                         itemCount: snapshot.data!.docs.length,
// //                         itemBuilder: (context, index) {
// //                           final post = snapshot.data!.docs[index];
// //                           final likes = List<String>.from(
// //                               post.data().containsKey('likes')
// //                                   ? post['likes']
// //                                   : []);
// //                           return Posts(
// //                             message: post['Message'],
// //                             postID: post.id,
// //                             likes: List<String>.from(post['Likes'] ?? []),
// //                             user: post['UserEmail'],
// //                           );
// //                         },
// //                       );
// //                     } else if (snapshot.hasError) {
// //                       return Center(
// //                         child: Text('Error: ${snapshot.error}'),
// //                       );
// //                     }
// //                     return const Center(
// //                       child: CircularProgressIndicator(),
// //                     );
// //                   },
// //                 ),
// //               ),
// //               Container(
// //                 padding: EdgeInsets.all(20),
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Expanded(
// //                       child: TextFormField(
// //                         controller: textController,
// //                         decoration: InputDecoration(hintText: 'text here'),
// //                       ),
// //                     ),
// //                     IconButton(
// //                       onPressed: postMessage,
// //                       icon: Icon(Icons.arrow_circle_up),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               Text("Logged in as: ${currentUser.email!}"),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:plastic_eliminator/pages/posts.dart';

// class Community extends StatefulWidget {
//   const Community({super.key});

//   @override
//   State<Community> createState() => _CommunityState();
// }

// class _CommunityState extends State<Community> {
//   final TextEditingController textController = TextEditingController();
//   final currentUser = FirebaseAuth.instance.currentUser!;

//   void postMessage() {
//     if (textController.text.isNotEmpty) {
//       FirebaseFirestore.instance.collection('UserPosts').add({
//         'UserEmail': currentUser.email,
//         'Message': textController.text,
//         'TimeStamp': Timestamp.now(),
//         'likes': [], // Initialize the likes field as an empty list
//       });
//       textController.clear(); // Clear the text field after posting
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('the wall'),
//         leading: Icon(Icons.arrow_back_ios_new_outlined),
//       ),
//       body: Container(
//         margin: EdgeInsets.only(bottom: 20),
//         child: Center(
//           child: Column(
//             children: [
//               Expanded(
//                 child: StreamBuilder(
//                   stream: FirebaseFirestore.instance
//                       .collection("UserPosts")
//                       .orderBy(
//                         "TimeStamp",
//                         descending: false,
//                       )
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       return ListView.builder(
//                         itemCount: snapshot.data!.docs.length,
//                         itemBuilder: (context, index) {
//                           final post = snapshot.data!.docs[index];
//                           final likes = List<String>.from(
//                             post.data().containsKey('likes')
//                                 ? post['likes']
//                                 : [],
//                           );
//                           return Posts(
//                             message: post['Message'],
//                             postID: post.id,
//                             likes: likes,
//                             user: post['UserEmail'],
//                           );
//                         },
//                       );
//                     } else if (snapshot.hasError) {
//                       return Center(
//                         child: Text('Error: ${snapshot.error}'),
//                       );
//                     }
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   },
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         controller: textController,
//                         decoration: InputDecoration(hintText: 'text here'),
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: postMessage,
//                       icon: Icon(Icons.arrow_circle_up),
//                     ),
//                   ],
//                 ),
//               ),
//               Text("Logged in as: ${currentUser.email!}"),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plastic_eliminator/pages/posts.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  final TextEditingController textController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;

  void postMessage() {
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('UserPosts').add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
        'likes': [], // Initialize the likes field as an empty list
      });
      textController.clear(); // Clear the text field after posting
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('the wall'),
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
                        decoration: InputDecoration(hintText: 'text here'),
                      ),
                    ),
                    IconButton(
                      onPressed: postMessage,
                      icon: Icon(Icons.arrow_circle_up),
                    ),
                  ],
                ),
              ),
              Text("Logged in as: ${currentUser.email!}"),
            ],
          ),
        ),
      ),
    );
  }
}
