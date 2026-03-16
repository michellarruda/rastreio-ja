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
    this.events      = const [],
    this.lastUpdatedAt,
    this.isDelivered = false,
  });

  final String                    id;
  final String                    code;
  final String?                   nickname;
  final String                    carrier;
  final PackageStatus             status;
  final List<TrackingEventEntity> events;
  final DateTime                  createdAt;
  final DateTime?                 lastUpdatedAt;
  final bool                      isDelivered;
}
