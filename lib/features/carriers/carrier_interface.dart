// Rastreio Já — Interface base para transportadoras
library;

import 'package:rastreio_ja/features/tracking/domain/entities/tracking_event_entity.dart';

abstract interface class CarrierInterface {
  /// Identificador único da transportadora (ex: 'correios')
  String get id;

  /// Nome exibido na UI (ex: 'Correios')
  String get displayName;

  /// Valida se o código pertence a esta transportadora
  bool validateCode(final String code);

  /// Busca os eventos de rastreamento
  Future<List<TrackingEventEntity>> fetchTracking(final String code);
}

/// Utilitário para detectar transportadora pelo código
abstract final class CarrierDetector {
  static const _correiosRegex = r'^[A-Z]{2}[0-9]{9}[A-Z]{2}$';

  /// Retorna o id da transportadora detectada ou 'unknown'
  static String detect(final String code) {
    final upper = code.toUpperCase().trim();
    if (RegExp(_correiosRegex).hasMatch(upper)) return 'correios';
    return 'unknown';
  }

  /// Retorna true se o código é válido para qualquer transportadora suportada
  static bool isValid(final String code) => detect(code) != 'unknown';
}
