import 'package:cached_network_image/cached_network_image.dart';
import 'package:dewa_movies/controllers/controller_configuration.dart';
import 'package:dewa_movies/features/movies/components/header_text.dart';
import 'package:dewa_movies/features/movies/models/model_movie_detail.dart';
import 'package:dewa_movies/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget movieInfoBuilder({required MovieDetailsModel movieDetails}) {
  final _configurationController = Get.find<ControllerConfiguration>();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      headerBuilder(headerText: "Movie Info"),
      SizedBox(height: 12),
      rowBuilder(title: "Title", text: movieDetails.title ?? "-"),
      rowBuilder(
          title: "Original Title", text: movieDetails.originalTitle ?? "-"),
      rowBuilder(title: "Status", text: movieDetails.status ?? "-"),
      rowBuilder(title: "Runtime", text: '${movieDetails.runtime} mins'),
      rowBuilder(
          title: "Original Language",
          text: movieDetails.originalLanguage ?? "-"),
      rowBuilder(
        title: "Production Countries",
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 4,
          runSpacing: 4,
          children: List.from(
            movieDetails.productionCountries!.map(
              (e) => e.name == null
                  ? SizedBox.shrink()
                  : Container(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        // color: ColorConstants.appBackgroundDarker.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        e.name ?? "",
                        style: TextStyle(
                          fontSize: 14,
                          color: ColorConstants.appBackgroundDarker.withOpacity(0.7),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
      rowBuilder(
        title: "Companies",
        child: Wrap(
          alignment: WrapAlignment.start,
          // spacing: 4,
          runSpacing: 4,
          children: List.from(
            movieDetails.productionCompanies!.map(
              (e) => e.logoPath == null || e.logoPath!.isEmpty
                  ? SizedBox.shrink()
                  : Container(
                      margin: EdgeInsets.only(right: 4),
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      decoration: BoxDecoration(
                        color: ColorConstants.appBackgroundDarker.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CachedNetworkImage(
                          height: 40,
                          width: 40,
                          fit: BoxFit.scaleDown,
                          errorWidget: (context, url, error) => Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                ),
                                child: Icon(
                                  Icons.error,
                                  color: Colors.white,
                                ),
                              ),
                          imageUrl:
                              '${_configurationController.posterUrl}${e.logoPath}'),
                    ),
            ),
          ),
        ),
      ),
      rowBuilder(title: "Budget", text: '\$${movieDetails.budget}'),
      rowBuilder(title: "Revenue", text: '\$${movieDetails.revenue}'),
    ],
  );
}

// helper row
Widget rowBuilder({required String title, String? text, Widget? child}) =>
    Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: ColorConstants.appBackgroundDarker.withOpacity(0.5),
              ),
            ),
          ),
          SizedBox(width: 6),
          Expanded(
            flex: 5,
            child: child ??
                Text(
                  text ?? "-",
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConstants.appBackgroundDarker.withOpacity(0.7),
                  ),
                ),
          ),
        ],
      ),
    );
