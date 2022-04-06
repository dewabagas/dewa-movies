import 'package:dewa_movies/shared/constants/colors.dart';
import 'package:dewa_movies/shared/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget headerTile({
  String? title,
  String? subtitle,
  void Function()? onMoreTap,
  Widget? toggleOption,
}) {
  return Container(
    padding: EdgeInsets.only(left: 12.w, right: 5.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              title ?? 'title',
              style:  TextStyles.listHeader,
            ),
             SizedBox(width: 4),
            Text(
              subtitle ?? 'subtitle',
              style:  TextStyles.listHeaderSecond,
            ),
             SizedBox(width: 6),
            toggleOption ??  SizedBox.shrink(),
          ],
        ),
        IconButton(
            onPressed: onMoreTap,
            icon: Icon(
              Icons.arrow_forward,
              color: ColorConstants.appBackground,
            )),
      ],
    ),
  );
}
