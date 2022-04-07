import 'dart:ui';
import 'package:dewa_movies/features/movies/tabs/tab_movie_about.dart';
import 'package:dewa_movies/features/movies/tabs/tab_movie_casts.dart';
import 'package:dewa_movies/features/movies/tabs/tab_movie_reviews.dart';
import 'package:get/get.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dewa_movies/controllers/controller_utility.dart';
import 'package:dewa_movies/features/home/controllers/controller_movie_results.dart';
import 'package:dewa_movies/features/movies/components/movie_flexible_spacebar.dart';
import 'package:dewa_movies/features/movies/controllers/controller_movie_detail.dart';
import 'package:dewa_movies/routes/routes.dart';
import 'package:dewa_movies/shared/helpers/helper_widget_builder.dart';
import 'package:dewa_movies/shared/shared.dart';
import 'package:dewa_movies/shared/widgets/loaders/loader_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ScreenMovieDetail extends StatelessWidget {
  final String movieId;

  ScreenMovieDetail({
    required this.movieId,
    Key? key,
  }) : super(key: key);

  final _detailsController = Get.find<ControllerMovieDetail>();

  final _utilityController = Get.find<ControllerUtility>();

  final scrollController = ScrollController();

  final _resultsController = Get.find<ControllerMovieResults>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _resultsController.getMovieResults(resultType: ApiStrings.popular);
        _resultsController.getMovieResults(resultType: ApiStrings.upcoming);
        _resultsController.getMovieResults(resultType: ApiStrings.nowPlaying);

        Get.offAllNamed(Routes.HOME);
        return false;
      },
      child: Scaffold(
          body: SafeArea(
        child: GetBuilder(
          id: 'movie_details',
          init: _detailsController,
          initState: (_) {
            _detailsController.getDetails(
                resultType: ApiStrings.movie, id: movieId);

            _utilityController.resetImgSliderIndex();
            _utilityController.resetTabbarState();
            _utilityController.resetHideShowState();
          },
          builder: (_) {
            return HelperWidgetBuilder(
              state: _detailsController.movieDetailState.value,
              onLoadingBuilder: Center(
                child: LoaderSpinner().horizontalLoading,
              ),
              onErrorBuilder: Center(child: Text("error")),
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
                        _resultsController.getMovieResults(
                            resultType: ApiStrings.popular);
                        _resultsController.getMovieResults(
                            resultType: ApiStrings.upcoming);
                        _resultsController.getMovieResults(
                            resultType: ApiStrings.nowPlaying);

                        Get.offAllNamed(Routes.HOME);
                      },
                    ),
                    title: HeaderSliverMovie(
                        child: Text(
                      _detailsController.movieDetail.value.title ?? 'Title',
                      style: TextStyle(
                          color: ColorConstants.appBackground.withOpacity(0.8)),
                    )),
                    expandedHeight:
                        _utilityController.titlevisiblity == false ? 446 : 440,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: Column(
                        children: [
                          movieFlexibleSpacebarComponent(
                              movie: _detailsController.movieDetail.value,
                              height: 200),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                            child: Row(
                              children: [
                                CircularPercentIndicator(
                                  radius: 25,
                                  percent: (_detailsController
                                          .movieDetail.value.voteAverage! /
                                      10),
                                  curve: Curves.ease,
                                  animation: true,
                                  animationDuration: 800,
                                  progressColor: ColorConstants.appBackground,
                                  center: Text(
                                    '${(_detailsController.movieDetail.value.voteAverage! * 10).toInt()}%',
                                    style: TextStyle(
                                      color: ColorConstants.appBackgroundDarker,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
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
                                    '${_detailsController.movieDetail.value.voteCount}',
                                    style: TextStyles.titleAvenir.copyWith(color: Colors.white),
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'Vote\nCounts',
                                  textAlign: TextAlign.center,
                                  style: TextStyles.subtitleAvenir.copyWith(fontWeight: FontWeight.w700),
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
                      movieTabs[_utilityController.tabbarCurrentIndex],
                      SizedBox(
                        height: 120.h,
                      )
                    ])),
                  )
                ],
              ),
            );
          },
        ),
      )),
    );
  }
}

var tabMenuItems = <String>[
  "Overview",
  "Cast",
  "Reviews",
];

var movieTabs = <Widget>[
  TabMovieAbout(),
  TabMovieCasts(),
  TabMovieReviews(),
];
