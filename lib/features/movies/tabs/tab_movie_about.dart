import 'package:dewa_movies/controllers/controller_configuration.dart';
import 'package:dewa_movies/features/home/controllers/controller_movie_results.dart';
import 'package:dewa_movies/features/movies/components/movie_genre.dart';
import 'package:dewa_movies/features/movies/components/movie_info.dart';
import 'package:dewa_movies/features/movies/components/movie_storyline.dart';
import 'package:dewa_movies/features/movies/controllers/controller_movie_detail.dart';
import 'package:dewa_movies/shared/constants/strings.dart';
import 'package:dewa_movies/shared/helpers/helper_widget_builder.dart';
import 'package:dewa_movies/shared/widgets/loaders/loader_spinner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabMovieAbout extends StatelessWidget {
  final _detailsController = Get.find<ControllerMovieDetail>();
  final _resultsController = Get.find<ControllerMovieResults>();
  final _configurationController = Get.find<ControllerConfiguration>();

  TabMovieAbout({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: 'movie_about',
      init: _detailsController,
      initState: (_) {
        _detailsController.getOtherDetails(
            resultType: ApiStrings.movie,
            id: _resultsController.movieId,
            appendTo: ApiStrings.images);
      },
      builder: (controller) => HelperWidgetBuilder(
        state: _detailsController.movieDetailState.value,
        onLoadingBuilder: LoaderSpinner().fadingCircleSpinner,
        onErrorBuilder: Center(
          child: Text(Applications.errorLoad)
        ),
        onSuccessBuilder: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           SizedBox(height: 18),
            ///story line
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: storylineTextBuilder(
                  text: _detailsController.movieDetail.value.overview ??
                      Applications.errorEmpty),
            ),
           SizedBox(height: 12),

            /// genre
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: genreBuilder(
                  genres: _detailsController.movieDetail.value.genres ?? []),
            ),
           SizedBox(height: 28),

            ///movie info
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: movieInfoBuilder(
                  movieDetails: _detailsController.movieDetail.value),
            ),
           SizedBox(height: 24),

          ],
        ),
      ),
    );
  }
}
