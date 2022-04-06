import 'package:dewa_movies/shared/constants/colors.dart';
import 'package:flutter/material.dart';

Widget headerBuilder({String? headerText}) => Text(
      headerText ?? 'headerText',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: ColorConstants.appBackground.withOpacity(0.8),
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
