import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserIconView extends StatelessWidget {
  UserIconView({required this.url, super.key});
  String url;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
          image: url == 'none'
              ? const DecorationImage(
                  image: AssetImage(
                    'lib/images/play-button.png',
                  ),
                  fit: BoxFit.fill)
              : DecorationImage(
                  image: NetworkImage(
                    url,
                  ),
                  fit: BoxFit.fill),
        ),
      ),
    );
  }
}
