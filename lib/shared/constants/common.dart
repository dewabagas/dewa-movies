import 'package:flutter_screenutil/flutter_screenutil.dart';
class CommonConstants {
  static const String test = 'test';
  static const num testNum = 1;
  static const double largeText = 40.0;
  static const double normalText = 22.0;
  static const double smallText = 16.0;
}
class Insets {
  static double offsetScale = 1;
  static double get xs => 4.w;
  static double get sm => 8.w;
  static double get med => 12.w;
  static double get lg => 16.w;
  static double get xl => 20.w;
  static double get xxl => 32.w;
  // Offset, used for the edge of the window, or to separate large sections in the app
  static double get offset => 40 * offsetScale;
}