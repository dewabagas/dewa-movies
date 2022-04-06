import 'dart:async';
import 'dart:io';

import 'package:dewa_movies/app_exceptions.dart';
import 'package:dewa_movies/shared/shared.dart';

class ServiceResults extends ServiceBase {
  Future<dynamic> getMovieResults({
    required String resultType,
    String page = "",
    String region = "",
  }) async {
    try {
      final response = await request(
        method: Requests.get,
        path: "/3/movie/$resultType",
        header: setHeaders(),
        queryParameter: setQueryParameters(query: {"page": page}),
      );
      // ignore: avoid_print
      print('$resultType MOVIE RESULTS STATUS => ${response}');
      // ignore: avoid_print
      // print('PAGE => $page');

      return decodeResponse(response)['results'];
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }

  Future<dynamic> getTvResults({
    required String resultType,
    String page = "",
  }) async {
    try {
      final response = await request(
        method: Requests.get,
        path: "/3/tv/$resultType",
        header: setHeaders(),
        queryParameter: setQueryParameters(query: {"page": page}),
      );
      // ignore: avoid_print
      // print('$resultType TV RESULTS STATUS => ${response.statusCode}');
      // ignore: avoid_print
      // print('PAGE => ${decodeResponse(response)['page']}');

      return decodeResponse(response)['results'];
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }
}
