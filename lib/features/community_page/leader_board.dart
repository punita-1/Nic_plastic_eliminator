// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// /// A page that displays the top users based on their total likes.
// /// It fetches data from Firestore, calculates the total likes for each user,
// /// and displays the top users in a leaderboard format.
// class LeaderboardPage extends StatefulWidget {
//   const LeaderboardPage({Key? key}) : super(key: key);

//   @override
//   State<LeaderboardPage> createState() => _LeaderboardPageState();
// }

// class _LeaderboardPageState extends State<LeaderboardPage> {
//   /// A list to hold the top users with their total likes.
//   List<Map<String, dynamic>> _topUsers = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchTopUsers();
//   }

//   /// Fetches top users from Firestore and updates the state with the top 10 users.
//   Future<void> _fetchTopUsers() async {
//     try {
//       final userPostsCollection =
//           FirebaseFirestore.instance.collection('UserMediaPosts');
//       final querySnapshot = await userPostsCollection.get();

//       final Map<String, int> userLikesMap = {};

//       // Aggregate likes for each user
//       for (var doc in querySnapshot.docs) {
//         final data = doc.data() as Map<String, dynamic>;
//         final userEmail = data['UserEmail'] as String?;
//         final likes = data['Likes'] as int? ?? 0;

//         if (userEmail != null) {
//           userLikesMap.update(
//             userEmail,
//             (existingLikes) => existingLikes + likes,
//             ifAbsent: () => likes,
//           );
//         }
//       }

//       // Sort users by total likes in descending order and take the top 10
//       final sortedUsers = userLikesMap.entries
//           .map((entry) => {'email': entry.key, 'totalLikes': entry.value})
//           .toList()
//         ..sort((a, b) =>
//             (b['totalLikes'] as int).compareTo(a['totalLikes'] as int));

//       final topUsers = sortedUsers.take(10).toList();

//       setState(() {
//         _topUsers = topUsers;
//       });
//     } catch (e) {
//       print('Error fetching top users: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Leaderboard'),
//       ),
//       body: _topUsers.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: _topUsers.length,
//               itemBuilder: (context, index) {
//                 final user = _topUsers[index];
//                 return ListTile(
//                   title: Text(user['email']),
//                   trailing: Text('Likes: ${user['totalLikes']}'),
//                 );
//               },
//             ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// A page that displays the top users based on their total likes.
/// It fetches data from Firestore, calculates the total likes for each user,
/// and displays the top users in a leaderboard format.
class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  /// A list to hold the top users with their total likes.
  List<Map<String, dynamic>> _topUsers = [];

  @override
  void initState() {
    super.initState();
    _fetchTopUsers();
  }

  /// Fetches top users from Firestore and updates the state with the top 10 users.
  Future<void> _fetchTopUsers() async {
    try {
      final userPostsCollection =
          FirebaseFirestore.instance.collection('UserMediaPosts');
      final querySnapshot = await userPostsCollection.get();

      final Map<String, int> userLikesMap = {};

      // Aggregate likes for each user
      for (var doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final userEmail = data['UserEmail'] as String?;
        final likes = data['Likes'] as int? ?? 0;

        if (userEmail != null) {
          userLikesMap.update(
            userEmail,
            (existingLikes) => existingLikes + likes,
            ifAbsent: () => likes,
          );
        }
      }

      // Sort users by total likes in descending order and take the top 10
      final sortedUsers = userLikesMap.entries
          .map((entry) => {'email': entry.key, 'totalLikes': entry.value})
          .toList()
        ..sort((a, b) =>
            (b['totalLikes'] as int).compareTo(a['totalLikes'] as int));

      final topUsers = sortedUsers.take(10).toList();

      setState(() {
        _topUsers = topUsers;
      });
    } catch (e) {
      print('Error fetching top users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Leaderboard'),
      ),
      body: _topUsers.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _topUsers.length,
              itemBuilder: (context, index) {
                final user = _topUsers[index];
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: 16.0, // Adjust the radius to make it smaller
                        child: Text(
                          '${index + 1}', // Serial number
                          style: TextStyle(
                              fontSize:
                                  12.0), // Adjust font size to fit within the smaller CircleAvatar
                        ),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        foregroundColor: Colors.white,
                      ),
                      title: Text(
                        user['email'],
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      trailing: Container(
                          padding: EdgeInsets.only(
                              left: 5, right: 5, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.teal),
                            // color: Colors.white,
                          ),
                          child: Text(
                            'Likes: ${user['totalLikes']}',
                            style: TextStyle(fontSize: 12),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Divider(),
                    )
                  ],
                );
              },
            ),
    );
  }
}
