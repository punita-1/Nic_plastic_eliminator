import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/calculator/plastic_final/edit.dart';

class PlasticImpactScreen extends StatefulWidget {
  @override
  _PlasticImpactScreenState createState() => _PlasticImpactScreenState();
}

class _PlasticImpactScreenState extends State<PlasticImpactScreen> {
  int plasticBags = 0;
  int plasticBottles = 0;
  double plasticItems = 0.0;
  int disposableItems = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPlasticUsageDetails();
  }

  Future<void> _fetchPlasticUsageDetails() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      final snapshot = await userDoc.get();

      if (snapshot.exists) {
        setState(() {
          plasticBags = snapshot['plasticBags'] ?? 0;
          plasticBottles = snapshot['plasticBottles'] ?? 0;
          plasticItems = snapshot['plasticItems'] ?? 0.0;
          disposableItems = snapshot['disposableItems'] ?? 0;
          isLoading = false;
        });
      }
    }
  }

  Future<void> _editPlasticDetails() async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EditPlasticDetailsScreen(),
    ));
    if (result == true) {
      // Refresh the plastic usage details after editing
      _fetchPlasticUsageDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plastic Impact Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _editPlasticDetails,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : PlasticImpactDetails(
              plasticBags: plasticBags,
              plasticBottles: plasticBottles,
              plasticItems: plasticItems,
              disposableItems: disposableItems,
            ),
    );
  }
}

class PlasticImpactDetails extends StatelessWidget {
  final int plasticBags;
  final int plasticBottles;
  final double plasticItems;
  final int disposableItems;

  PlasticImpactDetails({
    required this.plasticBags,
    required this.plasticBottles,
    required this.plasticItems,
    required this.disposableItems,
  });

  Map<String, dynamic> calculateImpact() {
    final plasticBagsDegradationTime = 10; // years
    final plasticBottlesDegradationTime = 450; // years
    final plasticItemsDegradationTime = 50; // years
    final disposableItemsDegradationTime = 20; // years

    final totalDegradationTime = (plasticBags * plasticBagsDegradationTime) +
        (plasticBottles * plasticBottlesDegradationTime) +
        (plasticItems * plasticItemsDegradationTime) +
        (disposableItems * disposableItemsDegradationTime);

    final impactOnLand =
        "Plastic pollution disrupts soil fertility and wildlife habitats.";
    final impactOnOcean =
        "Marine life is threatened by ingestion, entanglement, and toxic pollutants.";
    final impactWhenBurnt =
        "Releases harmful chemicals and greenhouse gases into the atmosphere.";

    return {
      'totalDegradationTime': totalDegradationTime,
      'impactOnLand': impactOnLand,
      'impactOnOcean': impactOnOcean,
      'impactWhenBurnt': impactWhenBurnt,
    };
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final double fontSize = 16;
      final double radius = 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: plasticBags.toDouble(),
            title: '$plasticBags\nPlastic Bags',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.orange,
            value: plasticBottles.toDouble(),
            title: '$plasticBottles\nPlastic Bottles',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.green,
            value: plasticItems,
            title: '$plasticItems kg\nPlastic Items',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.red,
            value: disposableItems.toDouble(),
            title: '$disposableItems\nDisposable Items',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final impact = calculateImpact();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Total Degradation Time: ${impact['totalDegradationTime']} years',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Wrap PieChart in a Container with a fixed height
            Container(
              height: 300, // Set a fixed height
              child: PieChart(
                PieChartData(
                  sections: showingSections(),
                  centerSpaceRadius: 40,
                  sectionsSpace: 2,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Impact on Land:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(impact['impactOnLand']),
            SizedBox(height: 20),
            Text(
              'Impact on Ocean:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(impact['impactOnOcean']),
            SizedBox(height: 20),
            Text(
              'Impact when Burnt:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(impact['impactWhenBurnt']),
          ],
        ),
      ),
    );
  }
}
