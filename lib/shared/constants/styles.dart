import 'package:dewa_movies/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Corners {
  static double sm = 3.w;
  static BorderRadius smBorder = BorderRadius.all(smRadius);
  static Radius smRadius = Radius.circular(sm);

  static double med = 5.w;
  static BorderRadius medBorder = BorderRadius.all(medRadius);
  static Radius medRadius = Radius.circular(med);

  static double lg = 8.w;
  static BorderRadius lgBorder = BorderRadius.all(lgRadius);
  static Radius lgRadius = Radius.circular(lg);

  static double xl = 16.w;
  static BorderRadius xlBorder = BorderRadius.all(xlRadius);
  static Radius xlRadius = Radius.circular(xl);

  static double xxl = 24.w;
  static BorderRadius xxlBorder = BorderRadius.all(xxlRadius);
  static Radius xxlRadius = Radius.circular(xxl);
}

class Shadows {
  static List<BoxShadow> get universal => [
        BoxShadow(
            color: const Color(0xff333333).withOpacity(.13),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 5)),
      ];
  static List<BoxShadow> get small => [
        BoxShadow(
            color: const Color(0xff333333).withOpacity(.15),
            spreadRadius: 0,
            blurRadius: 3,
            offset: const Offset(0, 1)),
      ];
  static List<BoxShadow> get none => [
        BoxShadow(
            color: ColorConstants.appBackground,
            spreadRadius: 0,
            blurRadius: 0,
            offset: const Offset(0, 0)),
      ];

  static List<BoxShadow> get shadowsUp => [
        BoxShadow(
            color: const Color(0xff333333).withOpacity(.15),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(-1, 0)),
      ];
}

class TextStyles {
  static const TextStyle avenir =
      TextStyle(fontFamily: "Avenir", fontWeight: FontWeight.w400);
  static const TextStyle poppins =
      TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w400);
  static const TextStyle montserrat =
      TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w400);

  static TextStyle get titleAvenir => avenir.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 22.sp,
      letterSpacing: -1,
      color: ColorConstants.appBackground,
      height: 1.17);
  static TextStyle get titlePoppins => poppins.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 20.sp,
      letterSpacing: -1,
      color: ColorConstants.appBackground,
      height: 1.17);
  static TextStyle get titleMontserrat => montserrat.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 20.sp,
      color: ColorConstants.appBackground,
      letterSpacing: -1,
      height: 1.17);
      
  static TextStyle get subtitleAvenir => avenir.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      color: ColorConstants.appBackground);

  static TextStyle get subtitlePoppins => poppins.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      color: ColorConstants.appBackground);

  static TextStyle get subtitleMontserrat => montserrat.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      color: ColorConstants.appBackground);

  static TextStyle get bottomTabItems => poppins.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
      color: ColorConstants.appBackground);

  static TextStyle get listHeader => poppins.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 18.sp,
      color: ColorConstants.appBackground);

  static TextStyle get listHeaderSecond => poppins.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 16.sp,
      color: ColorConstants.appText);
}
