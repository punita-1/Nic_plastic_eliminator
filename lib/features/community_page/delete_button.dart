import 'package:flutter/material.dart';

/// A button widget that triggers a delete action.
///
/// [onTap] is a callback function that gets called when the button is tapped.
class DeleteButton extends StatelessWidget {
  /// Creates a [DeleteButton] widget.
  ///
  /// The [onTap] parameter is required and is a callback that will be invoked when the button is tapped.
  const DeleteButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  /// Callback function to be called when the button is tapped.
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.cancel,
        // Optionally, you can uncomment the following line to change the color of the icon.
        // color: Colors.black,
      ),
    );
  }
}
