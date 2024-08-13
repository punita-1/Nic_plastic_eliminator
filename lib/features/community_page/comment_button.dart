import 'package:flutter/material.dart';

/// A custom button widget that displays a comment icon and triggers an action when tapped.
class CommentButton extends StatelessWidget {
  /// The callback function to be executed when the button is tapped.
  final void Function()? onTap;

  /// Creates a [CommentButton] widget.
  ///
  /// The [onTap] parameter is required and should be a function that handles
  /// the tap event. If [onTap] is null, the button will be disabled.
  const CommentButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Detects tap events and triggers the provided callback function.
      onTap: onTap,
      child: Icon(
        Icons.comment, // The icon representing the comment action.
        // color: Colors.teal, // Uncomment to change the icon color.
      ),
    );
  }
}
