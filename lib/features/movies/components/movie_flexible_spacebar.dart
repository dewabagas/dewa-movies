import 'package:dewa_movies/controllers/controller_configuration.dart';
import 'package:dewa_movies/controllers/controller_utility.dart';
import 'package:dewa_movies/features/home/controllers/controller_movie_results.dart';
import 'package:dewa_movies/features/movies/controllers/controller_movie_detail.dart';
import 'package:dewa_movies/features/movies/models/model_movie_detail.dart';
import 'package:dewa_movies/shared/helpers/helper_widget_builder.dart';
import 'package:dewa_movies/shared/shared.dart';
import 'package:dewa_movies/shared/widgets/loaders/loader_spinner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget movieFlexibleSpacebarComponent({
  required MovieDetailsModel movie,
  double? height,
}) {
  final _utilityController = Get.find<ControllerUtility>();
  final _configController = Get.find<ControllerConfiguration>();
  final _detailsController = Get.find<ControllerMovieDetail>();
  final _resultController = Get.find<ControllerMovieResults>();

  final String? releaseDate = '${movie.releaseDate}';
  final String? formatedDate =
      DateFormat.yMMMMd().format(movie.releaseDate ?? DateTime(0000));
  final String movieDate = releaseDate!.substring(0, 4);

  return GetBuilder(
    id: 'imageSlider',
    init: _detailsController,
    initState: (_) {
      _detailsController.getOtherDetails(
          resultType: ApiStrings.movie,
          id: _resultController.movieId,
          appendTo: ApiStrings.images);
    },
    builder: (controller) => SizedBox(
      // height: _utilityController.titlevisiblity == false ? 310 : 300,
      height: 310,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          // backdrop image slider
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                // Obx(
                //   () =>
                HelperWidgetBuilder(
                  state: _detailsController.imagesState.value,
                  onLoadingBuilder: SizedBox(
                    height: 200,
                    child: LoaderSpinner().fadingCircleSpinner,
                  ),
                  onErrorBuilder:  Center(
                    child: Text(Applications.errorLoad),
                  ),
                  onSuccessBuilder: ShaderMask(
                    shaderCallback: (rect) {
                      return  LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                          Colors.black,
                          Colors.black,
                          Colors.transparent
                        ],
                      ).createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: Container(
                      decoration:  BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.transparent)),
                      ),
                      child: SizedBox(
                        height: height ?? 190,
                        child: PageView.builder(
                          onPageChanged: (value) {
                            _utilityController.setSliderIndex(value);
                          },
                          itemCount:
                              _detailsController.images.value.backdrops ==
                                          null ||
                                      _detailsController
                                          .images.value.backdrops!.isEmpty
                                  ? 0
                                  : _detailsController
                                      .images.value.backdrops!.length,
                          controller: PageController(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CardBackdrop(
                                imageUrl:
                                    '${_configController.backDropUrl}${_detailsController.images.value.backdrops![index].filePath}');
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                // ),

                // img slider indicator
                _detailsController.images.value.backdrops == null ||
                        _detailsController.images.value.backdrops!.isEmpty
                    ?  SizedBox.shrink()
                    : GetBuilder(
                        id: 'imageSlider',
                        init: _utilityController,
                        builder: (controller) => Positioned(
                          bottom: 16,
                          child: AnimatedSmoothIndicator(
                            activeIndex: _utilityController.imgSliderIndex,
                            effect:  ScrollingDotsEffect(
                              activeDotColor: ColorConstants.appBackground,
                              dotColor: ColorConstants.appText,
                              dotHeight: 6,
                              dotWidth: 6,
                            ),
                            count: _detailsController
                                .images.value.backdrops!.length,
                          ),
                        ),
                      ),
              ],
            ),
          ),

          // poster and title movie details
          Positioned(
            bottom: 0.0,
            left: 0,
            right: 0,
            child: Container(
              padding:  EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  // poster
                  ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: movie.posterPath == null
                          ? Container(
                              alignment: Alignment.center,
                              width: 94,
                              height: 140,
                              color: Colors.black12,
                              child:  Icon(
                                Icons.error_outline,
                                color: Colors.white,
                                size: 34,
                              ),
                            )
                          : cardPoster(
                              imageUrl:
                                  '${_configController.posterUrl}${movie.posterPath}')),
                   SizedBox(width: 16),
                  //  titles
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            movie.status == null
                                ?  SizedBox.shrink()
                                : Container(
                                    padding:  EdgeInsets.symmetric(
                                        horizontal: 6),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: ColorConstants.appBackgroundDarker.withOpacity(0.5),
                                          width: 1,
                                        ),
                                        left: BorderSide(
                                          color: ColorConstants.appBackgroundDarker.withOpacity(0.5),
                                          width: 1,
                                        ),
                                        right: BorderSide(
                                          color: ColorConstants.appBackgroundDarker.withOpacity(0.5),
                                          width: 1,
                                        ),
                                        bottom: BorderSide(
                                          color: ColorConstants.appBackgroundDarker.withOpacity(0.5),
                                          width: 1,
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      _detailsController
                                          .movieDetail.value.status!,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: ColorConstants.appBackground.withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                         SizedBox(height: 6),
                        GestureDetector(
                          onTap: () {
                            // _utilityController.toggleTitleVisibility();
                          },
                          child: Obx(
                            () => _utilityController.titlevisiblity == false
                                ? Text(
                                    '${movie.title} ($movieDate)',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style:  TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.appBackground,
                                    ),
                                  )
                                : Text(
                                    '${movie.title} ($movieDate)',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style:  TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.appBackground,
                                    ),
                                  ),
                          ),
                        ),
                         SizedBox(height: 2),
                        Wrap(
                          children: [
                            Text(
                              formatedDate!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.appBackground.withOpacity(0.7),
                              ),
                            ),
                             SizedBox(width: 4),
                            Text(
                              '•',
                              style: TextStyle(
                                fontSize: 14,
                                color: ColorConstants.appBackground.withOpacity(0.7),
                              ),
                            ),
                             SizedBox(width: 4),
                            Text(
                              '${movie.runtime} mins',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.appBackground.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                         SizedBox(height: 4),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                _detailsController.movieDetail.value.tagline ??
                                    "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: ColorConstants.appBackground.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
