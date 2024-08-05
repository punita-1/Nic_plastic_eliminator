import 'package:flutter/material.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/learn_pages/benefit.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/learn_pages/pollution.dart';
import 'package:plastic_eliminator/pages/idk_pages/products.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/learn_pages/recycle.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/learn_pages/sustain.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/learn_pages/waste.dart';

class LearningsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.teal[100]!,
        title: Text(
          'Learn',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio:
              0.75, // Adjust the aspect ratio to fit the screen better
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return _buildGridItem(
                context,
                'Pollution',
                'Assets/images/air-pollution.png',
                PollutionDetailPage(),
                Colors.white,
              );
            case 1:
              return _buildGridItem(
                context,
                'Recycling',
                'Assets/images/study.png',
                RecyclingDetailPage(),
                Colors.white,
              );
            case 2:
              return _buildGridItem(
                context,
                'Plastic Waste',
                'Assets/images/garbage.png',
                PlasticWasteDetailPage(),
                Colors.white,
              );
            case 3:
              return _buildGridItem(
                context,
                'Sustainable Alternatives',
                'Assets/images/save-the-planet.png',
                SustainableAlternativesDetailPage(),
                Colors.white,
              );
            case 4:
              return _buildGridItem(
                context,
                'Products',
                'Assets/images/grocery-cart.png',
                Products_usedetailPage(),
                Colors.white,
              );
            case 5:
              return _buildGridItem(
                context,
                'Benefits',
                'Assets/images/privilege.png',
                Benefits_detailePage(),
                Colors.white,
              );
            default:
              return Container();
          }
        },
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String title, String imagePath,
      Widget detailPage, Color bgColor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => detailPage,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80, // Adjust the height as needed
              width: 80, // Adjust the width as needed
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
