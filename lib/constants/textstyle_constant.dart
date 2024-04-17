// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class TextStyleConstant {
  TextStyle TextStyleInterNormal(Color textColor, double textSize) {
    return TextStyle(
        fontFamily: 'Inter',
        fontSize: textSize,
        fontWeight: FontWeight.normal,
        color: textColor);
  }
  TextStyle TextStyleInterBold(Color textColor, double textSize) {
    return TextStyle(
        fontFamily: 'Inter',
        fontSize: textSize,
        fontWeight: FontWeight.bold,
        color: textColor);
  }
}