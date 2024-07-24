// import 'package:flutter/material.dart';
// import 'package:plastic_eliminator/pages/like_button.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class Posts extends StatefulWidget {
//   final String message;
//   final String user;
//   final String postID;
//   final List<String> likes;

//   const Posts({
//     super.key,
//     required this.message,
//     required this.postID,
//     required this.likes,
//     required this.user,
//   });

//   @override
//   State<Posts> createState() => _PostsState();
// }

// class _PostsState extends State<Posts> {
//   final currentUser = FirebaseAuth.instance.currentUser!;
//   late bool isLiked;

//   @override
//   void initState() {
//     super.initState();
//     isLiked = widget.likes.contains(currentUser.email);
//   }

//   void toggleLike() {
//     setState(() {
//       isLiked = !isLiked;
//     });

//     DocumentReference postRef =
//         FirebaseFirestore.instance.collection('UserPosts').doc(widget.postID);

//     if (isLiked) {
//       postRef.update({
//         'Likes': FieldValue.arrayUnion([currentUser.email])
//       });
//     } else {
//       postRef.update({
//         'Likes': FieldValue.arrayRemove([currentUser.email])
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(10),
//       padding: const EdgeInsets.all(10),
//       decoration: const BoxDecoration(color: Colors.white),
//       child: Row(
//         children: [
//           Column(
//             children: [
//               LikeButton(isliked: isLiked, onTap: toggleLike),
//               SizedBox(
//                 height: 5,
//               ),
//               Text(widget.likes.length.toString()),
//             ],
//           ),
//           const SizedBox(width: 10),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.user,
//                 style: const TextStyle(color: Colors.grey),
//               ),
//               const SizedBox(height: 10),
//               Text(widget.message),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:plastic_eliminator/pages/like_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Posts extends StatefulWidget {
  final String message;
  final String user;
  final String postID;
  final List<String> likes;

  const Posts({
    super.key,
    required this.message,
    required this.postID,
    required this.likes,
    required this.user,
  });

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  late bool isLiked;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Column(
            children: [
              LikeButton(isliked: isLiked, onTap: toggleLike),
              SizedBox(
                height: 5,
              ),
              Text(widget.likes.length.toString()),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Text(widget.message),
            ],
          ),
        ],
      ),
    );
  }
}
