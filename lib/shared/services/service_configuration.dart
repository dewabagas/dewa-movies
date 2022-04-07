import 'dart:async';
import 'dart:io';

import 'package:dewa_movies/app_exceptions.dart';
import 'package:dewa_movies/shared/shared.dart';

class ServiceConfiguration extends ServiceBase {
  Future<dynamic> getConfiguration() async {
    try {
      await request(
          method: Requests.get,
          path: "/3/configuration",
          header: setHeaders(),
          queryParameter: setQueryParameters());

      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }
}
