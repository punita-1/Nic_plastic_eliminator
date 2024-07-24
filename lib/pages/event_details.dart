// // // // import 'package:flutter/material.dart';
// // // // import 'package:plastic_eliminator/pages/event_register.dart';
// // // // // import 'package:plastic_eliminator/pages/register_now.dart';

// // // // class EventDetails extends StatelessWidget {
// // // //   final String month;

// // // //    EventDetails({super.key, required this.month});

// // // //   final List<Map<String, String>> events = [
// // // //     {
// // // //       'title': 'Beach Cleanup',
// // // //       'date': '2024-07-15',
// // // //       'time': '10:00 AM',
// // // //       'location': 'Beachside Park',
// // // //       'description': 'Join us to clean up the beach.',
// // // //       'reward': 'Certificate of Appreciation',
// // // //       'rules': 'Wear gloves and bring trash bags.',
// // // //     },
// // // //     {
// // // //       'title': 'Tree Planting',
// // // //       'date': '2024-07-20',
// // // //       'time': '08:00 AM',
// // // //       'location': 'Central Park',
// // // //       'description': 'Help us plant trees in the park.',
// // // //       'reward': 'Free Snacks',
// // // //       'rules': 'Wear comfortable clothing.',
// // // //     },
// // // //     {
// // // //       'title': 'Recycling Workshop',
// // // //       'date': '2024-07-25',
// // // //       'time': '02:00 PM',
// // // //       'location': 'Community Hall',
// // // //       'description': 'Learn about recycling techniques.',
// // // //       'reward': 'Recycling Guide',
// // // //       'rules': 'Bring recyclable materials.',
// // // //     },
// // // //   ];

// // // //   bool isEventClickable(String eventDate) {
// // // //     DateTime now = DateTime.now();
// // // //     DateTime eventDateTime = DateTime.parse(eventDate);
// // // //     return eventDateTime.isAfter(now);
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('$month Events'),
// // // //       ),
// // // //       body: ListView.builder(
// // // //         itemCount: events.length,
// // // //         itemBuilder: (context, index) {
// // // //           return Card(
// // // //             child: ListTile(
// // // //               title: Text(events[index]['title']!),
// // // //               subtitle: Column(
// // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // //                 children: [
// // // //                   Text('Date: ${events[index]['date']}'),
// // // //                   Text('Time: ${events[index]['time']}'),
// // // //                   Text('Location: ${events[index]['location']}'),
// // // //                   Text('Description: ${events[index]['description']}'),
// // // //                   Text('Reward: ${events[index]['reward']}'),
// // // //                   Text('Rules: ${events[index]['rules']}'),
// // // //                 ],
// // // //               ),
// // // //               trailing: isEventClickable(events[index]['date']!)
// // // //                   ? ElevatedButton(
// // // //                       onPressed: () {
// // // //                         Navigator.push(
// // // //                           context,
// // // //                           MaterialPageRoute(
// // // //                             builder: (context) => RegisterNow(event: events[index]),
// // // //                           ),
// // // //                         );
// // // //                       },
// // // //                       child: Text('Register'),
// // // //                     )
// // // //                   : null,
// // // //             ),
// // // //           );
// // // //         },
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // // import 'package:flutter/material.dart';
// // // import 'package:plastic_eliminator/pages/event_register.dart';
// // // // import 'package:plastic_eliminator/pages/register_now.dart'; // Ensure this import matches your project structure

// // // class EventDetails extends StatelessWidget {
// // //   final String month;

// // //   EventDetails({super.key, required this.month});

// // //   final List<Map<String, String>> events = [
// // //     {
// // //       'title': 'Beach Cleanup',
// // //       'date': '2024-07-15',
// // //       'time': '10:00 AM',
// // //       'location': 'Beachside Park',
// // //       'description': 'Join us to clean up the beach.',
// // //       'reward': 'Certificate of Appreciation',
// // //       'rules': 'Wear gloves and bring trash bags.',
// // //       'image': 'Assets/images/tortoise_onboard.png', // Update this path
// // //     },
// // //     {
// // //       'title': 'Tree Planting',
// // //       'date': '2024-07-20',
// // //       'time': '08:00 AM',
// // //       'location': 'Central Park',
// // //       'description': 'Help us plant trees in the park.',
// // //       'reward': 'Free Snacks',
// // //       'rules': 'Wear comfortable clothing.',
// // //       'image': 'Assets/images/tortoise_onboard.png', // Update this path
// // //     },
// // //     {
// // //       'title': 'Recycling Workshop',
// // //       'date': '2024-07-25',
// // //       'time': '02:00 PM',
// // //       'location': 'Community Hall',
// // //       'description': 'Learn about recycling techniques.',
// // //       'reward': 'Recycling Guide',
// // //       'rules': 'Bring recyclable materials.',
// // //       'image': 'Assets/images/tortoise_onboard.png', // Update this path
// // //     },
// // //   ];

