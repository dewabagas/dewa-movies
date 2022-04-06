import 'package:dewa_movies/features/home/controllers/controller_base.dart';
import 'package:dewa_movies/features/home/controllers/controller_movie_results.dart';
import 'package:dewa_movies/features/home/models/model_movie_result.dart';
import 'package:dewa_movies/routes/routes.dart';
import 'package:dewa_movies/shared/constants/strings.dart';
import 'package:dewa_movies/shared/shared.dart';
import 'package:dewa_movies/shared/widgets/buttons/button_pagination.dart';
import 'package:dewa_movies/shared/widgets/cards/card_movie_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget componentMovies({
  required String resultType,
  required String posterUrl,
  required Rx<ViewState> state,
  String? title,
  String? subtitle,
  Widget? trailingBtn,
  void Function()? onMoreTap,
}) {
  final _resultsController = Get.find<ControllerMovieResults>();

  RxList<MovieResultModel>? getItem(String resultType) {
    switch (resultType) {
      case ApiStrings.popular:
        return _resultsController.popularMovies;
      case ApiStrings.upcoming:
        return _resultsController.upcommingMovies;
      case ApiStrings.nowPlaying:
        return _resultsController.nowPlayingMovies;
      default:
        break;
    }
  }

  return SizedBox(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title & more option
        headerTile(
          onMoreTap: () {
            _resultsController.getMovieResults(
                resultType: resultType, page: '1');
            Get.toNamed(Routes.MOVIE_LIST, arguments: {
              "state": state,
              "title": '$title $subtitle',
              "resultType": resultType
            });
          },
          title: title ?? "title",
          subtitle: subtitle ?? "subtitle",
        ),

        SizedBox(height: 12),

        Container(
          height: 200,
          width: MediaQuery.of(Get.context!).size.width,
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(
              () => Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Row(
                  children: [
                    ListView.builder(
                        itemExtent: 96,
                        cacheExtent: 1200,
                        semanticChildCount: getItem(resultType) == null
                            ? 0
                            : getItem(resultType)!.length,
                        itemCount: getItem(resultType) == null
                            ? 0
                            : getItem(resultType)!.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => getItem(
                                            resultType)![index]
                                        .posterPath ==
                                    null ||
                                getItem(resultType)![index].posterPath == ""
                            ? AbsorbPointer(
                                absorbing: true,
                                child: cardMovieThumbnail(
                                    movie: getItem(resultType)![index],
                                    imageUrl:
                                        '$posterUrl${getItem(resultType)![index].posterPath}'),
                              )
                            : cardMovieThumbnail(
                                movie: getItem(resultType)![index],
                                imageUrl:
                                    '$posterUrl${getItem(resultType)![index].posterPath}')),
                    buttonPagination(
                        onTap: () {
                          _resultsController.loadMoreMoviesResults(
                              resultType: resultType);
                        },
                        viewState: state.value),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
