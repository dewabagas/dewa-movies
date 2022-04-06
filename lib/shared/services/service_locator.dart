
import 'package:dewa_movies/features/movies/service_movie_detail.dart';
import 'package:dewa_movies/shared/shared.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void setUp() {
  getIt.registerLazySingleton<ServiceConfiguration>(() => ServiceConfiguration());
  getIt.registerLazySingleton<ServiceResults>(() => ServiceResults());
  getIt.registerLazySingleton<ServiceMovieDetail>(() => ServiceMovieDetail());
}