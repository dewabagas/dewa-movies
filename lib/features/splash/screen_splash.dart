import 'package:flutter/material.dart';
import 'package:dewa_movies/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Assets.iconMovie, width: 318.w, height: 326.h),
          SizedBox(height: 10.h),
          Text(
            'Movies',
            style: TextStyles.titlePoppins,
          ),
        ],
      ),
    );
  }
}
