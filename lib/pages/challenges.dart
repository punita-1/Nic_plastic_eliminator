// import 'package:flutter/material.dart';

// class Challenges extends StatefulWidget {
//   String challengetype;
//   Challenges({required this.challengetype});

//   @override
//   State<Challenges> createState() => _ChallengesState();
// }

// class _ChallengesState extends State<Challenges> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF6F1F1),
//       body: Container(
//         margin: EdgeInsets.only(left: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   top: 50,
//                 ),
//                 child: Icon(
//                   Icons.arrow_back_ios_new_rounded,
//                   color: Colors.pink,
//                   size: 30.0,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 30.0,
//             ),
//             Text(
//               widget.challengetype,
//               style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500),
//             ),
//             Text(
//               'Challenges',
//               style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class Challenges extends StatefulWidget {
  final String challengetype;
  const Challenges({required this.challengetype});

  @override
  State<Challenges> createState() => _ChallengesState();
}

class _ChallengesState extends State<Challenges> {
  final Map<String, List<String>> challenges = {
    'Daily': [
      'Avoid using plastic straws for a day.',
      'Use a reusable bag for shopping.',
      'Pick up 5 pieces of plastic litter.',
    ],
    'Weekly': [
      'Avoid buying bottled water for a week.',
      'Take a reusable container to a restaurant.',
      'Recycle all plastic waste for a week.',
    ],
    'Monthly': [
      'Organize a plastic cleanup event.',
      'Reduce plastic packaging in your home.',
      'Educate others about plastic pollution.',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F1F1),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.only(
                  top: 50,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.pink,
                  size: 30.0,
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Text(
              widget.challengetype,
              style:
                  const TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500),
            ),
            const Text(
              'Challenges',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: challenges[widget.challengetype]?.length ?? 0,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading:
                          Icon(Icons.check_circle_outline, color: Colors.green),
                      title: Text(challenges[widget.challengetype]![index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
