import 'package:cached_network_image/cached_network_image.dart';
import 'package:dewa_movies/controllers/controller_configuration.dart';
import 'package:dewa_movies/features/movies/components/header_text.dart';
import 'package:dewa_movies/features/tv_series/models/model_tv_detail.dart';
import 'package:dewa_movies/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Widget tvInfoBuilder({required TvDetailsModel tvDetails}) {
  final String? lastAirDate = tvDetails.lastAirDate == null
      ? "-"
      : DateFormat.yMMMMd().format(tvDetails.lastAirDate!);

  final String? firstAirDate = tvDetails.firstAirDate == null
      ? "-"
      : DateFormat.yMMMMd().format(tvDetails.firstAirDate!);

  final _configurationController = Get.find<ControllerConfiguration>();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      headerBuilder(headerText: "TV Show Info"),
      const SizedBox(height: 12),
      rowBuilder(title: "English Title", text: tvDetails.name ?? "-"),
      rowBuilder(title: "Original Title", text: tvDetails.originalName ?? "-"),
      rowBuilder(title: "First Air Date", text: firstAirDate ?? "-"),
      rowBuilder(title: "Last Air Date", text: lastAirDate ?? "-"),
      rowBuilder(
          title: "Aired Episodes",
          text: '${tvDetails.numberOfEpisodes ?? "-"} Episodes'),
      rowBuilder(
          title: "Runtime",
          text:
              '${tvDetails.episodeRunTime!.isEmpty ? "-" : tvDetails.episodeRunTime![0]} mins'),
      rowBuilder(title: "Show Type", text: tvDetails.type ?? "-"),
      rowBuilder(
          title: "Original Language", text: tvDetails.originalLanguage ?? "-"),
      rowBuilder(
        title: "Production Countries",
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 4,
          runSpacing: 4,
          children: List.from(
            tvDetails.productionCountries!.map(
              (e) => e.name == null
                  ? const SizedBox.shrink()
                  : Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        // color: ColorConstants.appBackground.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        e.name ?? "",
                        style: TextStyle(
                          fontSize: 14,
                          color: ColorConstants.appBackground.withOpacity(0.7),
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
          // spacing: 2,
          runSpacing: 4,
          children: List.from(
            tvDetails.productionCompanies!.map(
              (e) => e.logoPath == null || e.logoPath!.isEmpty
                  ? SizedBox.shrink()
                  : Container(
                      margin: EdgeInsets.only(right: 4),
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      decoration: BoxDecoration(
                        color: ColorConstants.appBackground.withOpacity(0.2),
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
                color: ColorConstants.appBackground.withOpacity(0.5),
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
                    color: ColorConstants.appBackground.withOpacity(0.7),
                  ),
                ),
          ),
        ],
      ),
    );
