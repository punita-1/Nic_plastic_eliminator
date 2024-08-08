import 'package:flutter/material.dart';

class Comments extends StatelessWidget {
  final String text;
  final String user;
  final String time;

  const Comments(
      {super.key, required this.text, required this.time, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(4.0),
      ),
      margin: EdgeInsets.only(top: 15),
      // padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            // style: 
            // TextStyle(color: Theme.of(context).colorScheme.tertiary
            // ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          // Row(
          //   children: [
          //     Text(
          //       user,
          //       style: TextStyle(color: Colors.black),
          //     ),
          //     Text(
          //       " . ",
          //       style: TextStyle(color: Colors.black),
          //     ),
          //     Text(
          //       time,
          //       style: TextStyle(color: Colors.black),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
