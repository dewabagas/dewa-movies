import 'package:dewa_movies/features/movies/controllers/controller_movie_detail.dart';
import 'package:get/get.dart';

class MovieDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ControllerMovieDetail(), fenix: true);
  }
}
