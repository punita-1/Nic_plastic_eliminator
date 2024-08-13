import 'package:flutter/material.dart';

/// A custom widget that displays a comment with user information and timestamp.
class Comments extends StatelessWidget {
  /// The text of the comment.
  final String text;

  /// The username of the person who made the comment.
  final String user;

  /// The time when the comment was made.
  final String time;

  /// Creates a [Comments] widget.
  ///
  /// The [text], [user], and [time] parameters are required to properly display
  /// the comment, the username, and the timestamp.
  const Comments({
    super.key,
    required this.text,
    required this.time,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // Optionally set a background color using the app's color scheme.
        // color: Theme.of(context).colorScheme.secondary,
        borderRadius:
            BorderRadius.circular(4.0), // Rounded corners for the comment box.
      ),
      margin:
          EdgeInsets.only(top: 15), // Spacing at the top of the comment box.
      // padding: EdgeInsets.all(15), // Optionally add padding inside the comment box.
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align content to the start (left).
        children: [
          Text(
            text, // Display the comment text.
          ),
        ],
      ),
    );
  }
}
