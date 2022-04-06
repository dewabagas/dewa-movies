import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:dewa_movies/routes/routes.dart';
import 'package:dewa_movies/shared/shared.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dewa_movies/shared/shared.dart';

class ScreenIntro extends StatefulWidget {
  @override
  ScreenIntroState createState() => ScreenIntroState();
}

class ScreenIntroState extends State<ScreenIntro> {
  List<String> walkthroughList = <String>[
    Walkthrough.walkthroughOne,
    Walkthrough.walkthroughTwo,
    Walkthrough.walkthroughThree
  ];

  int position = 0;

  PageController? pageController;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    pageController =
        PageController(initialPage: position, viewportFraction: 0.75);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 70.h),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: PageView.builder(
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: walkthroughList.length,
                  itemBuilder: (context, index) {
                    return AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      decoration: BoxDecoration(
                          boxShadow: Shadows.small,
                          borderRadius: Corners.lgBorder),
                      height: index == position
                          ? MediaQuery.of(context).size.height * 0.5
                          : MediaQuery.of(context).size.height * 0.45,
                      margin: EdgeInsets.only(left: 16.w, right: 8.w),
                      child: Image.asset(
                        walkthroughList[index],
                        fit: BoxFit.cover,
                        width: 100.w,
                      ).cornerRadiusWithClipRRect(16),
                    );
                  },
                  onPageChanged: (value) {
                    setState(() {
                      position = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20.h),
              DotIndicator(
                pageController: pageController!,
                pages: walkthroughList,
                indicatorColor: ColorConstants.appText,
              ),
              SizedBox(height: 16.h),
              Text(
                StringWalkthrough.title,
                style: TextStyles.titleAvenir.copyWith(
                    fontWeight: FontWeight.w700, color: ColorConstants.appText),
              ),
              SizedBox(height: 16.h),
              Text(StringWalkthrough.subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyles.subtitleAvenir),
              
            ],
          ),
          Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledButton(
                    text: 'Skip',
                    color: Color(0xFFFE901C),
                    height: 60.h,
                    width: (MediaQuery.of(context).size.width - (3 * 16)) * 0.5,
                    onPressed: () {
                      Get.toNamed(Routes.HOME);
                    },
                  ),
                  FilledButton(
                    text: position < 2 ? 'Next' : 'Finish',
                    color: ColorConstants.appBackgroundDarker,
                    height: 60.h,
                    width: (MediaQuery.of(context).size.width - (3 * 16)) * 0.5,
                    onPressed: () {
                      if (position < 2) {
                        pageController!.nextPage(
                            duration: Duration(microseconds: 300),
                            curve: Curves.linear);
                      } else if (position == 2) {
                        Get.toNamed(Routes.HOME);
                      }
                    },
                  ),
                ],
              )),
        ],
      ).withHeight(MediaQuery.of(context).size.height),
    );
  }
}
