import 'package:dewa_movies/controllers/controller_configuration.dart';
import 'package:dewa_movies/features/home/components/component_movies.dart';
import 'package:dewa_movies/features/home/controllers/controller_movie_results.dart';
import 'package:dewa_movies/shared/constants/strings.dart';
import 'package:dewa_movies/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabMovies extends StatelessWidget {
  final _configurationController = Get.find<ControllerConfiguration>();
  final _resultsController = Get.find<ControllerMovieResults>();

  TabMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarBuilder(),
            const SizedBox(height: 16),

            componentMovies(
              onMoreTap: () {},
              resultType: ApiStrings.nowPlaying,
              state: _resultsController.nowPlayingMoviesState,
              posterUrl: _configurationController.posterUrl,
              title: Movies.nowPlaying,
              subtitle: Movies.movies,
            ),
            const SizedBox(height: 22),

            componentMovies(
              onMoreTap: () {},
              resultType: ApiStrings.popular,
              state: _resultsController.popularMoviesState,
              posterUrl: _configurationController.posterUrl,
              title: Movies.popular,
              subtitle: Movies.movies,
            ),
            const SizedBox(height: 22),

            componentMovies(
              onMoreTap: () {},
              resultType: ApiStrings.upcoming,
              state: _resultsController.upcommingMoviesState,
              posterUrl: _configurationController.posterUrl,
              title: Movies.upcoming,
              subtitle: Movies.movies,
            ),

            const SizedBox(height: 22),
            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }
}
