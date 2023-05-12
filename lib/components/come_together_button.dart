import 'package:flutter/material.dart';

class ComeTogetherButton extends StatelessWidget {
  const ComeTogetherButton(
      {this.text, this.color, required this.onPressed, super.key});
  final String? text;
  final Color? color;
  // ignore: prefer_typing_uninitialized_variables
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color ?? Colors.green[300],
      onPressed: onPressed,
      child: Text('$text', style: const TextStyle(color: Colors.black)),
    );
  }
}
