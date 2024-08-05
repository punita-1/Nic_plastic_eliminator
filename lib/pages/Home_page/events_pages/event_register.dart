// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';

// // class RegistrationPage extends StatefulWidget {
// //   final String eventName;
// //   final String eventId; // Add eventId parameter

// //   RegistrationPage({required this.eventName, required this.eventId}); // Add eventId to constructor

// //   @override
// //   _RegistrationPageState createState() => _RegistrationPageState();
// // }

// // class _RegistrationPageState extends State<RegistrationPage> {
// //   final _formKey = GlobalKey<FormState>();
// //   final _nameController = TextEditingController();
// //   final _emailController = TextEditingController();
// //   final _phoneController = TextEditingController();
// //   String? userId;
// //   bool hasRegistered = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initializeUserId();
// //     _checkRegistrationStatus();
// //   }

// //   void _initializeUserId() {
// //     final user = FirebaseAuth.instance.currentUser;
// //     if (user != null) {
// //       setState(() {
// //         userId = user.uid;
// //       });
// //     }
// //   }

// //   Future<void> _checkRegistrationStatus() async {
// //     if (userId != null) {
// //       final registrationSnapshot = await FirebaseFirestore.instance
// //           .collection('registrations')
// //           .where('eventId', isEqualTo: widget.eventId) // Use eventId to check registration
// //           .where('userId', isEqualTo: userId)
// //           .get();

// //       setState(() {
// //         hasRegistered = registrationSnapshot.docs.isNotEmpty;
// //       });
// //     }
// //   }

// //   void _register() async {
// //     if (_formKey.currentState!.validate() && !hasRegistered) {
// //       try {
// //         await FirebaseFirestore.instance.collection('registrations').add({
// //           'eventName': widget.eventName,
// //           'eventId': widget.eventId, // Include eventId in registration data
// //           'name': _nameController.text,
// //           'email': _emailController.text,
// //           'phone': _phoneController.text,
// //           'userId': userId,
// //           'timestamp': FieldValue.serverTimestamp(),
// //         });

