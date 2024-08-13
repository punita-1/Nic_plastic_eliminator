import 'package:flutter/material.dart';

/// A button widget that toggles the like state.
///
/// [isliked] determines whether the button is in a liked state or not.
/// [onTap] is the callback function that gets called when the button is tapped.
class LikeButton extends StatelessWidget {
  /// Creates a [LikeButton] widget.
  ///
  /// The [isliked] parameter is required and determines the icon's state.
  /// The [onTap] parameter is a callback that will be invoked when the button is tapped.
  const LikeButton({
    Key? key,
    required this.isliked,
    required this.onTap,
  }) : super(key: key);

  /// Indicates whether the button is in a liked state.
  final bool isliked;

  /// Callback function to be called when the button is tapped.
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isliked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
        // Optionally, you can uncomment the following line to change the color based on the state.
        // color: isliked ? Colors.red : Colors.black,
      ),
    );
  }
}
