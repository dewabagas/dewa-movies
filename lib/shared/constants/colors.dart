import 'package:flutter/material.dart';

class ColorConstants {
  static Color mainBlue = hexToColor("#5E76FA");
  static Color mainNavy = hexToColor("#4F5F8E");

  static Color lightScaffoldBackgroundColor = hexToColor('#F9F9F9');
  static Color darkScaffoldBackgroundColor = hexToColor('#2F2E2E');
  static Color secondaryAppColor = hexToColor('#22DDA6');
  static Color secondaryDarkAppColor = Colors.white;
  static Color tipColor = hexToColor('#B6B6B6');
  static Color lightGray = hexToColor("#D1D1D1");
  static Color gray = hexToColor("#979797");
  static Color darkGray = Color(0xFF9F9F9F);
  static Color black = Color(0xFF000000);
  static Color white = Color(0xFFFFFFFF);

  static Color appBackground = Color(0xFF26272B);
  static Color appBackgroundDarker = Color(0xFF202123);
  static Color navigationBackground = Color(0xFF202123);

  static Color appText = Color(0xFFFE901C);
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
