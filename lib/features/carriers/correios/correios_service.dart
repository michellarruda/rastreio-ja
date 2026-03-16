// Rastreio Já — Transportadora: Correios
library;

import 'package:dio/dio.dart';
import 'package:rastreio_ja/features/carriers/carrier_interface.dart';
import 'package:rastreio_ja/features/tracking/domain/entities/tracking_event_entity.dart';

class CorreiosService implements CarrierInterface {
  CorreiosService(this._dio);
  // ignore: unused_field
  final Dio _dio;

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
  Future<List<TrackingEventEntity>> fetchTracking(final String code) async {
    throw UnimplementedError();
  }
}
