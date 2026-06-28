import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../data/datasources/remote/http_client.dart';

typedef HttpResponse<T> = T Function(Response response);

abstract class BaseRemoteDataSource<T> {
  late final HttpClient _httpClient;

  BaseRemoteDataSource(HttpClient httpClient) {
    _httpClient = httpClient;
  }

  Future<T> get({
    required String path,
    Map<String, String>? customHeader,
    Map<String, String>? queryParameters,
    ResponseType responseType = ResponseType.plain,
    required HttpResponse<T> response,
    required String titleMessage,
  }) async {
    try {
      final Response res = await _httpClient.client.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: customHeader,
          responseType: responseType,
        ),
      );
      return response(res);
    } on HttpRequestException catch (e, stt) {
      _printErrorLog(e, stt);
      rethrow;
    } on DioException catch (e, stt) {
      _printErrorLog(e, stt);

      final String errorMessage = requestErrorTitle(
        titleMessage,
        e.requestOptions,
      );

      throw HttpRequestException(
        response: dioError(e, errorMessage),
        infoMessage: e.toString(),
        titleMessage: errorMessage,
      );
    } catch (e, stt) {
      _printErrorLog(e, stt);
      throw HttpRequestException(
        infoMessage: e.toString(),
        titleMessage: titleMessage,
      );
    }
  }

  Future<T> post({
    required String path,
    dynamic body,
    Map<String, String>? customHeader,
    required HttpResponse<T> response,
    required String titleMessage,
    ResponseType responseType = ResponseType.plain,
  }) async {
    try {
      final res = await _httpClient.client.post(
        path,
        data: body,
        options: Options(headers: customHeader, responseType: responseType),
      );

      return response(res);
    } on HttpRequestException catch (e, stt) {
      _printErrorLog(e, stt);
      rethrow;
    } on DioException catch (e, stt) {
      _printErrorLog(e, stt);
      final String errorMessage = requestErrorTitle(
        titleMessage,
        e.requestOptions,
      );
      throw HttpRequestException(
        response: dioError(e, errorMessage),
        infoMessage: e.toString(),
        titleMessage: errorMessage,
      );
    } catch (e, stt) {
      _printErrorLog(e, stt);
      throw HttpRequestException(
        infoMessage: e.toString(),
        titleMessage: titleMessage,
      );
    }
  }

  Future<T> patch({
    required String path,
    dynamic body,
    Map<String, String>? customHeader,
    required HttpResponse<T> response,
    required String titleMessage,
  }) async {
    try {
      final res = await _httpClient.client.patch(
        path,
        data: body,
        options: Options(headers: customHeader),
      );

      return response(res);
    } on HttpRequestException catch (e, stt) {
      _printErrorLog(e, stt);
      rethrow;
    } on DioException catch (e, stt) {
      _printErrorLog(e, stt);
      final String errorMessage = requestErrorTitle(
        titleMessage,
        e.requestOptions,
      );
      throw HttpRequestException(
        response: dioError(e, errorMessage),
        infoMessage: e.toString(),
        titleMessage: titleMessage,
      );
    } catch (e, stt) {
      _printErrorLog(e, stt);
      throw HttpRequestException(
        infoMessage: e.toString(),
        titleMessage: titleMessage,
      );
    }
  }

  Future<T> put({
    required String path,
    dynamic body,
    Map<String, String>? customHeader,
    required HttpResponse<T> response,
    required String titleMessage,
  }) async {
    try {
      final res = await _httpClient.client.put(
        path,
        data: body,
        options: Options(headers: customHeader),
      );

      return response(res);
    } on HttpRequestException catch (e, stt) {
      _printErrorLog(e, stt);
      rethrow;
    } on DioException catch (e, stt) {
      _printErrorLog(e, stt);
      final String errorMessage = requestErrorTitle(
        titleMessage,
        e.requestOptions,
      );
      throw HttpRequestException(
        response: dioError(e, errorMessage),
        infoMessage: e.toString(),
        titleMessage: titleMessage,
      );
    } catch (e, stt) {
      _printErrorLog(e, stt);
      throw HttpRequestException(
        infoMessage: e.toString(),
        titleMessage: titleMessage,
      );
    }
  }

  Future<T> delete({
    required String path,
    dynamic body,
    Map<String, String>? customHeader,
    required HttpResponse<T> response,
    required String titleMessage,
  }) async {
    try {
      final res = await _httpClient.client.delete(
        path,
        data: body,
        options: Options(headers: customHeader),
      );

      return response(res);
    } on HttpRequestException catch (e, stt) {
      _printErrorLog(e, stt);
      rethrow;
    } on DioException catch (e, stt) {
      _printErrorLog(e, stt);
      final String errorMessage = requestErrorTitle(
        titleMessage,
        e.requestOptions,
      );
      throw HttpRequestException(
        response: dioError(e, errorMessage),
        infoMessage: e.toString(),
        titleMessage: titleMessage,
      );
    } catch (e, stt) {
      _printErrorLog(e, stt);
      throw HttpRequestException(
        infoMessage: e.toString(),
        titleMessage: titleMessage,
      );
    }
  }

  void _printErrorLog(Object? exception, StackTrace stackTrace) {
    if (kDebugMode) {
      print('#####/##### HttpRequestException #####/#####');
      print('$stackTrace');
      print('$exception');
      print('#####/#####/#####/#####/#####/#####/#####');
    }
  }

  Map<String, String> basicHeader(String cpf, String password) {
    return {
      'Authorization': 'Basic ${base64.encode(utf8.encode('$cpf:$password'))}'
    };
  }

  Map<String, String> bearerHeader(token) => {'Authorization': 'Bearer $token'};

  Response? dioError(DioException dioError, String titleMessage) {
    const String genericMessage = 'verifique sua conexão com a internet ou '
        'tente novamente mais tarde';

    switch (dioError.type) {
      case DioExceptionType.connectionError:
        return _dioResponseProcesso(
          dioError.requestOptions,
          statusCode: 503,
          message: '$titleMessage\nErro de conexão. '
              'Verifique sua conexão com a internet e tente novamente.',
        );
      case DioExceptionType.connectionTimeout:
        return _dioResponse(
          dioError.requestOptions,
          statusCode: 408,
          message: '$titleMessage\n'
              'Connect Timeout\n'
              'O tempo de conexão com o servidor excedeu 1 minuto, '
              '$genericMessage',
        );
      case DioExceptionType.sendTimeout:
        return _dioResponse(
          dioError.requestOptions,
          statusCode: 408,
          message: '$titleMessage\n'
              'Send Timeout\n'
              'O tempo de envio dos dados ao servidor excedeu 1 minuto, '
              '$genericMessage',
        );
      case DioExceptionType.receiveTimeout:
        return _dioResponse(
          dioError.requestOptions,
          statusCode: 408,
          message: '$titleMessage\n'
              'Receive Timeout\n'
              'O tempo de espera da resposta do servidor excedeu 1 minuto, '
              '$genericMessage',
        );
      default:
        return _dioResponseStatusCode(dioError, titleMessage);
    }
  }

  Response? _dioResponseStatusCode(DioException dioEx, String titleMessage) {
    return switch (dioEx.response?.statusCode) {
      404 => _dioResponseProcesso(
          dioEx.requestOptions,
          statusCode: 404,
          message: '$titleMessage\n'
              'Conteúdo não encontrado. Parece que o recurso que você está '
              'buscando não está disponível.',
        ),
      500 => _dioResponseProcesso(
          dioEx.requestOptions,
          statusCode: 500,
          message: '$titleMessage\n'
              'Ocorreu um erro no servidor. '
              'Tente novamente mais tarde.',
        ),
      400 => dioEx.response ??
          _dioResponseProcesso(
            dioEx.requestOptions,
            statusCode: 400,
            message: '$titleMessage\n'
                'Algo deu errado na consulta dos dados. '
                'Tente novamente em instantes.',
          ),
      401 => dioEx.response ??
          _dioResponseProcesso(
            // ← prioriza o response original
            dioEx.requestOptions,
            statusCode: 401,
            message: '$titleMessage\nOps! Sua sessão expirou...',
          ),
      _ => dioEx.response,
    };
  }

  String requestErrorTitle(String title, RequestOptions requestOptions) {
    final baseUrl = requestOptions.baseUrl;
    return "$title\nRequisição realizada para $baseUrl";
  }

  String findBaseUrl(RequestOptions requestOptions) {
    final List<String> listPath = requestOptions.path.split('/');

    final maxSplit = listPath.length < 4 ? listPath.length : 4;
    String path = "";
    for (int i = 0; i < maxSplit; ++i) {
      path += listPath[i];
    }

    return path;
  }

  String get statusCodeUnexpected {
    return 'Ops, houve um problema ao resolver os dados da requisição, '
        'código de status diferente do esperado, '
        'entre em contato com a área responsável.';
  }

  Response _dioResponse(
    RequestOptions requestOptions, {
    required int? statusCode,
    required String message,
  }) =>
      Response(
        requestOptions: requestOptions,
        statusCode: statusCode,
        data: {'msg_erro': message},
      );

  Response _dioResponseProcesso(
    RequestOptions requestOptions, {
    required int statusCode,
    required String message,
  }) {
    return Response(
      requestOptions: requestOptions,
      statusCode: statusCode,
      data: {'processo': message},
    );
  }
}
