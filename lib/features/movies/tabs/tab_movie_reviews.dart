import 'package:dewa_movies/features/home/controllers/controller_movie_results.dart';
import 'package:dewa_movies/features/movies/components/movie_reviews.dart';
import 'package:dewa_movies/features/movies/controllers/controller_movie_detail.dart';
import 'package:dewa_movies/features/movies/models/model_movie_base.dart';
import 'package:dewa_movies/shared/constants/colors.dart';
import 'package:dewa_movies/shared/constants/strings.dart';
import 'package:dewa_movies/shared/helpers/helper_widget_builder.dart';
import 'package:dewa_movies/shared/shared.dart';
import 'package:dewa_movies/shared/widgets/loaders/loader_spinner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabMovieReviews extends StatelessWidget with AvatarBuilderMixin {
  final _detailsController = Get.find<ControllerMovieDetail>();
  final _resultsController = Get.find<ControllerMovieResults>();

  TabMovieReviews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: 'movie_reviews',
      init: _detailsController,
      initState: (_) {
        print('tab_movie_reviews movieId');
        print('${_resultsController.movieId}');
        _detailsController.getOtherDetails(
            resultType: ApiStrings.movies,
            id: _resultsController.movieId,
            appendTo: ApiStrings.reviews);
      },
      builder: (controller) => HelperWidgetBuilder(
        state: _detailsController.reviewsState.value,
        onLoadingBuilder: LoaderSpinner().fadingCircleSpinner,
        onErrorBuilder: Center(
          child: Text('error whlie loading data ...'),
        ),
        onSuccessBuilder: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              child: Text(
                '${_detailsController.reviews.value.results == null ? 0 : _detailsController.reviews.value.results!.length} Reviews',
                style: TextStyle(
                  color: ColorConstants.appBackgroundDarker.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
            ),
            ListView.separated(
              itemCount: _detailsController.reviews.value.results == null
                  ? 0
                  : _detailsController.reviews.value.results!.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemBuilder: (context, index) {
                ReviewsResult review =
                    _detailsController.reviews.value.results![index];

                return ReviewBuilder(
                  key: UniqueKey(),
                  review: review,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
