// Rastreio Já — PackageEntity
library;

import 'package:rastreio_ja/features/tracking/domain/entities/package_status.dart';
import 'package:rastreio_ja/features/tracking/domain/entities/tracking_event_entity.dart';

class PackageEntity {
  const PackageEntity({
    required this.id,
    required this.code,
    required this.carrier,
    required this.status,
    required this.createdAt,
    this.nickname,
    this.events = const [],
    this.lastUpdatedAt,
    this.isDelivered = false,
    this.isRefreshing = false,
    this.estimatedDelivery,
  });

  final String id;
  final String code;
  final String? nickname;
  final String carrier;
  final PackageStatus status;
  final List<TrackingEventEntity> events;
  final DateTime createdAt;
  final DateTime? lastUpdatedAt;
  final bool isDelivered;
  final bool isRefreshing;
  final DateTime? estimatedDelivery;

  TrackingEventEntity? get latestEvent =>
      events.isNotEmpty ? events.first : null;

  PackageEntity copyWith({
    final String? id,
    final String? code,
    final String? nickname,
    final String? carrier,
    final PackageStatus? status,
    final List<TrackingEventEntity>? events,
    final DateTime? createdAt,
    final DateTime? lastUpdatedAt,
    final bool? isDelivered,
    final bool? isRefreshing,
    final DateTime? estimatedDelivery,
  }) =>
      PackageEntity(
        id: id ?? this.id,
        code: code ?? this.code,
        nickname: nickname ?? this.nickname,
        carrier: carrier ?? this.carrier,
        status: status ?? this.status,
        events: events ?? this.events,
        createdAt: createdAt ?? this.createdAt,
        lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
        isDelivered: isDelivered ?? this.isDelivered,
        isRefreshing: isRefreshing ?? this.isRefreshing,
        estimatedDelivery: estimatedDelivery ?? this.estimatedDelivery,
      );
}
