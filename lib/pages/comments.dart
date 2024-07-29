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
        color: Colors.grey,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        children: [
          Text(text),
          Row(
            children: [Text(user), Text(" . "), Text(time)],
          )
        ],
      ),
    );
  }
}
