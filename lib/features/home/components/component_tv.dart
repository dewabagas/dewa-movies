import 'package:dewa_movies/features/home/controllers/controller_base.dart';
import 'package:dewa_movies/features/home/controllers/controller_movie_results.dart';
import 'package:dewa_movies/features/tv_series/models/model_tv.dart';
import 'package:dewa_movies/routes/routes.dart';
import 'package:dewa_movies/shared/constants/strings.dart';
import 'package:dewa_movies/shared/shared.dart';
import 'package:dewa_movies/shared/widgets/buttons/button_pagination.dart';
import 'package:dewa_movies/shared/widgets/cards/card_tv_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget componentTv({
  required Rx<ViewState> state,
  required String resultType,
  required String posterUrl,
  String? title,
  String? subtitle,
  void Function()? onMoreTap,
}) {
  final _resultsController = Get.find<ControllerMovieResults>();

  RxList<TvResultsModel>? getItem(String resultType) {
    switch (resultType) {
      case ApiStrings.popular:
        return _resultsController.popularTvList;
      case ApiStrings.onTheAir:
        return _resultsController.onTheAirTvList;
      default:
        break;
    }
  }

  return SizedBox(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headerTile(
          onMoreTap: () {
            _resultsController.getTvResults(resultType: resultType, page: '1');
            Get.toNamed(Routes.TV_SERIES_LIST, arguments: {
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
                                child: cardTvThumbnail(
                                    tv: getItem(resultType)![index],
                                    imageUrl:
                                        '$posterUrl${getItem(resultType)![index].posterPath}'),
                              )
                            : cardTvThumbnail(
                                tv: getItem(resultType)![index],
                                imageUrl:
                                    '$posterUrl${getItem(resultType)![index].posterPath}')),
                    buttonPagination(
                        onTap: () {
                          _resultsController.loadMoreTvResults(
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
