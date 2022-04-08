import 'package:dewa_movies/controllers/controller_configuration.dart';
import 'package:dewa_movies/controllers/controller_utility.dart';
import 'package:dewa_movies/features/home/controllers/controller_movie_results.dart';
import 'package:dewa_movies/features/movies/controllers/controller_movie_detail.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  AppBinding() {
    dependencies();
  }
  @override
  void dependencies() {
    Get.lazyPut(() => ControllerMovieDetail(), fenix: true);
    Get.lazyPut(() => ControllerMovieResults(), fenix: true);
    Get.lazyPut(() => ControllerUtility(), fenix: true);
    Get.lazyPut(() => ControllerConfiguration(), fenix: true);

}
}
