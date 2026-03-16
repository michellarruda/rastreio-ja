// Rastreio Já — Interface base para transportadoras
library;

import 'package:rastreio_ja/features/tracking/domain/entities/tracking_event_entity.dart';

abstract interface class CarrierInterface {
  String get id;
  String get displayName;
  bool validateCode(final String code);
  Future<List<TrackingEventEntity>> fetchTracking(final String code);
}
