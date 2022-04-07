import 'package:dewa_movies/controllers/controller_configuration.dart';
import 'package:dewa_movies/controllers/controller_utility.dart';
import 'package:dewa_movies/features/home/controllers/controller_movie_results.dart';
import 'package:dewa_movies/features/movies/controllers/controller_movie_detail.dart';
import 'package:dewa_movies/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:dewa_movies/shared/shared.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  final configurationController = Get.find<ControllerConfiguration>();
  final utilityController = Get.find<ControllerUtility>();
  final resultsController = Get.find<ControllerMovieResults>();
  final detailsController = Get.find<ControllerMovieDetail>();

  Future delay() async {
    return await Future.delayed(Duration(milliseconds: 1500));
  }

  @override
  void initState() {
    super.initState();
    delay().whenComplete(() {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        Get.offAllNamed(Routes.INTRO);
      });
    });
  }

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
