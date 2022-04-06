import 'package:dewa_movies/features/home/controllers/controller_base.dart';
import 'package:dewa_movies/features/home/models/model_movie_result.dart';
import 'package:dewa_movies/features/tv_series/models/model_tv.dart';
import 'package:dewa_movies/shared/shared.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class ControllerMovieResults extends BaseController {
  @override
  void onInit() {
    super.onInit();

    getMovieResults(resultType: ApiStrings.popular);
    getMovieResults(resultType: ApiStrings.upcoming);
    getMovieResults(resultType: ApiStrings.nowPlaying);

    getTvResults(resultType: ApiStrings.onTheAir);
    getTvResults(resultType: ApiStrings.popular);
  }

  final _service = getIt<ServiceResults>();

  final _movieId = '0'.obs;
  final _tvId = '0'.obs;

  String get movieId => _movieId.value;
  String get tvId => _tvId.value;

  void setMovieId(String id) => _movieId.value = id;
  void setTvId(String id) => _tvId.value = id;

  var popularTvList = <TvResultsModel>[].obs;
  var topRatedTvList = <TvResultsModel>[].obs;
  var onTheAirTvList = <TvResultsModel>[].obs;
  var airingTodayTvList = <TvResultsModel>[].obs;

  var popularMovies = <MovieResultModel>[].obs;
  var topRatedMovies = <MovieResultModel>[].obs;
  var upcommingMovies = <MovieResultModel>[].obs;
  var nowPlayingMovies = <MovieResultModel>[].obs;

// tv view states
  var popularTvState = ViewState.idle.obs;
  var topRatedTvState = ViewState.idle.obs;
  var onTheAirTvState = ViewState.idle.obs;
  var airingTodayTvState = ViewState.idle.obs;

// movie view states
  var popularMoviesState = ViewState.idle.obs;
  var topRatedMoviesState = ViewState.idle.obs;
  var upcommingMoviesState = ViewState.idle.obs;
  var nowPlayingMoviesState = ViewState.idle.obs;

// movie pages
  int popularMoviesPage = 1;
  int topRatedMoviesPage = 1;
  int upcommingMoviesPage = 1;
  int nowPlayingMoviesPage = 1;

// tv pages
  int popularTvPage = 1;
  int topRatedTvPage = 1;
  int onTheAirTvPage = 1;
  int airingTodayTvPage = 1;

