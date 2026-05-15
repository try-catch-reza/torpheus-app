import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../models/api_error_model.dart';

abstract class HttpClient {
  late final Dio client;
}

class HttpRequestException implements Exception {
  /// [infoMessage] Mensagem com informações adicionais sobre o erro
  /// [titleMessage] Titulo do erro, intuitivo para o usuário
  /// [Response] Erros que aconteceram na api e retornaram pelo cliente
  HttpRequestException({
    this.response,
    required String titleMessage,
    required String infoMessage,
  }) {
    _infoMessage = infoMessage;
    _titleMessage = titleMessage;
  }

  late final String _infoMessage;
  late final String _titleMessage;
  late final Response? response;

  Map<String, dynamic>? _responseToMap(dynamic data) {
    if (data == null) return null;

    // Dio já parseou para Map
    if (data is Map<String, dynamic>) return data;

    // Dio retornou Map genérico
    if (data is Map) return Map<String, dynamic>.from(data);

    // Chegou como String bruta (acontece quando responseType não é json)
    if (data is String && data.isNotEmpty) {
      try {
        final decoded = jsonDecode(data);
        if (decoded is Map) return Map<String, dynamic>.from(decoded);
      } catch (_) {}
    }

    return null;
  }

  String? get _apiErrorMessage {
    if (response != null && response?.data != null) {
      try {
        final map = _responseToMap(response?.data);
        if (map != null) {
          // campos customizados do BaseRemoteDataSource
          if (map['processo'] != null) return map['processo'];
          if (map['msg_erro'] != null) return map['msg_erro'];

          final api = ApiErrorModel.fromJson(map);

          if (api.detail != null && api.detail!.isNotEmpty) return api.detail;
          if (api.errors != null && api.errors!.isNotEmpty) {
            return api.errors!
                .map((e) => e.message ?? e.code ?? '')
                .where((m) => m.isNotEmpty)
                .join('\n');
          }
          if (api.title != null && api.title!.isNotEmpty) return api.title;
        }
      } catch (e) {
        if (kDebugMode) print('Erro ao parsear response: $e');
      }
    }
    return null;
  }

  String? get _apiErrorTitle {
    if (response != null && response?.data != null) {
      try {
        final map = _responseToMap(response?.data);
        if (map != null) {
          final api = ApiErrorModel.fromJson(map);
          if (api.title != null && api.title!.isNotEmpty) return api.title;
        }
      } catch (e) {
        if (kDebugMode) {
          print(
            '=====/=====/=====/=====/=====/=====/=====/=====/=====/=====/====='
                'Falha ao converter mensagem de erro para model: TITLE'
                '\n$e\n'
                '=====/=====/=====/=====/=====/=====/=====/=====/=====/=====/=====',
          );
        }
      }
    }
    return null;
  }

  String get message {
    if (_apiErrorMessage != null) {
      return _apiErrorMessage!;
    }

    return _infoMessage;
  }

  String get title {
    if (_apiErrorTitle != null) {
      return _apiErrorTitle!;
    }

    return _titleMessage;
  }

  @override
  String toString() {
    return 'HttpRequestException{'
        '_infoMessage: $_infoMessage, '
        '_titleMessage: $_titleMessage, '
        'response: $response'
        '}';
  }
}