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
                          SizedBox(height: 18.h),
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
  // MovieRecommendedTab(),
  // MovieSimilarTab(),
];
