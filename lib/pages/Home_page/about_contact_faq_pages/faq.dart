import 'package:flutter/material.dart';

class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'FAQ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          // color: Colors.green[50],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ExpansionTile(
              title: Text('What is plastic pollution?'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Plastic pollution involves the accumulation of plastic products in the environment that adversely affects wildlife, wildlife habitat, or humans.',
                  ),
                )
              ],
            ),
            ExpansionTile(
              title: Text('How can we reduce plastic waste?'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'We can reduce plastic waste by recycling, using reusable products, and avoiding single-use plastics.',
                  ),
                )
              ],
            ),
            ExpansionTile(
              title: Text('What are the benefits of recycling?'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Recycling helps to conserve resources, reduce pollution, and decrease energy consumption.',
                  ),
                )
              ],
            ),
            ExpansionTile(
              title: Text('What are sustainable alternatives to plastic?'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sustainable alternatives to plastic include materials like glass, metal, and biodegradable plastics.',
                  ),
                )
              ],
            ),
            ExpansionTile(
              title: Text('How can I get involved in plastic eradication?'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'You can get involved by participating in local clean-up events, advocating for policy changes, and educating others about the impacts of plastic pollution.',
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
