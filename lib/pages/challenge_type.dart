// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:plastic_eliminator/pages/Challenges.dart';

// class ChallengeType extends StatefulWidget {
//   const ChallengeType({super.key});

//   @override
//   State<ChallengeType> createState() => _ChallengeTypeState();
// }

// class _ChallengeTypeState extends State<ChallengeType> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF6F1F1),
//       body: Container(
//         margin: EdgeInsets.only(left: 20.0, right: 20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                     top: 50,
//                   ),
//                   child: Icon(
//                     Icons.arrow_back_ios_new_rounded,
//                     color: Colors.black,
//                     size: 30.0,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 'Challenge Yourself! ',
//                 style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500),
//               ),
//               Text(
//                 'Engage in daily tasks to reduce plastic waste and earn rewards for your efforts.',
//                 style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
//               ),
//               Divider(),
//               SizedBox(
//                 height: 10,
//               ),
//               SizedBox(
//                 height: 30.0,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: const Color.fromARGB(255, 255, 165, 165)),
//                 child: Column(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     Challenges(challengetype: 'Daily')));
//                       },
//                       child: Container(
//                         width: 350,
//                         height: 120,
//                         child: Center(
//                           child: Text(
//                             'Daily',
//                             style: TextStyle(
//                                 fontSize: 20.0,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) =>
//                               Challenges(challengetype: 'Weekly')));
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: const Color.fromARGB(255, 255, 165, 165)),
//                   child: Column(
//                     children: [
//                       Container(
//                         width: 350,
//                         height: 120,
//                         child: Center(
//                           child: Text(
//                             'Weekly',
//                             style: TextStyle(
//                                 fontSize: 20.0,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) =>
//                               Challenges(challengetype: 'Monthly')));
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: const Color.fromARGB(255, 255, 165, 165)),
//                   child: Column(
//                     children: [
//                       Container(
//                         width: 350,
//                         height: 120,
//                         child: Center(
//                           child: Text(
//                             'Monthly',
//                             style: TextStyle(
//                                 fontSize: 20.0,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'Challenges.dart';

class ChallengeType extends StatefulWidget {
  const ChallengeType({super.key});

  @override
  State<ChallengeType> createState() => _ChallengeTypeState();
}

class _ChallengeTypeState extends State<ChallengeType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F1F1),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: SingleChildScrollView(
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
                    color: Colors.black,
                    size: 30.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Challenge Yourself!',
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500),
              ),
              const Text(
                'Engage in daily tasks to reduce plastic waste and earn rewards for your efforts.',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 255, 165, 165),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Challenges(challengetype: 'Daily'),
                      ),
                    );
                  },
                  child: Container(
                    width: 350,
                    height: 120,
                    child: const Center(
                      child: Text(
                        'Daily',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Challenges(challengetype: 'Weekly'),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 255, 165, 165),
                  ),
                  child: Container(
                    width: 350,
                    height: 120,
                    child: const Center(
                      child: Text(
                        'Weekly',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Challenges(challengetype: 'Monthly'),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 255, 165, 165),
                  ),
                  child: Container(
                    width: 350,
                    height: 120,
                    child: const Center(
                      child: Text(
                        'Monthly',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
