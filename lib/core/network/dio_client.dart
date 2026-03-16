// Rastreio Já — Cliente HTTP (Dio) com interceptors
library;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rastreio_ja/core/constants/app_constants.dart';
import 'package:rastreio_ja/core/network/network_exception.dart';

/// Cria e configura a instância global do Dio com:
/// - Timeout padrão
/// - Interceptor de log (apenas em debug)
/// - Interceptor de tratamento de erros
/// - Interceptor de retry (até [AppConstants.apiRetryAttempts] tentativas)
Dio createDioClient() {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.apiBaseUrl,
      connectTimeout: const Duration(milliseconds: AppConstants.apiTimeout),
      receiveTimeout: const Duration(milliseconds: AppConstants.apiTimeout),
      headers: const {'Content-Type': 'application/json'},
    ),
  );

  if (kDebugMode) {
    dio.interceptors.add(_LogInterceptor());
  }

  dio.interceptors.add(_ErrorInterceptor());
  dio.interceptors.add(_RetryInterceptor(dio));

  return dio;
}

// -------------------------------------------------------
// Log Interceptor
// -------------------------------------------------------
class _LogInterceptor extends Interceptor {
  @override
  void onRequest(
    final RequestOptions options,
    final RequestInterceptorHandler handler,
  ) {
    debugPrint('[DIO] --> ${options.method} ${options.uri}');
    if (options.data != null) {
      debugPrint('[DIO] Body: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(
    final Response<dynamic> response,
    final ResponseInterceptorHandler handler,
  ) {
    debugPrint(
      '[DIO] <-- ${response.statusCode} ${response.requestOptions.uri}',
    );
    handler.next(response);
  }

  @override
  void onError(
    final DioException err,
    final ErrorInterceptorHandler handler,
  ) {
    debugPrint(
      '[DIO] ERROR ${err.response?.statusCode} ${err.requestOptions.uri}',
    );
    debugPrint('[DIO] Message: ${err.message}');
    handler.next(err);
  }
}

// -------------------------------------------------------
// Error Interceptor — converte DioException em NetworkException
// -------------------------------------------------------
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(
    final DioException err,
    final ErrorInterceptorHandler handler,
  ) {
    final networkException = switch (err.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout =>
        const RequestTimeoutException(),
      DioExceptionType.connectionError => const NoInternetException(),
      DioExceptionType.badResponse => switch (err.response?.statusCode) {
          404 => const NotFoundException(),
          _ => ServerException(
              err.response?.statusMessage ?? 'Erro desconhecido',
            ),
        },
      _ => ServerException(err.message ?? 'Erro desconhecido'),
    };

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: networkException,
        message: networkException.message,
        type: err.type,
        response: err.response,
      ),
    );
  }
}

// -------------------------------------------------------
// Retry Interceptor — retenta requisições com falha de conexão
// -------------------------------------------------------
class _RetryInterceptor extends Interceptor {
  _RetryInterceptor(this._dio);

  final Dio _dio;
  final int _maxRetries = AppConstants.apiRetryAttempts;

  @override
  Future<void> onError(
    final DioException err,
    final ErrorInterceptorHandler handler,
  ) async {
    final attempt = err.requestOptions.extra['retryCount'] as int? ?? 0;

    final shouldRetry = attempt < _maxRetries &&
        (err.type == DioExceptionType.connectionError ||
            err.type == DioExceptionType.connectionTimeout);

    if (!shouldRetry) {
      handler.next(err);
      return;
    }

    debugPrint(
      '[DIO] Retry ${attempt + 1}/$_maxRetries: ${err.requestOptions.uri}',
    );

    await Future<void>.delayed(Duration(seconds: attempt + 1));

    final options = err.requestOptions..extra['retryCount'] = attempt + 1;

    try {
      final response = await _dio.fetch<dynamic>(options);
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    }
  }
}
