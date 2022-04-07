import 'package:cached_network_image/cached_network_image.dart';
import 'package:dewa_movies/features/home/controllers/controller_movie_results.dart';
import 'package:dewa_movies/features/home/models/model_movie_result.dart';
import 'package:dewa_movies/routes/routes.dart';
import 'package:dewa_movies/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget cardMovieThumbnail({
  required MovieResultModel movie,
  required String imageUrl,
  EdgeInsetsGeometry? padding,
  void Function()? onTap,
}) {
  final _controller = Get.find<ControllerMovieResults>();

  return GestureDetector(
    onTap: () {
      print('movie id di thumbnail : ${movie.id}');
      _controller.setMovieId('${movie.id!}');

      Get.offAllNamed(Routes.MOVIE_DETAIL,
          parameters: {"movieId": _controller.movieId});
    },
    child: SizedBox(
      width: 100,
      height: 186,
      child: Column(
        children: [
          Container(
            padding: padding ?? EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: movie.posterPath == null
                      ? Container(
                          alignment: Alignment.center,
                          width: 94,
                          height: 140,
                          color: Colors.black12,
                          child: Icon(
                            Icons.error_outline,
                            color: Colors.white,
                            size: 34,
                          ),
                        )
                      : CachedNetworkImage(
                          width: 94,
                          height: 140,
                          fit: BoxFit.fill,
                          imageUrl: imageUrl,
                          placeholder: (context, url) => Container(
                            color: Colors.black12,
                          ),
                        ),
                ),
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    padding: padding ?? EdgeInsets.fromLTRB(6, 0, 6, 0),
                    decoration: BoxDecoration(
                      color: ColorConstants.appBackground.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${movie.voteAverage}',
                      style: TextStyle(fontSize: 11, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // movie title and option
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    movie.title ?? "Title",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      // letterSpacing: 0.2,
                      color: ColorConstants.appBackground,
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: onTap,
                //   child: const Icon(
                //     Icons.more_vert,
                //     color: ColorConstants.appBackgroundBlue,
                //     size: 18,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
