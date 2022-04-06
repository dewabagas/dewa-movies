import 'package:dewa_movies/controllers/controller_utility.dart';
import 'package:dewa_movies/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget toggleHideShowBtn() {
  final _utilityController = Get.find<ControllerUtility>();

  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      GestureDetector(
        onTap: () {
          _utilityController.toggleHideShowBtn();
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
          color: Colors.transparent,
          child: Obx(() => Text(
                _utilityController.showText != true ? 'More' : 'Less',
                style: TextStyle(
                  color: ColorConstants.appBackground,
                  fontSize: 14,
                ),
              )),
        ),
      ),
    ],
  );
}
