import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

// ignore: must_be_immutable
class UserIconView extends StatelessWidget {
  UserIconView({required this.url, super.key});
  String url;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(1),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: (url != 'none')
            ? CachedNetworkImage(
                imageUrl: url,
                placeholder: (context, url) =>
                    Image.asset('lib/images/loading.gif'),
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => Image.asset(
                  'lib/images/play-button.png',
                  fit: BoxFit.fill,
                ),
              )
            : Image.asset(
                'lib/images/play-button.png',
                fit: BoxFit.fill,
              ),
      ),
    );
  }
}
