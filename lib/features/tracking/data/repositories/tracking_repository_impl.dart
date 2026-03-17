// Rastreio Já — TrackingRepositoryImpl
library;

import 'package:hive_flutter/hive_flutter.dart';
import 'package:rastreio_ja/features/tracking/data/datasources/tracking_local_datasource.dart';
import 'package:rastreio_ja/features/tracking/data/datasources/tracking_remote_datasource.dart';
import 'package:rastreio_ja/features/tracking/data/models/package_model.dart';
import 'package:rastreio_ja/features/tracking/data/models/tracking_event_model.dart';
import 'package:rastreio_ja/features/tracking/domain/entities/package_entity.dart';
import 'package:rastreio_ja/features/tracking/domain/entities/package_status.dart';
import 'package:rastreio_ja/features/tracking/domain/entities/tracking_event_entity.dart';
import 'package:rastreio_ja/features/tracking/domain/repositories/tracking_repository.dart';
import 'package:uuid/uuid.dart';
// adicionar no bloco de imports:
import 'package:rastreio_ja/core/services/notification_service.dart';

class TrackingRepositoryImpl implements TrackingRepository {
  const TrackingRepositoryImpl({
    required this.local,
    required this.remote,
    required this.hiveBox,
  });

  final TrackingLocalDataSource local;
  final TrackingRemoteDataSource remote;
  final Box<PackageModel> hiveBox;

  // -------------------------------------------------------
  // Interface pública
  // -------------------------------------------------------

  @override
  Future<List<PackageEntity>> getAllPackages() async {
    final models = await local.getAllPackages();
    return models.map(_modelToEntity).toList();
  }

  @override
  Future<PackageEntity> addPackage(
    final String code, {
    final String? nickname,
  }) async {
    final trimmedCode = code.trim().toUpperCase();

    List<TrackingEventModel> events = [];
    try {
      events = await remote.fetchTrackingEvents(trimmedCode);
    } catch (_) {}

    final status = _inferStatus(events);
    final now = DateTime.now().toIso8601String();

    final model = PackageModel(
      id: const Uuid().v4(),
      trackingCode: trimmedCode,
      label: nickname ?? trimmedCode,
      carrier: 'Correios',
      status: _statusToString(status),
      events: events,
      createdAt: now,
      lastUpdatedAt: now,
    );

    await local.savePackage(model);
    return _modelToEntity(model);
  }

  @override
  Future<void> deletePackage(final String id) => local.deletePackage(id);

  @override
  Future<PackageEntity> refreshPackage(final String id) async {
    final existing = local.getPackageById(id);
    if (existing == null) throw Exception('Pacote não encontrado: $id');

    final oldStatus = existing.status;

    List<TrackingEventModel> events = [];
    try {
      events = await remote.fetchTrackingEvents(existing.trackingCode);
    } catch (_) {
      events = existing.events;
    }

    final newStatusStr = _statusToString(_inferStatus(events));
    final updated = existing.copyWith(
      status: newStatusStr,
      events: events,
      lastUpdatedAt: DateTime.now().toIso8601String(),
    );
    await local.updatePackage(updated);

    if (oldStatus != newStatusStr && events.isNotEmpty) {
      await NotificationService.instance.showStatusUpdate(
        packageId: existing.id,
        packageLabel: existing.label,
        newStatus: _inferStatus(events),
        eventDescription: events.first.description,
      );
    }

    return _modelToEntity(updated);
  }

  // -------------------------------------------------------
  // Helpers privados
  // -------------------------------------------------------

  PackageEntity _modelToEntity(final PackageModel m) => PackageEntity(
        id: m.id,
        code: m.trackingCode,
        nickname: m.label != m.trackingCode ? m.label : null,
        carrier: m.carrier,
        status: _stringToStatus(m.status),
        events: m.events.map(_eventToEntity).toList(),
        createdAt: DateTime.parse(m.createdAt),
        lastUpdatedAt: DateTime.tryParse(m.lastUpdatedAt),
        isDelivered: _stringToStatus(m.status) == PackageStatus.delivered,
        estimatedDelivery: m.estimatedDelivery != null
            ? DateTime.tryParse(m.estimatedDelivery!)
            : null,
      );

  TrackingEventEntity _eventToEntity(final TrackingEventModel e) =>
      TrackingEventEntity(
        description: e.description,
        location: e.location,
        timestamp: e.timestamp,
        detail: e.detail,
      );

  PackageStatus _stringToStatus(final String s) => switch (s) {
        'posted' => PackageStatus.posted,
        'inTransit' => PackageStatus.inTransit,
        'outForDelivery' => PackageStatus.outForDelivery,
        'delivered' => PackageStatus.delivered,
        'alert' => PackageStatus.alert,
        'returned' => PackageStatus.returned,
        _ => PackageStatus.unknown,
      };

  String _statusToString(final PackageStatus s) => switch (s) {
        PackageStatus.posted => 'posted',
        PackageStatus.inTransit => 'inTransit',
        PackageStatus.outForDelivery => 'outForDelivery',
        PackageStatus.delivered => 'delivered',
        PackageStatus.alert => 'alert',
        PackageStatus.returned => 'returned',
        PackageStatus.unknown => 'unknown',
      };

  PackageStatus _inferStatus(final List<TrackingEventModel> events) {
    if (events.isEmpty) return PackageStatus.posted;
    final desc = events.first.description.toLowerCase();
    if (desc.contains('entregue') || desc.contains('entrega efetuada')) {
      return PackageStatus.delivered;
    }
    if (desc.contains('saiu para entrega') ||
        desc.contains('saiu p/ entrega') ||
        desc.contains('em rota de entrega')) {
      return PackageStatus.outForDelivery;
    }
    if (desc.contains('devolvido') || desc.contains('retorno')) {
      return PackageStatus.returned;
    }
    if (desc.contains('aguardando') || desc.contains('problema')) {
      return PackageStatus.alert;
    }
    return PackageStatus.inTransit;
  }
}