// method only for trending movie pagination state
  void resetMoviePage() {
    popularMoviesPage = 1;
  }

  void getMovieResults({required String resultType, String? page}) async {
    switch (resultType) {
      case ApiStrings.popular:
        popularMoviesState.value = ViewState.busy;
        popularMoviesPage = 1;
        await _service
            .getMovieResults(
                resultType: resultType, page: page ?? '$popularMoviesPage')
            .then((value) {
          if (value != null) {
            popularMovies =
                RxList.from(value.map((e) => MovieResultModel.fromJson(e)));
            popularMovies.refresh();
            popularMoviesState.value = ViewState.retrived;

            update(['movies_result']);
          }
        });
        break;
      case ApiStrings.upcoming:
        upcommingMoviesState.value = ViewState.busy;
        upcommingMoviesPage = 1;
        await _service
            .getMovieResults(
                resultType: resultType, page: page ?? '$upcommingMoviesPage')
            .then((value) {
          if (value != null) {
            upcommingMovies =
                RxList.from(value.map((e) => MovieResultModel.fromJson(e)));
            upcommingMoviesState.value = ViewState.retrived;

            update(['movies_result']);
          }
        });
        break;
      case ApiStrings.nowPlaying:
        nowPlayingMoviesState.value = ViewState.busy;
        nowPlayingMoviesPage = 1;
        await _service
            .getMovieResults(
                resultType: resultType, page: page ?? '$nowPlayingMoviesPage')
            .then((value) {
          if (value != null) {
            nowPlayingMovies =
                RxList.from(value.map((e) => MovieResultModel.fromJson(e)));
            nowPlayingMoviesState.value = ViewState.retrived;

            update(['movies_result']);
          }
        });
        break;

      default:
        break;
    }
  }

  void loadMoreMoviesResults({required String resultType}) async {
    switch (resultType) {
      case ApiStrings.popular:
        popularMoviesPage = popularMoviesPage + 1;
        popularMoviesState.value = ViewState.busy;
        await _service
            .getMovieResults(resultType: resultType, page: '$popularMoviesPage')
            .then((value) {
          if (value != null) {
            popularMovies.addAll(
                RxList.from(value.map((e) => MovieResultModel.fromJson(e))));
            popularMoviesState.value = ViewState.retrived;

            update(['movies_result']);
          }
        });
        break;
      case ApiStrings.upcoming:
        upcommingMoviesPage = upcommingMoviesPage + 1;
        upcommingMoviesState.value = ViewState.busy;
        await _service
            .getMovieResults(
                resultType: resultType, page: '$upcommingMoviesPage')
            .then((value) {
          if (value != null) {
            upcommingMovies.addAll(
                RxList.from(value.map((e) => MovieResultModel.fromJson(e))));
            upcommingMoviesState.value = ViewState.retrived;

            update(['movies_result']);
          }
        });
        break;
      case ApiStrings.nowPlaying:
        nowPlayingMoviesPage = nowPlayingMoviesPage + 1;
        nowPlayingMoviesState.value = ViewState.busy;
        await _service
            .getMovieResults(
                resultType: resultType, page: '$nowPlayingMoviesPage')
            .then((value) {
          if (value != null) {
            nowPlayingMovies.addAll(
                RxList.from(value.map((e) => MovieResultModel.fromJson(e))));
            nowPlayingMoviesState.value = ViewState.retrived;

            update(['movies_result']);
          }
        });
        break;

      default:
        break;
    }
  }

  void getTvResults({required String resultType, String? page}) async {
    switch (resultType) {
      case ApiStrings.popular:
        popularTvState.value = ViewState.busy;
        popularTvPage = 1;
        await _service
            .getTvResults(
                resultType: resultType, page: page ?? '$popularTvPage')
            .then((value) {
          if (value != null) {
            popularTvList =
                RxList.from(value.map((e) => TvResultsModel.fromJson(e)));
            popularTvList.refresh();
            popularTvState.value = ViewState.retrived;

            update(['tv_result']);
          }
        });
        break;
      case ApiStrings.onTheAir:
        onTheAirTvState.value = ViewState.busy;
        onTheAirTvPage = 1;
        await _service
            .getTvResults(
                resultType: resultType, page: page ?? '$onTheAirTvPage')
            .then((value) {
          if (value != null) {
            onTheAirTvList =
                RxList.from(value.map((e) => TvResultsModel.fromJson(e)));
            onTheAirTvState.value = ViewState.retrived;

            update(['tv_result']);
          }
        });
        break;
      default:
        break;
    }
  }

  void loadMoreTvResults({required String resultType}) async {
    switch (resultType) {
      case ApiStrings.popular:
        popularTvPage = popularTvPage + 1;
        popularTvState.value = ViewState.busy;
        await _service
            .getTvResults(resultType: resultType, page: '$popularTvPage')
            .then((value) {
          if (value != null) {
            popularTvList.addAll(
                RxList.from(value.map((e) => TvResultsModel.fromJson(e))));
            popularTvState.value = ViewState.retrived;

            update(['tv_result']);
          }
        });
        break;
      case ApiStrings.onTheAir:
        onTheAirTvPage = onTheAirTvPage + 1;
        onTheAirTvState.value = ViewState.busy;
        await _service
            .getTvResults(resultType: resultType, page: '$onTheAirTvPage')
            .then((value) {
          if (value != null) {
            onTheAirTvList.addAll(
                RxList.from(value.map((e) => TvResultsModel.fromJson(e))));
            onTheAirTvState.value = ViewState.retrived;

            update(['tv_result']);
          }
        });
        break;
      default:
        break;
    }
  }
}
