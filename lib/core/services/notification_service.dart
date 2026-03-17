// Rastreio Já — NotificationService
library;

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rastreio_ja/features/tracking/domain/entities/package_status.dart';

class NotificationService {
  NotificationService._();
  static final _instance = NotificationService._();
  static NotificationService get instance => _instance;

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  static const _channelId = 'rastreio_ja_tracking';
  static const _channelName = 'Rastreamento de Pacotes';
  static const _channelDesc =
      'Notificacoes de atualizacao de status dos pacotes';

  Future<void> init() async {
    if (_initialized) return;

    // Web nao suporta flutter_local_notifications
    if (kIsWeb) {
      _initialized = true;
      return;
    }

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await _plugin.initialize(initSettings);
    _initialized = true;
  }

  Future<void> showStatusUpdate({
    required final String packageId,
    required final String packageLabel,
    required final PackageStatus newStatus,
    required final String eventDescription,
  }) async {
    if (kIsWeb || !_initialized) return;

    final statusLabel = _statusLabel(newStatus);

    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.show(
      packageId.hashCode,
      '$packageLabel — $statusLabel',
      eventDescription,
      details,
    );
  }

  String _statusLabel(final PackageStatus status) => switch (status) {
        PackageStatus.posted => 'Postado',
        PackageStatus.inTransit => 'Em transito',
        PackageStatus.outForDelivery => 'Saiu para entrega',
        PackageStatus.delivered => 'Entregue!',
        PackageStatus.alert => 'Requer atencao',
        PackageStatus.returned => 'Devolvido',
        PackageStatus.unknown => 'Atualizado',
      };
}
