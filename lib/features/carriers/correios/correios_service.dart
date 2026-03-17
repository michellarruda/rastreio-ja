// Rastreio Já — Transportadora: Correios
library;

import 'package:dio/dio.dart';
import 'package:rastreio_ja/core/constants/app_constants.dart';
import 'package:rastreio_ja/core/network/network_exception.dart';
import 'package:rastreio_ja/features/carriers/carrier_interface.dart';
import 'package:rastreio_ja/features/tracking/domain/entities/tracking_event_entity.dart';

class CorreiosService implements CarrierInterface {
  const CorreiosService({required this.dio});
  final Dio dio;

  @override
  String get id => 'correios';

  @override
  String get displayName => 'Correios';

  @override
  bool validateCode(final String code) {
    final regex = RegExp(r'^[A-Z]{2}[0-9]{9}[A-Z]{2}$');
    return regex.hasMatch(code.toUpperCase().trim());
  }

  @override
  Future<List<TrackingEventEntity>> fetchTracking(
    final String code,
  ) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        '/api/public/rastreio/${code.toUpperCase().trim()}',
        options: Options(
          headers: {'Authorization': 'Bearer ${AppConstants.apiKey}'},
        ),
      );

      final data = response.data;
      if (data == null) throw const ServerException('Resposta vazia');

      final sucesso = data['sucesso'] as bool? ?? false;
      if (!sucesso) throw const NotFoundException();

      final eventos = data['eventos'] as List<dynamic>? ?? [];
      return eventos.map((final e) {
        final map = e as Map<String, dynamic>;
        return TrackingEventEntity(
          description: map['descricao'] as String? ?? '',
          location: map['local'] as String? ?? '',
          timestamp:
              DateTime.tryParse(map['data'] as String? ?? '') ?? DateTime.now(),
          detail: map['detalhe'] as String?,
        );
      }).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) throw const NotFoundException();
      throw ServerException(e.message ?? 'Erro de rede');
    }
  }
}
