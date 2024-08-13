import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plastic_eliminator/features/Home/drawer_items/NGO_pages.dart/ngo_details.dart';

class ShowAllNGOs extends StatefulWidget {
  const ShowAllNGOs({super.key});

  @override
  State<ShowAllNGOs> createState() => _ShowAllNGOsState();
}

class _ShowAllNGOsState extends State<ShowAllNGOs> {
  final CollectionReference ngoCollection =
      FirebaseFirestore.instance.collection('ngo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NGOs'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: ngoCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No NGOs available'));
          }

          final ngoDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: ngoDocs.length,
            itemBuilder: (context, index) {
              var ngoData = ngoDocs[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: Icon(Icons.volunteer_activism),
                  title: Text(ngoData['name'] ?? 'No Name'),
                  subtitle:
                      Text('Description of ${ngoData['name'] ?? 'No Name'}'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NGODetailPage(
                          name: ngoData['name'] ?? 'No Name',
                          address: ngoData['address'] ?? 'No Address',
                          phoneNumber:
                              ngoData['phoneNumber'] ?? 'No Phone Number',
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
