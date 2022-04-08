import 'package:dewa_movies/controllers/controller_configuration.dart';
import 'package:dewa_movies/features/home/controllers/controller_movie_results.dart';
import 'package:dewa_movies/features/movies/components/movie_genre.dart';
import 'package:dewa_movies/features/movies/components/movie_storyline.dart';
import 'package:dewa_movies/features/movies/controllers/controller_movie_detail.dart';
import 'package:dewa_movies/features/tv_series/components/tv_info.dart';
import 'package:dewa_movies/shared/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TabTvAbout extends StatelessWidget {
  final _detailsController = Get.find<ControllerMovieDetail>();
  final _resultsController = Get.find<ControllerMovieResults>();
  final _configurationController = Get.find<ControllerConfiguration>();

  TabTvAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        //  Obx(
        //   () =>
        GetBuilder(
      id: 'tv_about',
      init: _detailsController,
      initState: (_) {
        _detailsController.getOtherDetails(
            resultType: ApiStrings.tv,
            id: _resultsController.tvId,
            appendTo: ApiStrings.images);
      },
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: storylineTextBuilder(
                text: _detailsController.tvDetail.value.overview ??
                    "no storyline at the moment"),
          ),
          SizedBox(height: 12),

          // genres
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: genreBuilder(
                genres: _detailsController.tvDetail.value.genres ?? []),
          ),
          SizedBox(height: 18),
          // networks
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: networkBuilder(
          //       networks: _detailsController.tvDetail.value.networks ?? []),
          // ),
          // const SizedBox(height: 18),

          // tv info
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: tvInfoBuilder(tvDetails: _detailsController.tvDetail.value),
          ),
          SizedBox(height: 28),
        ],
      ),
    );
  }
}
