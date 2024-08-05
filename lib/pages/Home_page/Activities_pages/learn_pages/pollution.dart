import 'package:flutter/material.dart';

class PollutionDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.teal[100]!,
        title: Text(
          'Pollution',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 100),
                  child: Container(
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      'Assets/images/garbage.png', // Replace with your image asset
                      height: 200.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Understanding Plastic Pollution',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildInfoCard(
              title: 'Global Issue',
              description:
                  'Over 8 million tons of plastic waste enter the ocean each year, equivalent to dumping a garbage truck full of plastic into the ocean every minute.',
              color: Colors.white,
            ),
            _buildInfoCard(
              title: 'Sources',
              description:
                  'Approximately 50% of plastic produced is single-use, including items like straws, cutlery, and packaging.',
              color: Colors.white,
            ),
            _buildInfoCard(
              title: 'Impact on Wildlife',
              description:
                  'Over 1 million seabirds and 100,000 marine mammals die each year due to plastic pollution.',
              color: Colors.white,
            ),
            _buildInfoCard(
              title: 'Ocean Pollution',
              description:
                  'The Great Pacific Garbage Patch, a massive area of floating plastic waste in the Pacific Ocean, is estimated to be twice the size of Texas.',
              color: Colors.white,
            ),
            _buildInfoCard(
              title: 'Microplastics',
              description:
                  'Microplastics, tiny plastic particles less than 5mm in size, have been found in 100% of the world\'s oceans and are present in the food chain.',
              color: Colors.white,
            ),
            _buildInfoCard(
              title: 'Environmental Damage',
              description:
                  'Plastic waste can take up to 1,000 years to decompose, leading to long-lasting environmental contamination.',
              color: Colors.white,
            ),
            _buildInfoCard(
              title: 'Health Risks',
              description:
                  'Chemicals from plastics, such as bisphenol A (BPA), can leach into food and water, potentially leading to health issues like hormone disruption and cancer.',
              color: Colors.white,
            ),
            _buildInfoCard(
              title: 'Waste Management',
              description:
                  'Only 9% of plastic waste ever produced has been recycled, while the rest ends up in landfills, incinerated, or in the environment.',
              color: Colors.white,
            ),
            _buildInfoCard(
              title: 'Reducing Plastic Use',
              description:
                  'Using reusable bags, bottles, and containers can reduce personal plastic use by hundreds of pounds per year.',
              color: Colors.white,
            ),
            _buildInfoCard(
              title: 'Global Initiatives',
              description:
                  'The United Nations Environment Programme (UNEP) has launched initiatives like the Clean Seas campaign to reduce plastic pollution globally.',
              color: Colors.white,
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                child: Text('Learn More'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                  textStyle: TextStyle(fontSize: 18.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8.0), // Adjust this value for less curve
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String description,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      color: color,
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              description,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
