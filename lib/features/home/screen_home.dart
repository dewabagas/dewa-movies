import 'dart:io';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:dewa_movies/controllers/controller_configuration.dart';
import 'package:dewa_movies/controllers/controller_utility.dart';
import 'package:dewa_movies/features/home/controllers/controller_movie_results.dart';
import 'package:dewa_movies/features/home/tabs/tabs.dart';
import 'package:dewa_movies/shared/constants/assets.dart';
import 'package:dewa_movies/shared/constants/colors.dart';
import 'package:dewa_movies/shared/constants/constants.dart';
import 'package:dewa_movies/shared/constants/strings.dart';
import 'package:dewa_movies/shared/helpers/helper_widget_builder.dart';
import 'package:dewa_movies/shared/shared.dart';
import 'package:dewa_movies/shared/widgets/loaders/loader_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class ScreenHome extends StatelessWidget {
  final _configurationController = Get.find<ControllerConfiguration>();
  final _utilityController = Get.find<ControllerUtility>();
  final _resultsController = Get.find<ControllerMovieResults>();

  ScreenHome({Key? key}) : super(key: key);

  final List<Widget> tabs = [TabMovies(), TabTvSeries(), TabProfile()];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.dialog(AlertDialog(
          title: const Text(Applications.exitDialog),
          actions: [
            TextButton(
              onPressed: () {
                exit(0);
              },
              child: const Text(Applications.exit),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(Applications.cancel),
            ),
          ],
        ));
        return false;
      },
      child: Scaffold(
          // appBar: AppBar(),
          bottomNavigationBar: userBottomNavBarBuilder(),
          body: SafeArea(
            child: Obx(
              () => HelperWidgetBuilder(
                state: _configurationController.configState.value,
                onLoadingBuilder: LoaderSpinner().fadingCircleSpinner,
                onErrorBuilder: const Center(
                  child: Text(Applications.errorLoad),
                ),
                onSuccessBuilder: SingleChildScrollView(
                  child: Column(
                    children: [tabs[_utilityController.navCurrentIndex]],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Widget userBottomNavBarBuilder() => SafeArea(
        child: Obx(
          () => HelperWidgetBuilder(
            state: _configurationController.configState.value,
            onLoadingBuilder: LoaderSpinner().fadingCircleSpinner,
            onErrorBuilder: const Center(
              child: Text(Applications.errorLoad),
            ),
            onSuccessBuilder: BubbleBottomBar(
              currentIndex: _utilityController.navCurrentIndex,
              onTap: (index) => _utilityController.setBottomNavIndex(index),
              opacity: .2,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              elevation: 8,
              fabLocation: BubbleBottomBarFabLocation.end, //new
              hasNotch: true, //new
              hasInk: true, //new, gives a cute ink effect
              inkColor:
                  Colors.black12, //optional, uses theme color if not specified
              items: <BubbleBottomBarItem>[
                BubbleBottomBarItem(
                    backgroundColor: ColorConstants.appBackground,
                    icon: SvgPicture.asset(Svgs.iconHome,
                        width: 20,
                        height: 20,
                        color: ColorConstants.appBackground),
                    activeIcon: SvgPicture.asset(Svgs.iconHome,
                        width: 20,
                        height: 20,
                        color: ColorConstants.appBackground),
                    title: Text("Movies", style: TextStyles.bottomTabItems)),
                BubbleBottomBarItem(
                    backgroundColor: ColorConstants.appBackground,
                    icon: SvgPicture.asset(Svgs.iconPlay,
                        width: 20,
                        height: 20,
                        color: ColorConstants.appBackground),
                    activeIcon: SvgPicture.asset(Svgs.iconPlay,
                        width: 20,
                        height: 20,
                        color: ColorConstants.appBackground),
                    title: Text("TV Series", style: TextStyles.bottomTabItems)),
                BubbleBottomBarItem(
                    backgroundColor: ColorConstants.appBackground,
                    icon: SvgPicture.asset(Svgs.iconUser,
                        width: 20,
                        height: 20,
                        color: ColorConstants.appBackground),
                    activeIcon: SvgPicture.asset(Svgs.iconUser,
                        width: 20,
                        height: 20,
                        color: ColorConstants.appBackground),
                    title: Text("Profile", style: TextStyles.bottomTabItems)),
              ],
            ),
          ),
        ),
      );
}
