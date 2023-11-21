import 'package:flutter/material.dart';

class SwitchCameraButton extends StatelessWidget {
  final Function() onPressed;

  const SwitchCameraButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.switch_camera,
        color: Color(0xFFF59B15),
        size: 30,
      ),
      onPressed: onPressed,
    );
  }
}
