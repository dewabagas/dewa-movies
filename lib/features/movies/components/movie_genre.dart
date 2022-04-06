import 'package:dewa_movies/features/movies/components/header_text.dart';
import 'package:dewa_movies/features/movies/models/model_movie_base.dart';
import 'package:dewa_movies/shared/constants/colors.dart';
import 'package:flutter/material.dart';

Widget genreBuilder({required List<Genre> genres}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      headerBuilder(headerText: "Genre"),
      SizedBox(height: 8),
      Wrap(
        spacing: 4,
        runSpacing: 6,
        runAlignment: WrapAlignment.start,
        children: List.from(
          genres.map(
            (e) => Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: ColorConstants.appBackground.withOpacity(0.2),
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
    ],
  );
}
