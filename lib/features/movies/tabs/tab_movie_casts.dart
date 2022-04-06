import 'package:cached_network_image/cached_network_image.dart';
import 'package:dewa_movies/controllers/controller_configuration.dart';
import 'package:dewa_movies/features/home/controllers/controller_movie_results.dart';
import 'package:dewa_movies/features/movies/controllers/controller_movie_detail.dart';
import 'package:dewa_movies/features/movies/models/model_movie_base.dart';
import 'package:dewa_movies/shared/constants/colors.dart';
import 'package:dewa_movies/shared/constants/strings.dart';
import 'package:dewa_movies/shared/helpers/helper_widget_builder.dart';
import 'package:dewa_movies/shared/shared.dart';
import 'package:dewa_movies/shared/widgets/loaders/loader_spinner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabMovieCasts extends StatelessWidget with AvatarBuilderMixin {
  final _detailsController = Get.find<ControllerMovieDetail>();
  final _resultController = Get.find<ControllerMovieResults>();
  final _configurationController = Get.find<ControllerConfiguration>();

  TabMovieCasts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: 'movie_cast',
      init: _detailsController,
      initState: (_) {
        _detailsController.getOtherDetails(
            resultType: ApiStrings.movie,
            id: _resultController.movieId,
            appendTo: ApiStrings.credits);
      },
      builder: (controller) => HelperWidgetBuilder(
        state: _detailsController.creditsState.value,
        onLoadingBuilder: LoaderSpinner().fadingCircleSpinner,
        onErrorBuilder: Center(
          child: Text(Applications.errorLoad),
        ),
        onSuccessBuilder: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              child: Text(
                '${_detailsController.credits.value.cast == null ? 0 : _detailsController.credits.value.cast!.length} Persons',
                style: TextStyle(
                  color: ColorConstants.appBackground.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
            ),
            ListView.separated(
              itemCount: _detailsController.credits.value.cast == null
                  ? 0
                  : _detailsController.credits.value.cast!.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemBuilder: (context, index) {
                Cast cast = _detailsController.credits.value.cast![index];

                return InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: cast.profilePath == null
                              ? avatarBuilder()
                              : CachedNetworkImage(
                                  height: 68,
                                  width: 68,
                                  imageUrl:
                                      '${_configurationController.posterUrl}${cast.profilePath}',
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      Container(color: Colors.black26),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    color: Colors.black38,
                                    child: Center(
                                      child: Icon(
                                        Icons.error_outline,
                                        color: Colors.white,
                                        size: 34,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cast.name ?? "name",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorConstants.appBackground
                                      .withOpacity(0.7),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                cast.character ?? "character",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ColorConstants.appBackground
                                      .withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
