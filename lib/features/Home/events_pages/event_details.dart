// import 'package:flutter/material.dart';
// import 'package:plastic_eliminator/features/Home/events_pages/event_register.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:plastic_eliminator/data/datasources/database.dart';

// class EventDetails extends StatefulWidget {
//   final String month;

//   EventDetails({required this.month});

//   @override
//   State<EventDetails> createState() => _EventDetailsState();
// }

// class _EventDetailsState extends State<EventDetails> {
//   Stream<QuerySnapshot>? categoryStream;

//   @override
//   void initState() {
//     super.initState();
//     getontheload();
//   }

//   Future<void> getontheload() async {
//     categoryStream = await DatabaseMethods().getEvents(widget.month);
//     setState(() {});
//   }

//   Widget allevents() {
//     return StreamBuilder<QuerySnapshot>(
//       stream: categoryStream,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         }
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return Center(child: Text('No events found for this month.'));
//         }

//         return ListView.builder(
//           padding: EdgeInsets.zero,
//           itemCount: snapshot.data!.docs.length,
//           itemBuilder: (context, index) {
//             DocumentSnapshot ds = snapshot.data!.docs[index];

//             // Define text style
//             final textStyle = TextStyle(
//                 fontSize: 14.0,
//                 fontWeight:
//                     FontWeight.w500); // Customize the font size as needed
//             final HeadingTextStyle =
//                 TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

//             return Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   color: Colors.grey[350],
//                   border: Border.all(
//                     color: Colors.black, // Border color
//                     width: 2.0,
//                   )),
//               margin: EdgeInsets.all(10.0),
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Image.network(
//                       ds["Image"],
//                       height: 150,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                     SizedBox(height: 10.0),
//                     Text(
//                       ds["Name"],
//                       style: HeadingTextStyle,
//                     ),
//                     SizedBox(height: 4.0),
//                     Text(
//                       'Date: ${ds["Date"]}',
//                       style: textStyle,
//                     ),
//                     SizedBox(height: 4.0),
//                     Text(
//                       'Time: ${ds["Time"]}',
//                       style: textStyle,
//                     ),
//                     SizedBox(height: 4.0),
//                     Text(
//                       'Location: ${ds["Location"]}',
//                       style: textStyle,
//                     ),
//                     SizedBox(height: 4.0),
//                     Text(
//                       'Description: ${ds["Description"]}',
//                       style: textStyle,
//                     ),
//                     SizedBox(height: 4.0),
//                     Text(
//                       'Reward: ${ds["Reward"]}',
//                       style: textStyle,
//                     ),
//                     SizedBox(height: 4.0),
//                     Text(
//                       'Rules: ${ds["Rules"]}',
//                       style: textStyle,
//                     ),
//                     SizedBox(height: 10.0),
//                     Center(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => RegistrationPage(
//                                 eventName: ds["Name"],
//                                 eventId: ds.id, // Pass eventId here
//                               ),
//                             ),
//                           );
//                         },
//                         child: Text(
//                           'Register',
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(
//                                 4.0), // Adjust this value for less curvature
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(
//               context,
//             );
//           },
//           child: Icon(Icons.arrow_back_ios_new_outlined),
//         ),
//         centerTitle: true,
//         title: Text(
//           'Events for ${widget.month}',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             Expanded(child: allevents()),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plastic_eliminator/data/datasources/database.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

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
    categoryStream = await DatabaseMethods().getEvents(widget.month);
    setState(() {});
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];

            // Define text style
            final textStyle = TextStyle(
                fontSize: 14.0,
                fontWeight:
                    FontWeight.w500); // Customize the font size as needed
            final HeadingTextStyle =
                TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[350],
                border: Border.all(
                  color: Colors.black, // Border color
                  width: 2.0,
                ),
              ),
              margin: EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      ds["Image"],
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      ds["Name"],
                      style: HeadingTextStyle,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Date: ${ds["Date"]}',
                      style: textStyle,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Time: ${ds["Time"]}',
                      style: textStyle,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Location: ${ds["Location"]}',
                      style: textStyle,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Description: ${ds["Description"]}',
                      style: textStyle,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Reward: ${ds["Reward"]}',
                      style: textStyle,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Rules: ${ds["Rules"]}',
                      style: textStyle,
                    ),
                    SizedBox(height: 10.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          _launchURL(
                              ds["RegistrationLink"]); // Open registration link
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.grey),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        centerTitle: true,
        title: Text(
          'Events for ${widget.month}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
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
