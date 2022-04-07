import 'dart:convert';

import 'package:dewa_movies/features/home/controllers/controller_base.dart';
import 'package:dewa_movies/features/home/models/model_movie_result.dart';
import 'package:dewa_movies/features/movies/models/model_movie_base.dart';
import 'package:dewa_movies/features/movies/models/model_movie_detail.dart';
import 'package:dewa_movies/features/tv_series/models/model_tv_detail.dart';
import 'package:dewa_movies/shared/constants/constants.dart';
import 'package:dewa_movies/features/movies/service_movie_detail.dart';
import 'package:dewa_movies/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControllerMovieDetail extends BaseController {
  final _service = getIt<ServiceMovieDetail>();

  var movieDetailState = ViewState.idle.obs;
  var tvDetailState = ViewState.idle.obs;

  var creditsState = ViewState.idle.obs;
  var imagesState = ViewState.idle.obs;
  var videosState = ViewState.idle.obs;
  var similarState = ViewState.idle.obs;
  var recommendedState = ViewState.idle.obs;
  var accountstateState = ViewState.idle.obs;
  var reviewsState = ViewState.idle.obs;
  var externalIdsState = ViewState.idle.obs;
  var collectionsDetailsState = ViewState.idle.obs;

  var rateState = ViewState.idle.obs;

  var movieDetail = MovieDetailsModel().obs;
  var tvDetail = TvDetailsModel().obs;

  var credits = Credits().obs;
  var reviews = Reviews().obs;
  var images = Images().obs;
  var videos = Videos().obs;

  var movieCollections = <MovieResultModel>[].obs;

  var similarMovie = SimilarMovie().obs;
  // var similarTv = SimilarTv().obs;
  var recommendedMovie = MovieRecommendations().obs;
  // var recommendedTv = TvRecommendations().obs;
  var movieExternalIds = MovieExternalIds().obs;
  // var tvExternalIds = TvExternalIds().obs;
  var accountState = AccountStates().obs;

  var isRated = false.obs;
  var rateValue = 0.0.obs;
  var rateQuote = ''.obs;

  var mediaPageCount = 1.obs;

  void setMediaPageCount(int count) => mediaPageCount.value = count;

  // set / reset rate value
  void setRateValue(double value) =>
      rateValue.value = value < 0.5 ? 0.5 : value;
  void resetRateValue() => rateValue.value = 0.0;

  // set rate quotes
  void setRateQuote(value) => rateQuote.value = value;

// movie/tv basic details
  void getDetails({required String resultType, required String id}) async {
    print('movie id getDetails : ${id}');
    switch (resultType) {
      case ApiStrings.movie:
        movieDetailState.value = ViewState.busy;
        await _service.getDetails(resultType: resultType, id: id).then((value) {
          movieDetail.value = MovieDetailsModel.fromJson(value);
          print('${movieDetail.value.title} MOVIE DETAILS');
          movieDetailState.value = ViewState.retrived;
          update(['movie_about', 'movie_details']);
          // }
        });
        break;

      case ApiStrings.tv:
        tvDetailState.value = ViewState.busy;
        await _service.getDetails(resultType: resultType, id: id).then((value) {
          // if (value != null) {
          tvDetail.value = TvDetailsModel.fromJson(value);
          // ignore: avoid_print
          // print('${tvDetail.value.name} TV DETAILS');
          tvDetailState.value = ViewState.retrived;
          update(['tv_about', 'tv_details']);
          // }
        });
        break;
      default:
        break;
    }
  }

  void getOtherDetails({
    required String resultType,
    required String id,
    required String appendTo,
  }) async {
    print("resultType : ${resultType}, movieId : ${id}, appendTo ${appendTo}");
    switch (resultType) {
      case ApiStrings.movie:
        switch (appendTo) {
          case ApiStrings.images:
            imagesState.value = ViewState.busy;
            await _service
                .getOtherDetails(
                    resultType: resultType, id: id, appendTo: appendTo)
                .then((value) {
                  print("value nya");
                  print(value.toString());
              // if (value != null) {
              images.value = Images.fromJson(value);
              imagesState.value = ViewState.retrived;
              update(['imageSlider', 'movie_media']);
              // }
            });
            break;
          case ApiStrings.credits:
            creditsState.value = ViewState.busy;
            await _service
                .getOtherDetails(
                    resultType: resultType, id: id, appendTo: appendTo)
                .then((value) {
              // if (value != null) {
              credits.value = Credits.fromJson(value);
              creditsState.value = ViewState.retrived;
              update(['movie_cast', 'movie_crews']);
              // }
            });
            break;
          case ApiStrings.reviews:
            reviewsState.value = ViewState.busy;
            await _service
                .getOtherDetails(
                    resultType: resultType, id: id, appendTo: appendTo)
                .then((value) {
              // if (value != null) {
              reviews.value = Reviews.fromJson(value);
              reviewsState.value = ViewState.retrived;
              update(['movie_reviews']);
              // }
            });
            break;
          default:
            break;
        }
        break;

      case ApiStrings.tv:
        switch (appendTo) {
          case ApiStrings.images:
            imagesState.value = ViewState.busy;
            await _service
                .getOtherDetails(
                    resultType: resultType, id: id, appendTo: appendTo)
                .then((value) {
              // if (value != null) {
              images.value = Images.fromJson(value);
              imagesState.value = ViewState.retrived;
              update(['imageSlider', 'tv_media']);
              // }
            });
            break;
          case ApiStrings.credits:
            creditsState.value = ViewState.busy;
            await _service
                .getOtherDetails(
                    resultType: resultType, id: id, appendTo: appendTo)
                .then((value) {
              // if (value != null) {
              credits.value = Credits.fromJson(value);
              creditsState.value = ViewState.retrived;
              update(['tv_cast', 'tv_crews']);
              // }
            });
            break;
          case ApiStrings.reviews:
            reviewsState.value = ViewState.busy;
            await _service
                .getOtherDetails(
                    resultType: resultType, id: id, appendTo: appendTo)
                .then((value) {
              // if (value != null) {
              reviews.value = Reviews.fromJson(value);
              reviewsState.value = ViewState.retrived;
              update(['tv_reviews']);
              // }
            });
            break;
          default:
            break;
        }
        break;
      default:
        break;
    }
  }
}
