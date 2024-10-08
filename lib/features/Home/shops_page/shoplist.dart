import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plastic_eliminator/features/Home/shops_page/shopsdetailpage.dart';

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
        stream: shopsCollection.snapshots(),
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
                        description:
                            shopData['description'] ?? 'No Description',
                        homeDelivery:
                            shopData['home_delivery'] ?? 'Not Available',
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 80.0, // Fixed width for each item
                  margin: EdgeInsets.symmetric(horizontal: 4.0), // Margin between items
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
                        child: Center(
                          child: Icon(
                            Icons.store,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                          height: 6.0), // Space between circle and text
                      Expanded(
                        child: Text(
                          shopData['name'] ?? 'No Name',
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis, // Ellipsis for overflow
                          maxLines: 1, // Restrict to one line
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
