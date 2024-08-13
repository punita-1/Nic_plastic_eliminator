import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Initiatives',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('news')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No initiatives available.'));
          }

          final newsList = snapshot.data!.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();

          return ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              final newsItem = newsList[index];
              return _buildNewsCard(
                newsItem['title'] ?? '',
                newsItem['description'] ?? '',
                newsItem['date'] ?? '',
                index,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildNewsCard(
      String title, String description, String date, int index) {
    // final color =
    //     Colors.primaries[index % Colors.primaries.length].withOpacity(0.1);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      // color: color,
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(date),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