// // //   bool isEventClickable(String eventDate) {
// // //     DateTime now = DateTime.now();
// // //     DateTime eventDateTime = DateTime.parse(eventDate);
// // //     return eventDateTime.isAfter(now);
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('$month Events'),
// // //       ),
// // //       body: ListView.builder(
// // //         itemCount: events.length,
// // //         itemBuilder: (context, index) {
// // //           return Card(
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 Image.asset(events[index]['image']!), // Display event image
// // //                 Padding(
// // //                   padding: const EdgeInsets.all(8.0),
// // //                   child: ListTile(
// // //                     title: Text(events[index]['title']!),
// // //                     subtitle: Column(
// // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // //                       children: [
// // //                         Text('Date: ${events[index]['date']}'),
// // //                         Text('Time: ${events[index]['time']}'),
// // //                         Text('Location: ${events[index]['location']}'),
// // //                         Text('Description: ${events[index]['description']}'),
// // //                         Text('Reward: ${events[index]['reward']}'),
// // //                         Text('Rules: ${events[index]['rules']}'),
// // //                       ],
// // //                     ),
// // //                     trailing: isEventClickable(events[index]['date']!)
// // //                         ? ElevatedButton(
// // //                             onPressed: () {
// // //                               Navigator.push(
// // //                                 context,
// // //                                 MaterialPageRoute(
// // //                                   builder: (context) =>
// // //                                       RegisterNow(event: events[index]),
// // //                                 ),
// // //                               );
// // //                             },
// // //                             child: Text('Register'),
// // //                           )
// // //                         : null,
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:plastic_eliminator/pages/event_register.dart';

// // class EventDetails extends StatelessWidget {
// //   final String month;

// //   EventDetails({super.key, required this.month});

// //   Future<List<Map<String, dynamic>>> fetchEvents() async {
// //     FirebaseFirestore firestore = FirebaseFirestore.instance;
// //     QuerySnapshot querySnapshot = await firestore
// //         .collection(
// //             'events') // Ensure this matches your Firestore collection name
// //         .where('Month', isEqualTo: month)
// //         .get();

// //     List<Map<String, dynamic>> events = querySnapshot.docs.map((doc) {
// //       return {
// //         'title': doc['Name'],
// //         'date': doc['Date'],
// //         'time': doc['Time'],
// //         'location': doc['Location'],
// //         'description': doc['Description'],
// //         'reward': doc['Reward'],
// //         'rules': doc['Rules'],
// //         'image': doc['Image'],
// //       };
// //     }).toList();

// //     return events;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('$month Events'),
// //       ),
// //       body: FutureBuilder<List<Map<String, dynamic>>>(
// //         future: fetchEvents(),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(child: CircularProgressIndicator());
// //           }

// //           if (snapshot.hasError) {
// //             return Center(child: Text('Error: ${snapshot.error}'));
// //           }

// //           if (!snapshot.hasData || snapshot.data!.isEmpty) {
// //             return Center(child: Text('No events found for this month.'));
// //           }

// //           List<Map<String, dynamic>> events = snapshot.data!;

// //           return ListView.builder(
// //             itemCount: events.length,
// //             itemBuilder: (context, index) {
// //               return Card(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Image.network(
// //                         events[index]['image']), // Display event image
// //                     Padding(
// //                       padding: const EdgeInsets.all(8.0),
// //                       child: ListTile(
// //                         title: Text(events[index]['title']),
// //                         subtitle: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text('Date: ${events[index]['date']}'),
// //                             Text('Time: ${events[index]['time']}'),
// //                             Text('Location: ${events[index]['location']}'),
// //                             Text(
// //                                 'Description: ${events[index]['description']}'),
// //                             Text('Reward: ${events[index]['reward']}'),
// //                             Text('Rules: ${events[index]['rules']}'),
// //                           ],
// //                         ),
// //                         trailing: isEventClickable(events[index]['date'])
// //                             ? ElevatedButton(
// //                                 onPressed: () {
// //                                   Navigator.push(
// //                                     context,
// //                                     MaterialPageRoute(
// //                                       builder: (context) => RegisterNow(
// //                                           event: events[index]
// //                                               as Map<String, String>),
// //                                     ),
// //                                   );
// //                                 },
// //                                 child: Text('Register'),
// //                               )
// //                             : null,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   bool isEventClickable(String eventDate) {
// //     DateTime now = DateTime.now();
// //     DateTime eventDateTime = DateTime.parse(eventDate);
// //     return eventDateTime.isAfter(now);
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:plastic_eliminator/pages/event_register.dart';

// class EventDetails extends StatelessWidget {
//   final String month;

//   EventDetails({super.key, required this.month});

//   Future<List<Map<String, dynamic>>> fetchEvents() async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     try {
//       QuerySnapshot querySnapshot = await firestore
//           .collection('events') // Ensure this matches your Firestore collection name
//           .where('Month', isEqualTo: month)
//           .get();

