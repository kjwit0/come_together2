import 'package:come_together2/components/come_together_colors.dart';
import 'package:flutter/material.dart';

class CometogetherTheme {
  static ThemeData get darkTheme => ThemeData(
        primarySwatch: CometogetherColors.primaryMaterialColor,
        // scaffoldBackgroundColor: Colors.black54,
        splashColor: Colors.blue[300],
        textTheme: _textTheme,
        brightness: Brightness.dark,
      );

  static const TextTheme _textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w500,
      color: Color.fromARGB(160, 0, 0, 0),
    ),
    headlineMedium: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w500,
      color: CometogetherColors.textPrimaryColor,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: CometogetherColors.textPrimaryColor,
    ),
    labelLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: CometogetherColors.textPrimaryColor,
    ),
    labelMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: CometogetherColors.textPrimaryColor,
    ),
    labelSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: CometogetherColors.textPrimaryColor,
    ),
    bodyLarge: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w300,
      color: CometogetherColors.textPrimaryColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w300,
      color: CometogetherColors.textPrimaryColor,
    ),
    bodySmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w300,
      color: CometogetherColors.textPrimaryColor,
    ),
  );
}