// //         // Show success message
// //         showDialog(
// //           context: context,
// //           builder: (context) {
// //             return AlertDialog(
// //               title: Text('Registration Successful'),
// //               content: Text(
// //                   'You have successfully registered for ${widget.eventName}.'),
// //               actions: [
// //                 TextButton(
// //                   onPressed: () {
// //                     Navigator.of(context).pop();
// //                     Navigator.of(context)
// //                         .pop(); // Go back to the previous screen
// //                   },
// //                   child: Text(
// //                     'OK',
// //                     style: TextStyle(color: Colors.grey),
// //                   ),
// //                 ),
// //               ],
// //             );
// //           },
// //         );
// //       } catch (e) {
// //         print('Error registering: $e');
// //         showDialog(
// //           context: context,
// //           builder: (context) {
// //             return AlertDialog(
// //               title: Text('Registration Error'),
// //               content:
// //                   Text('There was an error registering. Please try again.'),
// //               actions: [
// //                 TextButton(
// //                   onPressed: () {
// //                     Navigator.of(context).pop();
// //                   },
// //                   child: Text('OK'),
// //                 ),
// //               ],
// //             );
// //           },
// //         );
// //       }
// //     } else if (hasRegistered) {
// //       showDialog(
// //         context: context,
// //         builder: (context) {
// //           return AlertDialog(
// //             title: Text('Already Registered'),
// //             content: Text('You have already registered for this event.'),
// //             actions: [
// //               TextButton(
// //                 onPressed: () {
// //                   Navigator.of(context).pop();
// //                 },
// //                 child: Text('OK'),
// //               ),
// //             ],
// //           );
// //         },
// //       );
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     _nameController.dispose();
// //     _emailController.dispose();
// //     _phoneController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         centerTitle: true,
// //         title: Text(
// //           'Register for ${widget.eventName}',
// //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //         ),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 'Register for ${widget.eventName}',
// //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //               ),
// //               SizedBox(height: 20),
// //               TextFormField(
// //                 controller: _nameController,
// //                 decoration: InputDecoration(labelText: 'Name'),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter your name';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               SizedBox(height: 10),
// //               TextFormField(
// //                 controller: _emailController,
// //                 decoration: InputDecoration(labelText: 'Email'),
// //                 keyboardType: TextInputType.emailAddress,
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter your email';
// //                   } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
// //                     return 'Please enter a valid email address';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               SizedBox(height: 10),
// //               TextFormField(
// //                 controller: _phoneController,
// //                 decoration: InputDecoration(labelText: 'Phone Number'),
// //                 keyboardType: TextInputType.phone,
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter your phone number';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               SizedBox(height: 20),
// //               ElevatedButton(
// //                 onPressed: hasRegistered ? null : _register,
// //                 style: ElevatedButton.styleFrom(
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(3),
// //                   ),
// //                 ),
// //                 child: Text(
// //                   hasRegistered ? 'Already Registered' : 'Register',
// //                   style: TextStyle(color: Colors.grey),
// //                 ),
// //               )
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class RegistrationPage extends StatefulWidget {
//   final String eventName;
//   final String eventId;

//   RegistrationPage({required this.eventName, required this.eventId});

//   @override
//   _RegistrationPageState createState() => _RegistrationPageState();
// }

// class _RegistrationPageState extends State<RegistrationPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   String? userId;
//   bool hasRegistered = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeUserId();
//     _checkRegistrationStatus();
//   }

//   void _initializeUserId() {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       setState(() {
//         userId = user.uid;
//       });
//       _fetchUserDetails(user.uid);
//     }
//   }

//   Future<void> _fetchUserDetails(String userId) async {
//     final userDoc =
//         await FirebaseFirestore.instance.collection('users').doc(userId).get();
//     if (userDoc.exists) {
//       final userData = userDoc.data();
//       if (userData != null) {
//         setState(() {
//           _nameController.text = userData['name'] ?? '';
//           _emailController.text = userData['email'] ?? '';
//           _phoneController.text = userData['phone'] ?? '';
//         });
//       }
//     }
//   }

//   Future<void> _checkRegistrationStatus() async {
//     if (userId != null) {
//       final registrationSnapshot = await FirebaseFirestore.instance
//           .collection('registrations')
//           .where('eventId', isEqualTo: widget.eventId)
//           .where('userId', isEqualTo: userId)
//           .get();

//       setState(() {
//         hasRegistered = registrationSnapshot.docs.isNotEmpty;
//       });
//     }
//   }

//   void _register() async {
//     if (_formKey.currentState!.validate() && !hasRegistered) {
//       try {
//         await FirebaseFirestore.instance.collection('registrations').add({
//           'eventName': widget.eventName,
//           'eventId': widget.eventId,
//           'name': _nameController.text,
//           'email': _emailController.text,
//           'phone': _phoneController.text,
//           'userId': userId,
//           'timestamp': FieldValue.serverTimestamp(),
//         });

//         // Show success message
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: Text('Registration Successful'),
//               content: Text(
//                   'You have successfully registered for ${widget.eventName}.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     Navigator.of(context)
//                         .pop(); // Go back to the previous screen
//                   },
//                   child: Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       } catch (e) {
//         print('Error registering: $e');
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: Text('Registration Error'),
//               content:
//                   Text('There was an error registering. Please try again.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } else if (hasRegistered) {
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Already Registered'),
//             content: Text('You have already registered for this event.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'Register for ${widget.eventName}',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Register for ${widget.eventName}',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(labelText: 'Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: 'Email'),
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
//                     return 'Please enter a valid email address';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               TextFormField(
//                 controller: _phoneController,
//                 decoration: InputDecoration(labelText: 'Phone Number'),
//                 keyboardType: TextInputType.phone,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your phone number';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: hasRegistered ? null : _register,
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(3),
//                   ),
//                 ),
//                 child: Text(
//                   hasRegistered ? 'Already Registered' : 'Register',
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationPage extends StatefulWidget {
  final String eventName;
  final String eventId;

  RegistrationPage({required this.eventName, required this.eventId});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String? userId;
  bool hasRegistered = false;

  @override
  void initState() {
    super.initState();
    _initializeUserId();
    _checkRegistrationStatus();
  }

  void _initializeUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
      _fetchUserDetails(user.uid);
    }
  }

  Future<void> _fetchUserDetails(String userId) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userDoc.exists) {
      final userData = userDoc.data();
      print('Fetched user data: $userData'); // Debugging line
      if (userData != null) {
        setState(() {
          _nameController.text = userData['name'] ?? '';
          _emailController.text = userData['email'] ?? '';
          _phoneController.text = userData['phoneNumber'] ?? '';
        });
      }
    }
  }

  Future<void> _checkRegistrationStatus() async {
    if (userId != null) {
      final registrationSnapshot = await FirebaseFirestore.instance
          .collection('registrations')
          .where('eventId', isEqualTo: widget.eventId)
          .where('userId', isEqualTo: userId)
          .get();

      setState(() {
        hasRegistered = registrationSnapshot.docs.isNotEmpty;
      });
    }
  }

  void _register() async {
    if (_formKey.currentState!.validate() && !hasRegistered) {
      try {
        await FirebaseFirestore.instance.collection('registrations').add({
          'eventName': widget.eventName,
          'eventId': widget.eventId,
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'userId': userId,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Show success message
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Registration Successful'),
              content: Text(
                  'You have successfully registered for ${widget.eventName}.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .pop(); // Go back to the previous screen
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } catch (e) {
        print('Error registering: $e');
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Registration Error'),
              content:
                  Text('There was an error registering. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else if (hasRegistered) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Already Registered'),
            content: Text('You have already registered for this event.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Register for ${widget.eventName}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Register for ${widget.eventName}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: hasRegistered ? null : _register,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                child: Text(
                  hasRegistered ? 'Already Registered' : 'Register',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
