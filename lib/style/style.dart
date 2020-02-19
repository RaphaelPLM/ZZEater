import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

abstract class ThemeText {
  static const TextStyle headerStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500);

  static const TextStyle defaultStyle =
      TextStyle(color: Colors.pink, fontFamily: 'NunitoSans', fontSize: 15.0);

  static const TextStyle buttonStyle1 =
      TextStyle(color: Colors.white, fontFamily: 'NunitoSans', fontSize: 14.0);

  static const TextStyle buttonStyle2 =
      TextStyle(color: Colors.pink, fontFamily: 'NunitoSans', fontSize: 14.0);

  static const TextStyle errorStyle =
      TextStyle(fontSize: 11.0, color: Colors.deepOrange);

  static const LinearGradient myGradient = LinearGradient(
    colors: [Color(0xFF5858E8), Color(0x855858E8)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
