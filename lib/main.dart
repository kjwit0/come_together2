import 'package:come_together2/components/come_together_themes.dart';
import 'package:flutter/material.dart';

import 'pages/first_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Come Tegether',
      theme: CometogetherTheme.darkTheme,
      home: const FirstPage(),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: child!,
      ),
    );
  }
}
