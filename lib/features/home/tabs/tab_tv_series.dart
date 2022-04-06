import 'package:dewa_movies/controllers/controller_configuration.dart';
import 'package:dewa_movies/features/home/controllers/controller_movie_results.dart';
import 'package:dewa_movies/features/home/components/component_tv.dart';
import 'package:dewa_movies/shared/constants/strings.dart';
import 'package:dewa_movies/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabTvSeries extends StatelessWidget {
  final _configurationController = Get.find<ControllerConfiguration>();
  final _resultsController = Get.find<ControllerMovieResults>();

  TabTvSeries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarBuilder(),
            const SizedBox(height: 16),
            componentTv(
              onMoreTap: () {},
              resultType: ApiStrings.onTheAir,
              state: _resultsController.onTheAirTvState,
              posterUrl: _configurationController.posterUrl,
              title: Movies.onTheAir,
              subtitle: Movies.tvSeries,
            ),
            const SizedBox(height: 22),
            componentTv(
              onMoreTap: () {},
              resultType: ApiStrings.popular,
              state: _resultsController.popularTvState,
              posterUrl: _configurationController.posterUrl,
              title: Movies.popular,
              subtitle: Movies.tvSeries,
            ),
            const SizedBox(height: 22),
            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }
}
