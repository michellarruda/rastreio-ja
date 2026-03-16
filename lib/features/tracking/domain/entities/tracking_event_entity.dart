// Rastreio Já — TrackingEventEntity
library;

class TrackingEventEntity {
  const TrackingEventEntity({
    required this.description,
    required this.location,
    required this.timestamp,
    this.detail,
  });

  final String   description;
  final String   location;
  final DateTime timestamp;
  final String?  detail;
}
