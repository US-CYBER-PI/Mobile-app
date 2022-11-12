import 'package:flutter/material.dart';


/// Класс в котором храняться все цвета приложения
abstract class ColorsCustom {
  static const Color secondary = Color.fromRGBO(255, 140, 0, 1.0);
  static const Color primaryLigth = Colors.white;
  static const Color backgroundLigth = Color.fromRGBO(245, 245, 245, 1.0);
  static const Color tertiaryLigth = Color.fromRGBO(0, 0, 0, 1.0);
  static Color surfaceLigth = Colors.grey.shade400;


  static const Color primaryDark = Color.fromRGBO(0, 0, 0, 0.2);
  static const Color backgroundDark = Color.fromRGBO(45, 53, 64, 1.0);
  static const Color tertiaryDark = Colors.white;
  static Color surfaceDark = Color.fromRGBO(255, 255, 255, 0.3);
}
