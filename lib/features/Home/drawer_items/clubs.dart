import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// A widget that allows users to select a club from a predefined list.
///
/// This widget retrieves and displays a list of clubs and updates the selected club in Firestore
/// for the currently authenticated user.
class Club extends StatefulWidget {
  const Club({super.key});

  @override
  State<Club> createState() => _ClubState();
}

class _ClubState extends State<Club> {
  // List of clubs to display
  final List<Map<String, String>> _clubs = [
    {
      'name': 'Club1: No Plastic Use',
      'details': 'I will never use plastic again'
    },
    {
      'name': 'Club2: Teach Plastic Waste Reduction',
      'details': 'Educating others about reducing plastic waste'
    },
    {
      'name': 'Club3: Community Cleanup',
      'details': 'Participate in community clean-up events'
    },
    {
      'name': 'Club4: Plastic Recycling',
      'details': 'Promoting and participating in plastic recycling initiatives'
    }
  ];

  // Currently selected club
  String? _selectedClub;
  bool _isUpdating = false; // To track if the update is in progress

  /// Updates the current user's club in Firestore with the provided club name.
  ///
  /// If the user is authenticated, this method updates the 'club' field of the user's document
  /// in the 'users' collection.
  Future<void> _updateClub(String clubName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _isUpdating = true;
      });

      try {
        final userRef =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        await userRef.update({'club': clubName});
      } catch (e) {
        // Handle errors (e.g., show an error message)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating club: $e'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isUpdating = false;
        });
      }
    }
  }

  /// Shows a dialog with details about the selected club.
  void _showClubDetails(String clubName, String details) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(clubName),
          content: Text(details),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Select a Club'),
      ),
      body: _isUpdating
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _clubs.length,
              itemBuilder: (context, index) {
                final club = _clubs[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 3.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      club['name']!,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    trailing: _selectedClub == club['name']
                        ? const Icon(Icons.check, color: Colors.green)
                        : null,
                    onTap: () {
                      final user = FirebaseAuth.instance.currentUser;

                      if (user == null) {
                        // If user is not logged in, show a SnackBar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please log in first.'),
                            // backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        setState(() {
                          _selectedClub = club['name'];
                        });
                        _updateClub(club['name']!);
                        _showClubDetails(club['name']!, club['details']!);
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}
