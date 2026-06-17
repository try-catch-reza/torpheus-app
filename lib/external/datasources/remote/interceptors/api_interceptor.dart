import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:torpheus/domain/repositories/preferenfeces/preferences_local_repository.dart';

import '../../../../../injector.dart';

class ApiInterceptor extends Interceptor {
  ApiInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.headers.isEmpty ||
        !options.headers.containsKey('Authorization')) {
      options.headers = await _getHeader();
    }

    return super.onRequest(options, handler);
  }

  Future<Map<String, String>> _getHeader() async {
    return {
      'Authorization':
          'Bearer ${getIt.get<PreferencesLocalRepository>().getAccessToken()}'
    };
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.responseType == ResponseType.plain &&
        response.statusCode != 204) {
      response.data = json.decode(response.data);
    }

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.requestOptions.responseType == ResponseType.plain) {
      try {
        err.response?.data = json.decode(err.response?.data);
      } catch (e) {
        if (kDebugMode) {
          print('ApiInterceptor >>> onError: $e');
        }
      }
    }

    return super.onError(err, handler);
  }
}
