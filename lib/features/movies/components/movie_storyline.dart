import 'package:dewa_movies/controllers/controller_utility.dart';
import 'package:dewa_movies/features/movies/components/button_hide.dart';
import 'package:dewa_movies/features/movies/components/header_text.dart';
import 'package:dewa_movies/shared/constants/colors.dart';
import 'package:dewa_movies/shared/constants/strings.dart';
import 'package:dewa_movies/shared/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget storylineTextBuilder(
    {required String text, int? maxLines, String? headerText}) {
  final _utilityController = Get.find<ControllerUtility>();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      headerBuilder(headerText: headerText ?? "Story Line"),
      SizedBox(height: 8),
      text == ""
          ? Text(
              Applications.errorEmpty,
              style: TextStyle(
                  color: ColorConstants.appBackground.withOpacity(0.6)),
            )
          : _utilityController.showText != true
              ? Text(
                  text,
                  maxLines: maxLines ?? 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.subtitlePoppins.copyWith(
                      color: ColorConstants.appBackground.withOpacity(0.8)),
                )
              : Text(
                  text,
                  style: TextStyles.subtitlePoppins.copyWith(
                      color: ColorConstants.appBackground.withOpacity(0.6)),
                ),
      text == "" ? SizedBox.shrink() : toggleHideShowBtn(),
    ],
  );
}
