import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Club extends StatefulWidget {
  const Club({super.key});

  @override
  State<Club> createState() => _ClubState();
}

class _ClubState extends State<Club> {
  final List<String> _clubs = [
    'Club1: No Plastic Use',
    'Club2: Teach Plastic Waste Reduction',
    'Club3: Community Cleanup',
    'Club4: Plastic Recycling'
  ];

  String? _selectedClub;

  Future<void> _updateClub(String clubName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      await userRef.update({'club': clubName});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Select a Club'),
      ),
      body: ListView.builder(
        itemCount: _clubs.length,
        itemBuilder: (context, index) {
          final club = _clubs[index];
          return ListTile(
            title: Text(club),
            trailing: _selectedClub == club
                ? Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () {
              setState(() {
                _selectedClub = club;
              });
              _updateClub(club);
            },
          );
        },
      ),
    );
  }
}
