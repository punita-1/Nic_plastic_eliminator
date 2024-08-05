// import 'package:flutter/material.dart';
// import 'package:plastic_eliminator/pages/initial_pages/bottomnav.dart';
// import 'package:plastic_eliminator/pages/initial_pages/signup.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:plastic_eliminator/services/auth_services.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   String? email, password;
//   bool _isLoading = false; // Added at the top of the _LoginState class
//   TextEditingController gmailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();
//   bool _obscureText = true;

//   // Future<void> userLogin() async {
//   //   if (_formKey.currentState!.validate()) {
//   //     setState(() {
//   //       email = gmailController.text;
//   //       password = passwordController.text;
//   //     });

//   //     try {
//   //       await AuthService().signInWithEmailAndPassword(email!, password!);
//   //       Navigator.pushReplacement(
//   //           context, MaterialPageRoute(builder: (context) => Bottomnav()));
//   //     } catch (e) {
//   //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //           content: Text(
//   //         'An error occurred: ${e.toString()}',
//   //         style: TextStyle(fontSize: 20.0),
//   //       )));
//   //     }
//   //   }
//   // }
//   Future<void> userLogin() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         email = gmailController.text;
//         password = passwordController.text;
//       });

//       try {
//         UserCredential userCredential = await FirebaseAuth.instance
//             .signInWithEmailAndPassword(email: email!, password: password!);

//         if (userCredential.user != null) {
//           // Save login state and user email in SharedPreferences
//           final prefs = await SharedPreferences.getInstance();
//           await prefs.setBool('isLoggedIn', true);
//           await prefs.setString('userEmail', email!);

//           // Navigate to the main screen
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => Bottomnav()),
//           );
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text(
//           'An error occurred: ${e.toString()}',
//           style: TextStyle(fontSize: 20.0),
//         )));
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             padding: EdgeInsets.only(top: 50.0, left: 20.0),
//             height: MediaQuery.of(context).size.height / 2,
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [
//               Colors.black,
//               Colors.grey,
//               Colors.grey[300]!,
//             ])),
//             child: Text(
//               'Hello,\nSign in!',
//               style: TextStyle(
//                   fontSize: 30,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//           SingleChildScrollView(
//             child: Container(
//               padding:
//                   EdgeInsets.only(top: 25, left: 30, right: 30, bottom: 20),
//               margin: EdgeInsets.only(
//                   top: MediaQuery.of(context).size.height / 5.5),
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(40),
//                       topRight: Radius.circular(40))),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                         child: Icon(
//                       Icons.arrow_upward,
//                       color: Colors.grey,
//                     )),
//                     Text(
//                       'Gmail',
//                       style: TextStyle(
//                           fontSize: 21,
//                           color: Colors.grey[600],
//                           fontWeight: FontWeight.w500),
//                     ),
//                     TextFormField(
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a valid gmail';
//                         }
//                         return null;
//                       },
//                       controller: gmailController,
//                       decoration: InputDecoration(
//                           hintText: 'Gmail',
//                           prefixIcon: Icon(
//                             Icons.mail_outline,
//                             color: Colors.grey[600],
//                           )),
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Text(
//                       'Password',
//                       style: TextStyle(
//                           fontSize: 21,
//                           color: Colors.grey[600],
//                           fontWeight: FontWeight.w500),
//                     ),
//                     TextFormField(
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a valid password';
//                           }
//                           return null;
//                         },
//                         controller: passwordController,
//                         decoration: InputDecoration(
//                           hintText: 'Password',
//                           prefixIcon: Icon(
//                             Icons.password_outlined,
//                             color: Colors.grey[600],
//                           ),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _obscureText
//                                   ? Icons.visibility_off
//                                   : Icons.visibility,
//                               color: Colors.grey[600],
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _obscureText = !_obscureText;
//                               });
//                             },
//                           ),
//                         ),
//                         obscureText: _obscureText),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Text(
//                           'Forgot password?',
//                           style: TextStyle(
//                               fontSize: 15,
//                               color: Colors.grey[600],
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 50.0,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         userLogin();
//                       },
//                       child: Container(
//                         padding: EdgeInsets.symmetric(
//                           vertical: 10,
//                         ),
//                         width: MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(
//                             gradient: LinearGradient(colors: [
//                               Colors.black,
//                               Colors.grey,
//                               Colors.grey[300]!,
//                             ]),
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Center(
//                           child: Text(
//                             'SIGN IN',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 26.0,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Don't have an account?",
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => Signup()));
//                           },
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(
//                                 " Sign up",
//                                 style: TextStyle(
//                                     color: Colors.grey[600],
//                                     fontSize: 16.0,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:plastic_eliminator/pages/initial_pages/bottomnav.dart';
import 'package:plastic_eliminator/pages/initial_pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email, password;
  bool _isLoading = false; // Add this variable

  TextEditingController gmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  Future<void> userLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        email = gmailController.text;
        password = passwordController.text;
        _isLoading = true; // Set loading to true when login starts
      });

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email!, password: password!);

        if (userCredential.user != null) {
          // Save login state and user email in SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('userEmail', email!);

          // Navigate to the main screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Bottomnav()),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          'An error occurred: ${e.toString()}',
          style: TextStyle(fontSize: 20.0),
        )));
      } finally {
        setState(() {
          _isLoading = false; // Set loading to false when login completes
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50.0, left: 20.0),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.black,
              Colors.grey,
              Colors.grey[300]!,
            ])),
            child: Text(
              'Hello,\nSign in!',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding:
                  EdgeInsets.only(top: 25, left: 30, right: 30, bottom: 20),
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 5.5),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Icon(
                      Icons.arrow_upward,
                      color: Colors.grey,
                    )),
                    Text(
                      'Gmail',
                      style: TextStyle(
                          fontSize: 21,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid gmail';
                        }
                        return null;
                      },
                      controller: gmailController,
                      decoration: InputDecoration(
                          hintText: 'Gmail',
                          prefixIcon: Icon(
                            Icons.mail_outline,
                            color: Colors.grey[600],
                          )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Password',
                      style: TextStyle(
                          fontSize: 21,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid password';
                          }
                          return null;
                        },
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(
                            Icons.password_outlined,
                            color: Colors.grey[600],
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey[600],
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscureText),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot password?',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        userLogin();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.black,
                              Colors.grey,
                              Colors.grey[300]!,
                            ]),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Text(
                                  'SIGN IN',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                " Sign up",
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
