import 'package:dewa_movies/controllers/controller_utility.dart';
import 'package:dewa_movies/features/home/controllers/controller_movie_results.dart';
import 'package:dewa_movies/features/movies/controllers/controller_movie_detail.dart';
import 'package:dewa_movies/features/tv_series/components/tv_flexible_spacebar.dart';
import 'package:dewa_movies/features/tv_series/tabs/tab_tv_about.dart';
import 'package:dewa_movies/routes/routes.dart';
import 'package:dewa_movies/shared/constants/strings.dart';
import 'package:dewa_movies/shared/helpers/helper_widget_builder.dart';
import 'package:dewa_movies/shared/shared.dart';
import 'package:dewa_movies/shared/widgets/loaders/loader_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ScreenTvDetail extends StatelessWidget {
  // final String tvId;

  final _detailsController = Get.find<ControllerMovieDetail>();
  final _utilityController = Get.find<ControllerUtility>();
  final _resultsController = Get.find<ControllerMovieResults>();

  ScreenTvDetail({
    // required this.tvId,
    Key? key,
  }) : super(key: key);

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _resultsController.getTvResults(resultType: ApiStrings.popular);
        _resultsController.getTvResults(resultType: ApiStrings.onTheAir);

        Get.offAllNamed(Routes.HOME);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder(
            id: "tv_details",
            init: _detailsController,
            initState: (_) {
              _detailsController.getDetails(
                  resultType: ApiStrings.tv, id: _resultsController.tvId);
              _utilityController.resetImgSliderIndex();
              _utilityController.resetTabbarState();
              _utilityController.resetHideShowState();
            },
            builder: (_) {
              return HelperWidgetBuilder(
                state: _detailsController.tvDetailState.value,
                onLoadingBuilder:
                    Center(child: LoaderSpinner().horizontalLoading),
                onErrorBuilder: Center(
                  child: Text(Applications.errorLoad),
                ),
                onSuccessBuilder: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      elevation: 0.5,
                      forceElevated: true,
                      backgroundColor: Colors.white,
                      leading: ButtonSliverBack(
                        onBack: () {
                          _resultsController.getTvResults(
                              resultType: ApiStrings.popular);
                          _resultsController.getTvResults(
                              resultType: ApiStrings.onTheAir);

                          Get.offAllNamed(Routes.HOME);
                        },
                      ),
                      title: HeaderSliverMovie(
                          child: Text(
                        _detailsController.tvDetail.value.name ?? 'Title',
                        style: TextStyle(
                          color: ColorConstants.appBackground,
                        ),
                      )),
                      expandedHeight: _utilityController.titlevisiblity == false
                          ? 446
                          : 440,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        background: Column(
                          children: [
                            tvFlexibleSpacebarComponent(
                              tv: _detailsController.tvDetail.value,
                              height: 200,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
                              child: Row(
                                children: [
                                  _detailsController
                                              .tvDetail.value.voteAverage ==
                                          null
                                      ? SizedBox.shrink()
                                      : CircularPercentIndicator(
                                          radius: 25,
                                          percent: (_detailsController
                                                  .tvDetail
                                                  .value
                                                  .voteAverage! /
                                              10),
                                          curve: Curves.ease,
                                          animation: true,
                                          animationDuration: 800,
                                          progressColor:
                                              ColorConstants.appBackground,
                                          center: Text(
                                            '${(_detailsController.tvDetail.value.voteAverage! * 10).toInt()}%',
                                            style: TextStyle(
                                              color: ColorConstants
                                                  .appBackgroundDarker,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                  Text(
                                    'Vote\nAverage',
                                    textAlign: TextAlign.center,
                                    style: TextStyles.subtitleAvenir
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(width: 4.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 6),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: ColorConstants.appBackground
                                          .withOpacity(0.9),
                                      borderRadius: Corners.lgBorder,
                                    ),
                                    child: Text(
                                      '${_detailsController.tvDetail.value.voteCount}',
                                      style: TextStyles.titleAvenir
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    'Vote\nCounts',
                                    textAlign: TextAlign.center,
                                    style: TextStyles.subtitleAvenir
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      bottom: bottomTabbarComponent(tabMenuItems: tabMenuItems),
                    ),
                    GetBuilder(
                      id: 'tabs',
                      init: _utilityController,
                      builder: (controller) => SliverList(
                          delegate: SliverChildListDelegate.fixed([
                        tvTabs[_utilityController.tabbarCurrentIndex],
                        SizedBox(
                          height: 120.h,
                        )
                      ])),
                    )
                  ],
                ),
                // ),
              );
            },
          ),
        ),
      ),
    );
  }
}

var tabMenuItems = <String>[
  "Overview",
];

var tvTabs = <Widget>[
  TabTvAbout(),

];
