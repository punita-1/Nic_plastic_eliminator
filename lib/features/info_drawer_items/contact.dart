// // ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unused_field, use_key_in_widget_constructors

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
//               title: const Text('Feedback Submitted'),
//               content: const Column(
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
//                   child: const Text(
//                     'Close',
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       } catch (e) {
//         // print('Error submitting feedback: $e');
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: const Text('Submission Error'),
//               content: const Text(
//                 'There was an error submitting your feedback. Please try again.',
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('Close'),
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
//       // print('Could not launch $emailUri');
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
//       // print('Could not launch $phoneUri');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           'Contact Us & Feedback',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Feedback Section
//             Card(
//               margin: const EdgeInsets.symmetric(vertical: 10),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     const Text(
//                       'Rate Us',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 15),
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
//                               return const Icon(Icons.sentiment_very_dissatisfied,
//                                   color: Colors.red);
//                             case 1:
//                               return const Icon(Icons.sentiment_dissatisfied,
//                                   color: Colors.orange);
//                             case 2:
//                               return const Icon(Icons.sentiment_neutral,
//                                   color: Colors.amber);
//                             case 3:
//                               return const Icon(Icons.sentiment_satisfied,
//                                   color: Colors.lightGreen);
//                             case 4:
//                               return const Icon(Icons.sentiment_very_satisfied,
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
//                         itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // Feedback Form Section
//             Card(
//               margin: const EdgeInsets.symmetric(vertical: 10),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     const Text(
//                       'Feedback Form',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 10),
//                     Form(
//                       key: _formKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Your Feedback',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           const SizedBox(height: 8),
//                           TextFormField(
//                             controller: _feedbackController,
//                             maxLines: 4,
//                             decoration: const InputDecoration(
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
//                           const SizedBox(height: 10),
//                           Center(
//                             child: ElevatedButton(
//                               onPressed: _submitFeedback,
//                               style: ElevatedButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                               ),
//                               child: const Text(
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
//               margin: const EdgeInsets.symmetric(vertical: 10),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     const Text(
//                       'Contact Us',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 10),
//                     GestureDetector(
//                       onTap: () => _launchEmail('contact@example.com'),
//                       child: const Text(
//                         'Email: contact@example.com',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.blue,
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     GestureDetector(
//                       onTap: () => _launchPhone('+1234567890'),
//                       child: const Text(
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
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _queryController = TextEditingController();
  bool _feedbackSubmitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _queryController.dispose();
    super.dispose();
  }

  void _submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text;
      final query = _queryController.text;
      try {
        await FirebaseFirestore.instance.collection('feedbacks').add({
          'name': name,
          'email': email,
          'rating': _rating,
          'query': query,
          'timestamp': FieldValue.serverTimestamp(),
        });

        setState(() {
          _feedbackSubmitted = true;
        });

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Query Submitted'),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Thank you for your query!'),
                  SizedBox(height: 10),
                  Icon(Icons.sentiment_satisfied,
                      color: Colors.green, size: 50),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _nameController.clear();
                    _emailController.clear();
                    _queryController.clear();
                    setState(() {
                      _rating = 3.0; // Reset to default rating
                      _feedbackSubmitted = false;
                    });
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            );
          },
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Submission Error'),
              content: const Text(
                'There was an error submitting your query. Please try again.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
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
      // print('Could not launch $emailUri');
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
      // print('Could not launch $phoneUri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Contact Us & Feedback',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Rating Section
            Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Rate Us',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
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
                              return const Icon(
                                  Icons.sentiment_very_dissatisfied,
                                  color: Colors.red);
                            case 1:
                              return const Icon(Icons.sentiment_dissatisfied,
                                  color: Colors.orange);
                            case 2:
                              return const Icon(Icons.sentiment_neutral,
                                  color: Colors.amber);
                            case 3:
                              return const Icon(Icons.sentiment_satisfied,
                                  color: Colors.lightGreen);
                            case 4:
                              return const Icon(Icons.sentiment_very_satisfied,
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
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Query Form Section
            Card(
              margin: const EdgeInsets.symmetric(vertical: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Ask Your Query',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Name',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Email',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your email',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Your Query',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _queryController,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your query here',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your query';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: ElevatedButton(
                              onPressed: _submitFeedback,
                              style: ElevatedButton.styleFrom(
                                // shape: RoundedRectangleBorder(
                                  // borderRadius: BorderRadius.circular(8),
                                // ),
                              ),
                              child: const Text(
                                'Submit',
                                // style: TextStyle(color: Colors.grey),
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
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Contact Us',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => _launchEmail('contact@example.com'),
                      child: const Text(
                        'Email: contact@example.com',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => _launchPhone('+1234567890'),
                      child: const Text(
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
