// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:plastic_eliminator/pages/Home_page/shops_page/allShops_detailspage.dart';

// class ShowAll extends StatefulWidget {
//   const ShowAll({super.key});

//   @override
//   State<ShowAll> createState() => _ShowAllState();
// }

// class _ShowAllState extends State<ShowAll> {
//   final CollectionReference shopsCollection =
//       FirebaseFirestore.instance.collection('shops');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Shops'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: shopsCollection.snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(child: Text('No shops available'));
//           }

//           final shopDocs = snapshot.data!.docs;

//           return ListView.builder(
//             itemCount: shopDocs.length,
//             itemBuilder: (context, index) {
//               var shopData = shopDocs[index].data() as Map<String, dynamic>;

//               return Card(
//                 margin: const EdgeInsets.all(10),
//                 child: ListTile(
//                   leading: Icon(Icons.store),
//                   title: Text(shopData['name'] ?? 'No Name'),
//                   subtitle: Text(shopData['description'] ?? 'No Description'),
//                   trailing: Icon(Icons.arrow_forward),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ShopDetailsPage(
//                           shopName: shopData['name'] ?? 'No Name',
//                           phoneNumber:
//                               shopData['phoneNumber'] ?? 'No Phone Number',
//                           address: shopData['address'] ?? 'No Address',
//                           description:
//                               shopData['description'] ?? 'No Description',
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plastic_eliminator/pages/Home_page/shops_page/allShops_detailspage.dart';

class ShowAll extends StatefulWidget {
  const ShowAll({super.key});

  @override
  State<ShowAll> createState() => _ShowAllState();
}

class _ShowAllState extends State<ShowAll> {
  final CollectionReference shopsCollection =
      FirebaseFirestore.instance.collection('shops');
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shops'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search shops...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: shopsCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No shops available'));
                }

                final shopDocs = snapshot.data!.docs;
                final filteredShops = shopDocs.where((shop) {
                  var shopData = shop.data() as Map<String, dynamic>;
                  var shopName = shopData['name']?.toLowerCase() ?? '';
                  return shopName.contains(searchQuery);
                }).toList();

                if (filteredShops.isEmpty) {
                  return Center(child: Text('No shops match your search'));
                }

                return ListView.builder(
                  itemCount: filteredShops.length,
                  itemBuilder: (context, index) {
                    var shopData =
                        filteredShops[index].data() as Map<String, dynamic>;

                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: Icon(Icons.store),
                        title: Text(shopData['name'] ?? 'No Name'),
                        subtitle:
                            Text(shopData['description'] ?? 'No Description'),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopDetailsPage(
                                shopName: shopData['name'] ?? 'No Name',
                                phoneNumber: shopData['phoneNumber'] ??
                                    'No Phone Number',
                                address: shopData['address'] ?? 'No Address',
                                description:
                                    shopData['description'] ?? 'No Description',
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
          ),
        ],
      ),
    );
  }
}
