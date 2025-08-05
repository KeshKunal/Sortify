import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle healinetextstyle(double size) {
    return TextStyle(
        color: Colors.black,
        fontSize: size,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.1);
  }

  static TextStyle normaltextstyle(double size) {
    return TextStyle(
        color: Colors.black, fontSize: size, fontWeight: FontWeight.w500);
  }
}
