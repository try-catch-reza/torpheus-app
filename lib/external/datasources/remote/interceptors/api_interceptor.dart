import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:torpheus/domain/repositories/preferenfeces/preferences_local_repository.dart';

import '../../../../../injector.dart';
import '../../../../core/resources/handler_exception.dart';
import '../../../../domain/controller/authentication_controller.dart';
import '../../../../domain/controller/preferences_controller.dart';
import '../../../../presentation/screens/authentication/authentication_bloc/authentication_bloc.dart';

class ApiInterceptor extends Interceptor {
  late final Dio _client;

  ApiInterceptor(this._client);

  String get _authorization => 'Authorization';

  String get _bearer => 'Bearer';

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

    // final bool isRefreshingToken = err.requestOptions.uri
    //     .toString()
    //     .contains(EapiSchema.route(EapiRoutes.refreshToken));

    final bool isNotAuth = err.response?.statusCode == 401;

    // if (isNotAuth && !isRefreshingToken) {
    //   final String? jwtToken = await _refreshToken();
    //
    //   if (jwtToken != null) {
    //     err.requestOptions.headers[_authorization] = '$_bearer $jwtToken';
    //
    //     try {
    //       return handler.resolve(await _client.fetch(err.requestOptions));
    //     } catch (dioEx) {
    //       if (dioEx is DioException) {
    //         return handler.reject(dioEx);
    //       }
    //       return handler.next(err);
    //     }
    //   }
    // }

    return super.onError(err, handler);
  }
}
