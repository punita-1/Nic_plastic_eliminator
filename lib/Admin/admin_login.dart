// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:plastic_eliminator/Admin/add_event.dart';
// import 'package:plastic_eliminator/Admin/home_admin.dart';

// class AdminLogin extends StatefulWidget {
//   const AdminLogin({super.key});

//   @override
//   State<AdminLogin> createState() => _AdminLoginState();
// }

// class _AdminLoginState extends State<AdminLogin> {
//   bool _obscureText = true;
//   bool _isLoading = false; // Loading state
//   TextEditingController Admin_nameController = TextEditingController();
//   TextEditingController Admin_passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             padding: EdgeInsets.only(top: 50.0, left: 20.0),
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Color(0xff7469B6),
//                   Color(0xffAD88C6),
//                   Color(0xffE1AFD1),
//                 ],
//               ),
//             ),
//             child: Text(
//               'Admin\nLogin!',
//               style: TextStyle(
//                 fontSize: 30,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           SingleChildScrollView(
//             child: Container(
//               padding: EdgeInsets.only(
//                 top: 25,
//                 left: 30,
//                 right: 30,
//                 bottom: 20,
//               ),
//               margin: EdgeInsets.only(
//                 top: MediaQuery.of(context).size.height / 5.5,
//               ),
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(40),
//                   topRight: Radius.circular(40),
//                 ),
//               ),
//               child: Form(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(child: Icon(Icons.arrow_upward, color: Colors.grey)),
//                     SizedBox(height: 10),
//                     Text(
//                       'Username',
//                       style: TextStyle(
//                         fontSize: 21,
//                         color: Color(0xff7469B6),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     TextFormField(
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a Name';
//                         }
//                         return null;
//                       },
//                       controller: Admin_nameController,
//                       decoration: InputDecoration(
//                         hintText: 'Name',
//                         prefixIcon: Icon(Icons.person),
//                       ),
//                     ),
//                     SizedBox(height: 15.0),
//                     Text(
//                       'Password',
//                       style: TextStyle(
//                         fontSize: 21,
//                         color: Color(0xff7469B6),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     TextFormField(
//                       controller: Admin_passwordController,
//                       decoration: InputDecoration(
//                         hintText: 'Password',
//                         prefixIcon: Icon(Icons.password_outlined),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _obscureText
//                                 ? Icons.visibility_off
//                                 : Icons.visibility,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _obscureText = !_obscureText;
//                             });
//                           },
//                         ),
//                       ),
//                       obscureText: _obscureText,
//                     ),
//                     SizedBox(height: 50.0),
//                     GestureDetector(
//                       onTap: _isLoading ? null : () => LoginAdmin(),
//                       child: Container(
//                         padding: EdgeInsets.symmetric(vertical: 10),
//                         width: MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               Color(0xff7469B6),
//                               Color(0xffAD88C6),
//                               Color(0xffE1AFD1),
//                             ],
//                           ),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Center(
//                           child: _isLoading
//                               ? CircularProgressIndicator(
//                                   valueColor: AlwaysStoppedAnimation<Color>(
//                                     Colors.white,
//                                   ),
//                                 )
//                               : Text(
//                                   'Login',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 25.0,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void LoginAdmin() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       QuerySnapshot snapshot =
//           await FirebaseFirestore.instance.collection("Admin").get();
//       bool isAuthenticated = false;

//       for (var result in snapshot.docs) {
//         var data = result.data() as Map<String, dynamic>?;
//         if (data != null &&
//             data['username'] == Admin_nameController.text.trim() &&
//             data['password'] == Admin_passwordController.text.trim()) {
//           isAuthenticated = true;
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => HomeAdmin()),
//           );
//           break;
//         }
//       }

//       if (!isAuthenticated) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(
//             'Your username or password is not correct',
//             style: TextStyle(fontSize: 20.0),
//           ),
//         ));
//       }
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(
//           'Error: $error',
//           style: TextStyle(fontSize: 20.0),
//         ),
//       ));
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plastic_eliminator/Admin/add_event.dart';
import 'package:plastic_eliminator/Admin/home_admin.dart';
import 'package:plastic_eliminator/pages/initial_pages/login.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  bool _obscureText = true;
  bool _isLoading = false; // Loading state
  TextEditingController Admin_nameController = TextEditingController();
  TextEditingController Admin_passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50.0, left: 20.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff7469B6),
                  Color(0xffAD88C6),
                  Color(0xffE1AFD1),
                ],
              ),
            ),
            child: Text(
              'Admin\nLogin!',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: 25,
                left: 30,
                right: 30,
                bottom: 20,
              ),
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 5.5,
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Icon(Icons.arrow_upward, color: Colors.grey)),
                    SizedBox(height: 10),
                    Text(
                      'Username',
                      style: TextStyle(
                        fontSize: 21,
                        color: Color(0xff7469B6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Name';
                        }
                        return null;
                      },
                      controller: Admin_nameController,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 21,
                        color: Color(0xff7469B6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      controller: Admin_passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.password_outlined),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscureText,
                    ),
                    SizedBox(height: 50.0),
                    GestureDetector(
                      onTap: _isLoading ? null : () => LoginAdmin(),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff7469B6),
                              Color(0xffAD88C6),
                              Color(0xffE1AFD1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                )
                              : Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text(
                          'Are you a user?',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void LoginAdmin() async {
    setState(() {
      _isLoading = true;
    });

    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection("Admin").get();
      bool isAuthenticated = false;

      for (var result in snapshot.docs) {
        var data = result.data() as Map<String, dynamic>?;
        if (data != null &&
            data['username'] == Admin_nameController.text.trim() &&
            data['password'] == Admin_passwordController.text.trim()) {
          isAuthenticated = true;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeAdmin()),
          );
          break;
        }
      }

      if (!isAuthenticated) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Your username or password is not correct',
            style: TextStyle(fontSize: 20.0),
          ),
        ));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Error: $error',
          style: TextStyle(fontSize: 20.0),
        ),
      ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
