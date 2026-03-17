// Rastreio Já — TrackingRemoteDataSource
library;

import 'package:dio/dio.dart';
import 'package:rastreio_ja/core/constants/app_constants.dart';
import 'package:rastreio_ja/core/network/network_exception.dart';
import 'package:rastreio_ja/features/tracking/data/models/tracking_event_model.dart';

abstract interface class TrackingRemoteDataSource {
  Future<List<TrackingEventModel>> fetchTrackingEvents(String trackingCode);
}

class TrackingRemoteDataSourceImpl implements TrackingRemoteDataSource {
  const TrackingRemoteDataSourceImpl({required this.dio});
  final Dio dio;

  @override
  Future<List<TrackingEventModel>> fetchTrackingEvents(
    final String trackingCode,
  ) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        '/api/public/rastreio/$trackingCode',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConstants.apiKey}',
          },
        ),
      );

      final data = response.data;
      if (data == null) throw const ServerException('Resposta vazia da API');

      final sucesso = data['sucesso'] as bool? ?? false;
      if (!sucesso) {
        final tipo = data['tipo'] as String? ?? '';
        if (tipo == 'not_found') throw const NotFoundException();
        throw const ServerException('Erro desconhecido da API');
      }

      final eventos = data['eventos'] as List<dynamic>? ?? [];
      return eventos
          .map(
            (final e) => TrackingEventModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const RequestTimeoutException();
      }
      if (e.response?.statusCode == 404) throw const NotFoundException();
      if (e.response?.statusCode == 429) {
        throw const ServerException('Rate limit atingido. Tente novamente.');
      }
      throw ServerException(e.message ?? 'Erro de rede desconhecido');
    }
  }
}
