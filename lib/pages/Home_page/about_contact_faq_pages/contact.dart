// // import 'package:flutter/material.dart';
// // import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';

// // class FeedbackPage extends StatefulWidget {
// //   @override
// //   _FeedbackPageState createState() => _FeedbackPageState();
// // }

// // class _FeedbackPageState extends State<FeedbackPage> {
// //   double _rating = 3.0;
// //   final _formKey = GlobalKey<FormState>();
// //   final _feedbackController = TextEditingController();
// //   bool _feedbackSubmitted = false;

// //   @override
// //   void dispose() {
// //     _feedbackController.dispose();
// //     super.dispose();
// //   }

// //   void _submitFeedback() async {
// //     if (_formKey.currentState!.validate()) {
// //       final feedback = _feedbackController.text;
// //       try {
// //         await FirebaseFirestore.instance.collection('feedbacks').add({
// //           'rating': _rating,
// //           'feedback': feedback,
// //           'timestamp': FieldValue.serverTimestamp(),
// //         });

// //         setState(() {
// //           _feedbackSubmitted = true;
// //         });

// //         showDialog(
// //           context: context,
// //           builder: (context) {
// //             return AlertDialog(
// //               title: Text('Feedback Submitted'),
// //               content: Column(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   Text('Thank you for your feedback!'),
// //                   SizedBox(height: 10),
// //                   Icon(Icons.sentiment_satisfied,
// //                       color: Colors.green, size: 50),
// //                 ],
// //               ),
// //               actions: [
// //                 TextButton(
// //                   onPressed: () {
// //                     Navigator.of(context).pop();
// //                     _feedbackController.clear();
// //                     setState(() {
// //                       _rating = 3.0; // Reset to default rating
// //                       _feedbackSubmitted = false;
// //                     });
// //                   },
// //                   child: Text(
// //                     'Close',
// //                     style: TextStyle(color: Colors.grey),
// //                   ),
// //                 ),
// //               ],
// //             );
// //           },
// //         );
// //       } catch (e) {
// //         print('Error submitting feedback: $e');
// //         showDialog(
// //           context: context,
// //           builder: (context) {
// //             return AlertDialog(
// //               title: Text('Submission Error'),
// //               content: Text(
// //                 'There was an error submitting your feedback. Please try again.',
// //               ),
// //               actions: [
// //                 TextButton(
// //                   onPressed: () {
// //                     Navigator.of(context).pop();
// //                   },
// //                   child: Text('Close'),
// //                 ),
// //               ],
// //             );
// //           },
// //         );
// //       }
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         centerTitle: true,
// //         title: Text(
// //           'Contact Us & Feedback',
// //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //         ),
// //       ),
// //       body: SingleChildScrollView(
// //         padding: EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.stretch,
// //           children: [
// //             // Feedback Section
// //             Card(
// //               // elevation: 4,
// //               margin: EdgeInsets.symmetric(vertical: 10),
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(15),
// //               ),
// //               child: Padding(
// //                 padding: EdgeInsets.all(16),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.stretch,
// //                   children: [
// //                     Text(
// //                       'Rate Us',
// //                       style:
// //                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                       textAlign: TextAlign.center,
// //                     ),
// //                     SizedBox(height: 15),
// //                     Center(
// //                       child: RatingBar.builder(
// //                         initialRating: _rating,
// //                         minRating: 1,
// //                         direction: Axis.horizontal,
// //                         allowHalfRating: false,
// //                         itemCount: 5,
// //                         itemBuilder: (context, index) {
// //                           switch (index) {
// //                             case 0:
// //                               return Icon(Icons.sentiment_very_dissatisfied,
// //                                   color: Colors.red);
// //                             case 1:
// //                               return Icon(Icons.sentiment_dissatisfied,
// //                                   color: Colors.orange);
// //                             case 2:
// //                               return Icon(Icons.sentiment_neutral,
// //                                   color: Colors.amber);
// //                             case 3:
// //                               return Icon(Icons.sentiment_satisfied,
// //                                   color: Colors.lightGreen);
// //                             case 4:
// //                               return Icon(Icons.sentiment_very_satisfied,
// //                                   color: Colors.green);
// //                             default:
// //                               return Container();
// //                           }
// //                         },
// //                         onRatingUpdate: (rating) {
// //                           setState(() {
// //                             _rating = rating;
// //                           });
// //                         },
// //                         itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             // Feedback Form Section
// //             Card(
// //               // elevation: 4,
// //               margin: EdgeInsets.symmetric(vertical: 10),
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(15),
// //               ),
// //               child: Padding(
// //                 padding: EdgeInsets.all(16),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.stretch,
// //                   children: [
// //                     Text(
// //                       'Feedback Form',
// //                       style:
// //                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                       textAlign: TextAlign.center,
// //                     ),
// //                     SizedBox(height: 10),
// //                     Form(
// //                       key: _formKey,
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text(
// //                             'Your Feedback',
// //                             style: TextStyle(fontSize: 16),
// //                           ),
// //                           SizedBox(height: 8),
// //                           TextFormField(
// //                             controller: _feedbackController,
// //                             maxLines: 4,
// //                             decoration: InputDecoration(
// //                               border: OutlineInputBorder(),
// //                               hintText: 'Enter your feedback here',
// //                             ),
// //                             validator: (value) {
// //                               if (value == null || value.isEmpty) {
// //                                 return 'Please enter your feedback';
// //                               }
// //                               return null;
// //                             },
// //                           ),
// //                           SizedBox(height: 10),
// //                           Center(
// //                             child: ElevatedButton(
// //                               onPressed: _submitFeedback,
// //                               style: ElevatedButton.styleFrom(
// //                                 shape: RoundedRectangleBorder(
// //                                   borderRadius: BorderRadius.circular(
// //                                       8), // Adjust the radius as needed
// //                                 ),
// //                               ),
// //                               child: Text(
// //                                 'Submit',
// //                                 style: TextStyle(color: Colors.grey),
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             // Contact Section
// //             Card(
// //               // elevation: 4,

// //               margin: EdgeInsets.symmetric(vertical: 10),
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(15),
// //               ),
// //               child: Padding(
// //                 padding: EdgeInsets.all(16),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.stretch,
// //                   children: [
// //                     Text(
// //                       'Contact Us',
// //                       style:
// //                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                       textAlign: TextAlign.center,
// //                     ),
// //                     SizedBox(height: 10),
// //                     Text(
// //                       'Email: contact@example.com',
// //                       textAlign: TextAlign.center,
// //                       style: TextStyle(fontSize: 16),
// //                     ),
// //                     SizedBox(height: 5),
// //                     Text(
// //                       'Phone: +1234567890',
// //                       textAlign: TextAlign.center,
// //                       style: TextStyle(fontSize: 16),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:url_launcher/url_launcher.dart';

// class FeedbackPage extends StatefulWidget {
//   @override
//   _FeedbackPageState createState() => _FeedbackPageState();
// }

// class _FeedbackPageState extends State<FeedbackPage> {
//   double _rating = 3.0;
//   final _formKey = GlobalKey<FormState>();
//   final _feedbackController = TextEditingController();
//   bool _feedbackSubmitted = false;

//   @override
//   void dispose() {
//     _feedbackController.dispose();
//     super.dispose();
//   }

//   void _submitFeedback() async {
//     if (_formKey.currentState!.validate()) {
//       final feedback = _feedbackController.text;
//       try {
//         await FirebaseFirestore.instance.collection('feedbacks').add({
//           'rating': _rating,
//           'feedback': feedback,
//           'timestamp': FieldValue.serverTimestamp(),
//         });

//         setState(() {
//           _feedbackSubmitted = true;
//         });

//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: Text('Feedback Submitted'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text('Thank you for your feedback!'),
//                   SizedBox(height: 10),
//                   Icon(Icons.sentiment_satisfied,
//                       color: Colors.green, size: 50),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     _feedbackController.clear();
//                     setState(() {
//                       _rating = 3.0; // Reset to default rating
//                       _feedbackSubmitted = false;
//                     });
//                   },
//                   child: Text(
//                     'Close',
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       } catch (e) {
//         print('Error submitting feedback: $e');
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: Text('Submission Error'),
//               content: Text(
//                 'There was an error submitting your feedback. Please try again.',
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('Close'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     }
//   }

//   Future<void> _launchEmail(String email) async {
//     final Uri emailUri = Uri(
//       scheme: 'mailto',
//       path: email,
//     );
//     if (await canLaunch(emailUri.toString())) {
//       await launch(emailUri.toString());
//     } else {
//       print('Could not launch $emailUri');
//     }
//   }

//   Future<void> _launchPhone(String phone) async {
//     final Uri phoneUri = Uri(
//       scheme: 'tel',
//       path: phone,
//     );
//     if (await canLaunch(phoneUri.toString())) {
//       await launch(phoneUri.toString());
//     } else {
//       print('Could not launch $phoneUri');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'Contact Us & Feedback',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Feedback Section
//             Card(
//               // elevation: 4,
//               margin: EdgeInsets.symmetric(vertical: 10),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Text(
//                       'Rate Us',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 15),
//                     Center(
//                       child: RatingBar.builder(
//                         initialRating: _rating,
//                         minRating: 1,
//                         direction: Axis.horizontal,
//                         allowHalfRating: false,
//                         itemCount: 5,
//                         itemBuilder: (context, index) {
//                           switch (index) {
//                             case 0:
//                               return Icon(Icons.sentiment_very_dissatisfied,
//                                   color: Colors.red);
//                             case 1:
//                               return Icon(Icons.sentiment_dissatisfied,
//                                   color: Colors.orange);
//                             case 2:
//                               return Icon(Icons.sentiment_neutral,
//                                   color: Colors.amber);
//                             case 3:
//                               return Icon(Icons.sentiment_satisfied,
//                                   color: Colors.lightGreen);
//                             case 4:
//                               return Icon(Icons.sentiment_very_satisfied,
//                                   color: Colors.green);
//                             default:
//                               return Container();
//                           }
//                         },
//                         onRatingUpdate: (rating) {
//                           setState(() {
//                             _rating = rating;
//                           });
//                         },
//                         itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // Feedback Form Section
//             Card(
//               // elevation: 4,
//               margin: EdgeInsets.symmetric(vertical: 10),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Text(
//                       'Feedback Form',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 10),
//                     Form(
//                       key: _formKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Your Feedback',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           SizedBox(height: 8),
//                           TextFormField(
//                             controller: _feedbackController,
//                             maxLines: 4,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               hintText: 'Enter your feedback here',
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your feedback';
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(height: 10),
//                           Center(
//                             child: ElevatedButton(
//                               onPressed: _submitFeedback,
//                               style: ElevatedButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(
//                                       8), // Adjust the radius as needed
//                                 ),
//                               ),
//                               child: Text(
//                                 'Submit',
//                                 style: TextStyle(color: Colors.grey),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // Contact Section
//             Card(
//               // elevation: 4,

//               margin: EdgeInsets.symmetric(vertical: 10),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Text(
//                       'Contact Us',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 10),
//                     GestureDetector(
//                       onTap: () => _launchEmail('contact@example.com'),
//                       child: Text(
//                         'Email: contact@example.com',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.blue,
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                     GestureDetector(
//                       onTap: () => _launchPhone('+1234567890'),
//                       child: Text(
//                         'Phone: +1234567890',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.blue,
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  double _rating = 3.0;
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();
  bool _feedbackSubmitted = false;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      final feedback = _feedbackController.text;
      try {
        await FirebaseFirestore.instance.collection('feedbacks').add({
          'rating': _rating,
          'feedback': feedback,
          'timestamp': FieldValue.serverTimestamp(),
        });

        setState(() {
          _feedbackSubmitted = true;
        });

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Feedback Submitted'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Thank you for your feedback!'),
                  SizedBox(height: 10),
                  Icon(Icons.sentiment_satisfied,
                      color: Colors.green, size: 50),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _feedbackController.clear();
                    setState(() {
                      _rating = 3.0; // Reset to default rating
                      _feedbackSubmitted = false;
                    });
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            );
          },
        );
      } catch (e) {
        print('Error submitting feedback: $e');
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Submission Error'),
              content: Text(
                'There was an error submitting your feedback. Please try again.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      print('Could not launch $emailUri');
    }
  }

  Future<void> _launchPhone(String phone) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    } else {
      print('Could not launch $phoneUri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Contact Us & Feedback',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Feedback Section
            Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Rate Us',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: RatingBar.builder(
                        initialRating: _rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          switch (index) {
                            case 0:
                              return Icon(Icons.sentiment_very_dissatisfied,
                                  color: Colors.red);
                            case 1:
                              return Icon(Icons.sentiment_dissatisfied,
                                  color: Colors.orange);
                            case 2:
                              return Icon(Icons.sentiment_neutral,
                                  color: Colors.amber);
                            case 3:
                              return Icon(Icons.sentiment_satisfied,
                                  color: Colors.lightGreen);
                            case 4:
                              return Icon(Icons.sentiment_very_satisfied,
                                  color: Colors.green);
                            default:
                              return Container();
                          }
                        },
                        onRatingUpdate: (rating) {
                          setState(() {
                            _rating = rating;
                          });
                        },
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Feedback Form Section
            Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Feedback Form',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Feedback',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            controller: _feedbackController,
                            maxLines: 4,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your feedback here',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your feedback';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: ElevatedButton(
                              onPressed: _submitFeedback,
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Submit',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Contact Section
            Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Contact Us',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => _launchEmail('contact@example.com'),
                      child: Text(
                        'Email: contact@example.com',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => _launchPhone('+1234567890'),
                      child: Text(
                        'Phone: +1234567890',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
