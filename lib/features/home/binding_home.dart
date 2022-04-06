import 'package:dewa_movies/features/home/controllers/controller_movie_results.dart';
import 'package:get/get.dart';

import 'controller_home.dart';

class BindingHome implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerHome>(() => ControllerHome());
    Get.lazyPut(() => ControllerMovieResults(), fenix: true);
  }
}
