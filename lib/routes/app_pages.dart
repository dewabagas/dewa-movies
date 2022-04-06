import 'package:dewa_movies/features/home/home.dart';
import 'package:dewa_movies/features/features.dart';
import 'package:dewa_movies/features/intro/intro.dart';
import 'package:dewa_movies/features/splash/splash.dart';
import 'package:dewa_movies/features/intro/screen_intro.dart';
import 'package:dewa_movies/features/movies/screen_movie_list.dart';
import 'package:dewa_movies/features/tv_series/screen_tv_detail.dart';
import 'package:dewa_movies/features/tv_series/screen_tv_list.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => ScreenSplash(),
      binding: BindingSplash(),
    ),
    GetPage(
      name: Routes.INTRO,
      page: () => ScreenIntro(),
      binding: BindingIntro(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => ScreenHome(),
      binding: BindingHome(),
    ),
    GetPage(
        name: Routes.MOVIE_LIST,
        page: () => ScreenMovieList(
              state: Get.arguments['state'],
              title: Get.arguments['title'],
              resultType: Get.arguments['resultType'],
            )),
    GetPage(
      name: Routes.MOVIE_DETAIL,
      page: () => ScreenMovieDetail(
        movieId: Get.parameters['movieId'] ?? '',
      ),
      binding: MovieDetailBinding(),
    ),
    GetPage(
        name: Routes.TV_SERIES_LIST,
        page: () => ScreenTvList(
              state: Get.arguments['state'],
              title: Get.arguments['title'],
              resultType: Get.arguments['resultType'],
            )),
    // GetPage(name: Routes.TV_SERIES_DETAIL, page: () => ScreenTvDetail(tvId: Get.parameters['movieId'] ?? '')),
    GetPage(name: Routes.TV_SERIES_DETAIL, page: () => ScreenTvDetail()),
  ];
}
