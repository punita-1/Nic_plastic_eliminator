import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  List<Map<String, dynamic>> _topUsers = [];

  @override
  void initState() {
    super.initState();
    _fetchTopUsers();
  }

  Future<void> _fetchTopUsers() async {
    try {
      final userPostsCollection =
          FirebaseFirestore.instance.collection('UserMediaPosts');
      final querySnapshot = await userPostsCollection.get();

      final Map<String, int> userLikesMap = {};

      for (var doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final userEmail = data['UserEmail'] as String?;
        final likes = data['Likes'] as int? ?? 0;

        if (userEmail != null) {
          if (userLikesMap.containsKey(userEmail)) {
            userLikesMap[userEmail] = userLikesMap[userEmail]! + likes;
          } else {
            userLikesMap[userEmail] = likes;
          }
        }

        final sortedUsers = userLikesMap.entries
            .map((entry) => {'email': entry.key, 'totalLikes': entry.value})
            .toList()
          ..sort((a, b) =>
              (b['totalLikes'] as int).compareTo(a['totalLikes'] as int));

        final topUsers = sortedUsers.take(10).toList();

        setState(() {
          _topUsers = topUsers;
        });
      }
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
                return ListTile(
                  title: Text(user['email']),
                  trailing: Text('Likes: ${user['totalLikes']}'),
                );
              },
            ),
    );
  }
}
