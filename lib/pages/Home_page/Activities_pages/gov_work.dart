import 'package:flutter/material.dart';

class PlasticSectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the screen height
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.teal[100]!,
        title: Text(
          'Government',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Full-width container with height as a proportion of the screen height
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Pastel Pink
                borderRadius: BorderRadius.circular(16.0), // Rounded corners
              ),
              width: double.infinity,
              height: screenHeight * 0.5, // 50% of screen height
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Center(
                child: Text(
                  'Did you know?\n\nA tortoise made entirely of plastic bags was created in Kurukshetra, setting a world record. This highlights the dire need for plastic eradication to protect our environment.',
                  style: TextStyle(
                    fontFamily: 'Lobster',
                    fontSize: 24.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 8.0), // Space between containers
            // Row of two equally sized containers with height as a proportion of the screen height
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Pastel Blue
                      borderRadius:
                          BorderRadius.circular(16.0), // Rounded corners
                    ),
                    height: screenHeight * 0.3, // 30% of screen height
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Image.asset(
                        'Assets/images/turtle.png', // Use your local image asset
                        fit: BoxFit
                            .contain, // Change this to 'contain' to avoid cropping
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0), // Space between containers
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NextPage(), // Replace with your next page
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Pastel Pink
                        borderRadius:
                            BorderRadius.circular(16.0), // Rounded corners
                      ),
                      height: screenHeight * 0.3, // 30% of screen height
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'Learn More >',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.teal[100]!,
        title: Text(
          'Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top image with rounded corners
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  'Assets/images/images (1).jpeg', // Replace with your top image asset
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16.0),
              // Card with rounded corners
              Card(
                color: Colors.white, // Pastel Pink
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(16.0), // Rounded corners for Card
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kurukshetra, November 12',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'To motivate people to boycott single-use plastic and polybags, a sculpture of a turtle has been prepared with the help of 87,297 used polybags, at the Urvashi Ghat of Brahma Sarovar in Kurukshetra, on Tuesday. It was also an attempt to make a new world record of creating a sculpture with the highest number of used polybags.\n\n'
                        'With the help of volunteers, NIC department, Saksham Yuva, and students of various schools, the sculpture was prepared today.\n\n'
                        'Dr. Ritu Sharma, who took the initiative, said “It is an attempt to make people aware of the ill effects of polybags. Ci Yuvan CC Youth Executive Committee of Singapore in 2012 had created a sculpture in the shape of an octopus and they had used 68,000 used polybags. We managed to collect 87,297 used polybags with the help of school children and volunteers. The sculpture will remain at the Urvashi Ghat during the International Gita Jayanti Mahotsav and then for the Surya Grahan mela, and then it will be sent for disposal. It will be sent to a cement factory for disposal. Polybags are also a major cause of cancer and we all must make efforts to stop using single-use plastic and polybags. The polybags were segregated from 200 kg plastic waste as only polybags with handles were to be used, as per the guidelines of Guinness World Records.”\n\n'
                        'The height of the sculpture is nearly 7 ft and breadth 14 ft.\n\n'
                        'In-charge of National Informatics Centre Kurukshetra Vinod Singla, said “The purpose behind selecting a turtle for the sculpture was to show that turtles live for hundreds of years, live underwater and on land, and even they are not safe now due to the presence of polybags in water and on land.”',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              // Bottom image with rounded corners
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  'Assets/images/award.png', // Replace with your bottom image asset
                  width: double.infinity,
                  height: 600,
                  fit: BoxFit
                      .contain, // Use 'contain' to ensure the whole image is visible
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
