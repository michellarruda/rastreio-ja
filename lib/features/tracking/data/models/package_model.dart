// Rastreio Já — PackageModel (Hive entity)
library;

import 'package:hive_flutter/hive_flutter.dart';
import 'package:rastreio_ja/features/tracking/data/models/tracking_event_model.dart';

part 'package_model.g.dart';

@HiveType(typeId: 0)
class PackageModel extends HiveObject {
  PackageModel({
    required this.id,
    required this.trackingCode,
    required this.label,
    required this.carrier,
    required this.status,
    required this.events,
    required this.createdAt,
    required this.lastUpdatedAt,
    this.estimatedDelivery,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String trackingCode;

  @HiveField(2)
  String label;

  @HiveField(3)
  String carrier;

  @HiveField(4)
  String status;

  @HiveField(5)
  List<TrackingEventModel> events;

  @HiveField(6)
  String createdAt;

  @HiveField(7)
  String lastUpdatedAt;

  @HiveField(8)
  String? estimatedDelivery;

  PackageModel copyWith({
    final String? id,
    final String? trackingCode,
    final String? label,
    final String? carrier,
    final String? status,
    final List<TrackingEventModel>? events,
    final String? createdAt,
    final String? lastUpdatedAt,
    final String? estimatedDelivery,
  }) =>
      PackageModel(
        id: id ?? this.id,
        trackingCode: trackingCode ?? this.trackingCode,
        label: label ?? this.label,
        carrier: carrier ?? this.carrier,
        status: status ?? this.status,
        events: events ?? this.events,
        createdAt: createdAt ?? this.createdAt,
        lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
        estimatedDelivery: estimatedDelivery ?? this.estimatedDelivery,
      );
}
