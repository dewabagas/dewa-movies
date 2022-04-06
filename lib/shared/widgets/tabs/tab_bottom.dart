import 'package:dewa_movies/controllers/controller_utility.dart';
import 'package:dewa_movies/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget? bottomTabbarComponent(
    {required List<String> tabMenuItems}) {
  final _scrollController = ScrollController();

  return PreferredSize(
    preferredSize: Size(MediaQuery.of(Get.context!).size.width, kToolbarHeight),
    child: Container(
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          height: kToolbarHeight,
          child: Row(
            children: List.from(tabMenuItems.map((e) {
              int index = tabMenuItems.indexOf(e);
              return tabbarItem(
                index: index,
                title: e,
                controller: _scrollController,
              );
            })),
          ),
        ),
      ),
    ),
  );
}

// helper tabbar items
Widget tabbarItem({
  required int index,
  required String title,
  required ScrollController controller,
}) {
  final _utilityController = Get.find<ControllerUtility>();

  return GestureDetector(
    onTap: () {
      _utilityController.setTabbarIndex(index);
    },
    child: Container(
      height: 80,
      color: Colors.transparent,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child:
          //
          //Obx(() =>
          GetBuilder(
        id: 'bottomTabBar',
        init: _utilityController,
        builder: (controller) => Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: _utilityController.tabbarCurrentIndex == index
                ? ColorConstants.appText.withOpacity(0.8)
                : ColorConstants.appText.withOpacity(0.5),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // ),
    ),
  );
}
