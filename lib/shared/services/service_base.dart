import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dewa_movies/app_exceptions.dart';
import 'package:http/http.dart' as http;

enum Requests { get, post, put, delete, update }

String baseUrl = "api.themoviedb.org";

class ServiceBase {
  final client = http.Client();
  late http.Response response;
  final _timeOutDuration = 30;

  String api = "e8efbfcd26030a98002bee53bca852eb";

  late Map<String, String> queryParma;

  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json;charset=utf-8',
    HttpHeaders.authorizationHeader:
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYTVlYmVmNThiMDhhZDgyNWYyNDU5MTg2MGIyNjk5MCIsInN1YiI6IjYwYTM1OTI2NzMxNGExMDA3OGZjZTRkOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VJG0GMDEpcYQBtm5VZlCHEmqTY5jH4kfIkYhosKqOA0"
  };

  Map<String, String> setHeaders({Map<String, String>? header}) {
    headers.addAll(header ?? {});
    return headers;
  }

  Map<String, String> setQueryParameters({Map<String, String>? query}) {
    queryParma = {"api_key": api};
    queryParma.addAll(query ?? {});
    
    return queryParma;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response;

      case 400:
        throw BadRequestException(jsonDecode(jsonEncode(response.body)));
      // return response;

      case 401:
      case 403:
        // throw UnauthorizedException(jsonDecode(jsonEncode(response.body)));
        return response;

      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communicating with Server with StatusCode: ${response.statusCode}\nRESPONSE:${decodeResponse(response)}');
      // return response;
    }
  }

  Future<http.Response> request({
    required Requests method,
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? queryParameter,
    Map<String, String>? header,
  }) async {
    // setQueryParameters();
    switch (method) {
      case Requests.get:
        response = await client
            .get(
              Uri.https(
                  baseUrl, path, queryParameter ?? setQueryParameters()),
              headers: header ?? headers,
            )
            .timeout(Duration(seconds: _timeOutDuration));
        break;
      case Requests.post:
        response = await client
            .post(
              Uri.https(
                  baseUrl, path, queryParameter ?? setQueryParameters()),
              headers: header ?? headers,
              body: jsonEncode(body ?? {}),
            )
            .timeout(Duration(seconds: _timeOutDuration));
        break;
      case Requests.delete:
        response = await client
            .delete(
              Uri.https(
                  baseUrl, path, queryParameter ?? setQueryParameters()),
              headers: header ?? headers,
              body: jsonEncode(body ?? {}),
            )
            .timeout(Duration(seconds: _timeOutDuration));
        break;

      default:
        break;
    }

    return returnResponse(response);
  }

  //decodes response from string to json object
  dynamic decodeResponse(http.Response response) {
    return jsonDecode(utf8.decode(response.bodyBytes));
  }
}