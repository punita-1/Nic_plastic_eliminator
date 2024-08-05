// // import 'package:flutter/material.dart';
// // import 'package:plastic_eliminator/pages/Home_page/shops_page/shopsdetailpage.dart';

// // class ShopList extends StatefulWidget {
// //   const ShopList({super.key});

// //   @override
// //   _ShopListState createState() => _ShopListState();
// // }

// // class _ShopListState extends State<ShopList> {
// //   final ScrollController _shopScrollController = ScrollController();

// //   @override
// //   void dispose() {
// //     _shopScrollController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return SizedBox(
// //       height: 100.0, // Height for the whole list view
// //       child: ListView.builder(
// //         scrollDirection: Axis.horizontal,
// //         controller: _shopScrollController,
// //         itemCount: 8,
// //         itemBuilder: (context, index) {
// //           return GestureDetector(
// //             onTap: () {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(
// //                   builder: (context) => ShopDetailPage(
// //                     shopName: 'Shop ${index + 1}',
// //                     phoneNumber: '2345678',
// //                     address: 'sdfghjk',
// //                   ),
// //                 ),
// //               );
// //             },
// //             child: Container(
// //               width: 80.0, // Fixed width for each shop item
// //               // margin: const EdgeInsets.symmetric(horizontal: 10.0),
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Container(
// //                     width: 60.0,
// //                     height: 60.0,
// //                     decoration: BoxDecoration(
// //                       shape: BoxShape.circle,
// //                       color: Theme.of(context).colorScheme.secondary,
// //                     ),
// //                     child: Center(),
// //                   ),
// //                   const SizedBox(height: 6.0), // Space between circle and text
// //                   Text(
// //                     'Shop ${index + 1}', // Shop name text outside the circle
// //                     style: TextStyle(
// //                       fontSize: 12.0,
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.black,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:plastic_eliminator/pages/Home_page/shops_page/shopsdetailpage.dart';

// class ShopList extends StatefulWidget {
//   const ShopList({super.key});

//   @override
//   _ShopListState createState() => _ShopListState();
// }

// class _ShopListState extends State<ShopList> {
//   final ScrollController _shopScrollController = ScrollController();
//   final CollectionReference shopsCollection =
//       FirebaseFirestore.instance.collection('shops');

//   @override
//   void dispose() {
//     _shopScrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 100.0, // Height for the whole list view
//       child: StreamBuilder<QuerySnapshot>(
//         stream: shopsCollection.snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData) {
//             return Center(child: Text('No shops available'));
//           }

//           final shopDocs = snapshot.data!.docs;

//           return ListView.builder(
//             scrollDirection: Axis.horizontal,
//             controller: _shopScrollController,
//             itemCount: shopDocs.length,
//             itemBuilder: (context, index) {
//               var shopData = shopDocs[index].data() as Map<String, dynamic>;

//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ShopDetailPage(
//                         shopName: shopData['name'] ?? 'No Name',
//                         phoneNumber:
//                             shopData['phoneNumber'] ?? 'No Phone Number',
//                         address: shopData['address'] ?? 'No Address',
//                       ),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: 80.0, // Fixed width for each shop item
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         width: 60.0,
//                         height: 60.0,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Theme.of(context).colorScheme.secondary,
//                         ),
//                         child: Center(),
//                       ),
//                       const SizedBox(
//                           height: 6.0), // Space between circle and text
//                       Text(
//                         shopData['name'] ??
//                             'No Name', // Shop name text outside the circle
//                         style: TextStyle(
//                           fontSize: 12.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
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
import 'package:plastic_eliminator/pages/Home_page/shops_page/shopsdetailpage.dart';

class ShopList extends StatefulWidget {
  const ShopList({super.key});

  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  final ScrollController _shopScrollController = ScrollController();
  final CollectionReference shopsCollection =
      FirebaseFirestore.instance.collection('shops');

  @override
  void dispose() {
    _shopScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0, // Height for the whole list view
      child: StreamBuilder<QuerySnapshot>(
        stream: shopsCollection.limit(6).snapshots(), // Fetch only 7 documents
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Center(child: Text('No shops available'));
          }

          final shopDocs = snapshot.data!.docs;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: _shopScrollController,
            itemCount: shopDocs.length,
            itemBuilder: (context, index) {
              var shopData = shopDocs[index].data() as Map<String, dynamic>;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShopDetailPage(
                        shopName: shopData['name'] ?? 'No Name',
                        phoneNumber:
                            shopData['phoneNumber'] ?? 'No Phone Number',
                        address: shopData['address'] ?? 'No Address',
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 80.0, // Fixed width for each shop item
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        child: Center(),
                      ),
                      const SizedBox(
                          height: 6.0), // Space between circle and text
                      Text(
                        shopData['name'] ??
                            'No Name', // Shop name text outside the circle
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
