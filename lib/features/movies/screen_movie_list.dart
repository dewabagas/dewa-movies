import 'package:dewa_movies/controllers/controller_configuration.dart';
import 'package:dewa_movies/features/home/controllers/controller_base.dart';
import 'package:dewa_movies/features/home/controllers/controller_movie_results.dart';
import 'package:dewa_movies/features/home/models/model_movie_result.dart';
import 'package:dewa_movies/shared/constants/strings.dart';
import 'package:dewa_movies/shared/helpers/helper_widget_builder.dart';
import 'package:dewa_movies/shared/shared.dart';
import 'package:dewa_movies/shared/widgets/cards/card_movie_thumbnail.dart';
import 'package:dewa_movies/shared/widgets/loaders/loader_spinner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenMovieList extends StatelessWidget {
  final String? title;
  final String resultType;
  final Rx<ViewState> state;

  ScreenMovieList({
    required this.state,
    required this.resultType,
    Key? key,
    this.title,
  }) : super(key: key);

  final _configurationController = Get.find<ControllerConfiguration>();
  final _resultsController = Get.find<ControllerMovieResults>();

  List<MovieResultModel>? getItem(String resultType) {
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _resultsController.getMovieResults(resultType: resultType, page: '1');
        Get.back();
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(useLeading: true, title: title ?? 'title',),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 28),
              GetBuilder(
                id: 'movies_result',
                init: _resultsController,
                builder: (controller) {
                  return HelperWidgetBuilder(
                    state: state.value,
                    onLoadingBuilder: LoaderSpinner().fadingCircleSpinner,
                    onSuccessBuilder: GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: getItem(resultType) == null
                          ? 0
                          : getItem(resultType)!.length,
                      semanticChildCount: getItem(resultType) == null
                          ? 0
                          : getItem(resultType)!.length,
                      cacheExtent: 2400,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        mainAxisExtent: 186,
                      ),
                      itemBuilder: (context, index) => AbsorbPointer(
                        absorbing: getItem(resultType)![index].posterPath !=
                                    null ||
                                getItem(resultType)![index].posterPath != ""
                            ? false
                            : true,
                        child: cardMovieThumbnail(
                          padding: EdgeInsets.all(0),
                          movie: getItem(resultType)![index],
                          imageUrl:
                              '${_configurationController.posterUrl}${getItem(resultType)![index].posterPath}',
                        ),
                      ),
                    ),
                    onErrorBuilder: Center(
                      child: Text(Applications.errorLoad),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
