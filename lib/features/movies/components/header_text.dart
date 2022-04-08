import 'package:dewa_movies/shared/constants/colors.dart';
import 'package:dewa_movies/shared/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget headerBuilder({String? headerText}) => Text(
      headerText ?? 'headerText',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyles.poppins.copyWith(fontSize: 16.sp, color: ColorConstants.appBackground.withOpacity(0.8), fontWeight: FontWeight.w700),
    );
