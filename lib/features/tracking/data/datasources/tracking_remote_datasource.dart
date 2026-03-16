// Rastreio Já — DataSource remoto
library;

import 'package:dio/dio.dart';
import 'package:rastreio_ja/features/tracking/data/models/tracking_event_model.dart';

abstract interface class TrackingRemoteDataSource {
  Future<List<TrackingEventModel>> getTrackingEvents(final String code);
}

class TrackingRemoteDataSourceImpl implements TrackingRemoteDataSource {
  TrackingRemoteDataSourceImpl(this._dio);
  // ignore: unused_field
  final Dio _dio;

  @override
  Future<List<TrackingEventModel>> getTrackingEvents(
    final String code,
  ) async {
    throw UnimplementedError();
  }
}
