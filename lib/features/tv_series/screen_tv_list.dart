import 'package:dewa_movies/controllers/controller_configuration.dart';
import 'package:dewa_movies/features/home/controllers/controller_base.dart';
import 'package:dewa_movies/features/home/controllers/controller_movie_results.dart';
import 'package:dewa_movies/features/tv_series/models/model_tv.dart';
import 'package:dewa_movies/shared/constants/strings.dart';
import 'package:dewa_movies/shared/helpers/helper_widget_builder.dart';
import 'package:dewa_movies/shared/shared.dart';
import 'package:dewa_movies/shared/widgets/cards/card_tv_thumbnail.dart';
import 'package:dewa_movies/shared/widgets/loaders/loader_spinner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenTvList extends StatelessWidget {
  // final List<TvResultsModel> tv;
  final String? title;
  final String resultType;
  final Rx<ViewState> state;

  ScreenTvList({
    required this.state,
    required this.resultType,
    Key? key,
    this.title,
  }) : super(key: key);

  final _configurationController = Get.find<ControllerConfiguration>();
  final _resultsController = Get.find<ControllerMovieResults>();

  List<TvResultsModel>? getItem(String resultType) {
    switch (resultType) {
      case ApiStrings.popular:
        return _resultsController.popularTvList;
      case ApiStrings.onTheAir:
        return _resultsController.onTheAirTvList;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _resultsController.getTvResults(resultType: resultType, page: '1');
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
                id: 'tv_result',
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
                      gridDelegate:
                         SliverGridDelegateWithFixedCrossAxisCount(
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
                        child: cardTvThumbnail(
                          padding: EdgeInsets.all(0),
                          tv: getItem(resultType)![index],
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
