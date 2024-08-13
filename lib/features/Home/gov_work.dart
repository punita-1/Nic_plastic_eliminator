import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plastic_eliminator/features/Home/govinitiativdetail.dart';
// import 'initiative_detail_page.dart';

class PlasticSectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.teal,
        title: Text(
          'Government Initiatives',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Initiative>>(
          future: fetchInitiativesFromFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No initiatives found.'));
            }

            List<Initiative> initiatives = snapshot.data!;

            return ListView.builder(
              itemCount: initiatives.length,
              itemBuilder: (context, index) {
                final initiative = initiatives[index];
                return InitiativeCard(initiative: initiative);
              },
            );
          },
        ),
      ),
    );
  }

  Future<List<Initiative>> fetchInitiativesFromFirebase() async {
    final firestore = FirebaseFirestore.instance;
    final querySnapshot = await firestore.collection('initiatives').get();
    return querySnapshot.docs.map((doc) => Initiative.fromFirestore(doc)).toList();
  }
}

class Initiative {
  final String title;
  final String smallDescription;
  final String largeDescription;
  final String imageUrl;
  final DateTime date;

  Initiative({
    required this.title,
    required this.smallDescription,
    required this.largeDescription,
    required this.imageUrl,
    required this.date,
  });

  factory Initiative.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Initiative(
      title: data['title'] ?? '',
      smallDescription: data['smallDescription'] ?? '',
      largeDescription: data['largeDescription'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
    );
  }
}

class InitiativeCard extends StatelessWidget {
  final Initiative initiative;

  InitiativeCard({required this.initiative});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  InitiativeDetailPage(initiative: initiative),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
              child: Image.network(
                initiative.imageUrl,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                initiative.title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Text(
                "${initiative.date.toLocal()}",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Text(
                initiative.smallDescription,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
