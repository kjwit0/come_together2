import 'package:flutter/material.dart';

class MemberBox extends StatefulWidget {
  const MemberBox({super.key});

  @override
  State<MemberBox> createState() => _MemberBoxState();
}

class _MemberBoxState extends State<MemberBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      height: 50,
      color: Colors.white70,
      child: const Text(
        'ssfsss',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