//       if (querySnapshot.docs.isEmpty) {
//         print('No events found.');
//       }

//       List<Map<String, dynamic>> events = querySnapshot.docs.map((doc) {
//         return {
//           'title': doc['Name'] ?? 'No title',
//           'date': doc['Date'] ?? 'No date',
//           'time': doc['Time'] ?? 'No time',
//           'location': doc['Location'] ?? 'No location',
//           'description': doc['Description'] ?? 'No description',
//           'reward': doc['Reward'] ?? 'No reward',
//           'rules': doc['Rules'] ?? 'No rules',
//           'image': doc['Image'] ?? '', // Ensure the image URL is a valid string
//         };
//       }).toList();

//       return events;
//     } catch (e) {
//       print('Error fetching events: $e');
//       return [];
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$month Events'),
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: fetchEvents(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             print('Error: ${snapshot.error}');
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No events found for this month.'));
//           }

//           List<Map<String, dynamic>> events = snapshot.data!;

//           return ListView.builder(
//             itemCount: events.length,
//             itemBuilder: (context, index) {
//               return Card(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     events[index]['image'] != ''
//                       ? Image.network(
//                           events[index]['image'],
//                           fit: BoxFit.cover,
//                         )
//                       : SizedBox.shrink(), // Placeholder if there's no image
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ListTile(
//                         title: Text(events[index]['title']),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Date: ${events[index]['date']}'),
//                             Text('Time: ${events[index]['time']}'),
//                             Text('Location: ${events[index]['location']}'),
//                             Text('Description: ${events[index]['description']}'),
//                             Text('Reward: ${events[index]['reward']}'),
//                             Text('Rules: ${events[index]['rules']}'),
//                           ],
//                         ),
//                         trailing: isEventClickable(events[index]['date'])
//                             ? ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => RegisterNow(
//                                           event: events[index]
//                                               as Map<String, String>),
//                                     ),
//                                   );
//                                 },
//                                 child: Text('Register'),
//                               )
//                             : null,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   bool isEventClickable(String eventDate) {
//     DateTime now = DateTime.now();
//     DateTime eventDateTime = DateTime.parse(eventDate);
//     return eventDateTime.isAfter(now);
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:plastic_eliminator/pages/events.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:plastic_eliminator/services/database.dart';

// class EventDetails extends StatefulWidget {
//  final String month;
//   monthsName({required this.month});
//   @override
//   State<EventDetails> createState() => _EventDetailsState();
// }

// class _EventDetailsState extends State<EventDetails> {
//   Stream? CategoryStream;

//   getontheload() async {
//     CategoryStream = await DatabaseMethods().getMonths(widget.month);
//     setState(() {});
//   }

//   @override
//   void initState() {
//     getontheload();
//     super.initState();
//   }

//   Widget allevents() {
//     return StreamBuilder(
//         stream: CategoryStream,
//         builder: (context, AsyncSnapshot snapshot) {
//           return snapshot.hasData
//               ? GridView.builder(
//                   padding: EdgeInsets.zero,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: 0.6,
//                       mainAxisSpacing: 10.0,
//                       crossAxisSpacing: 10.0),
//                   itemCount: snapshot.data.docs.length,
//                   itemBuilder: (context, index) {
//                     DocumentSnapshot ds = snapshot.data.docs[index];
//                     return Container(
//                       child: Column(
//                         children: [
//                           Image.network(ds["Image"],
//                               height: 150, width: 150, fit: BoxFit.cover),
//                           Text(ds["Name"])
//                         ],
//                       ),
//                     );
//                   })
//               : Container();
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: GestureDetector(
//             onTap: () {
//               Navigator.push(
//                   context, MaterialPageRoute(builder: (context) => Events()));
//             },
//             child: Icon(Icons.arrow_back_ios_new_outlined)),
//       ),
//       body:Container(
//         child: Column(
//           children: [
//             Expanded(child: allevents())
//           ],
//         ),
//       ) ,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:plastic_eliminator/pages/events.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plastic_eliminator/services/database.dart';

class EventDetails extends StatefulWidget {
  final String month;

  EventDetails({required this.month});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  Stream<QuerySnapshot>? categoryStream;

  @override
  void initState() {
    super.initState();
    getontheload();
  }

  Future<void> getontheload() async {
    // Initialize the stream with the data from the database
    categoryStream = await DatabaseMethods().getEvents(widget.month);
    setState(() {});
  }

  Widget allevents() {
    return StreamBuilder<QuerySnapshot>(
      stream: categoryStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No events found for this month.'));
        }

        return GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];
            return Container(
              child: Column(
                children: [
                  Image.network(ds["Image"],
                      height: 150, width: 150, fit: BoxFit.cover),
                  Text(ds["Name"])
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Events()),
            );
          },
          child: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: Text('Events for ${widget.month}'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: allevents()),
          ],
        ),
      ),
    );
  }
}
