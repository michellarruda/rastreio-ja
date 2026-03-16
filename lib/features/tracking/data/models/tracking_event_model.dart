// Rastreio Já — TrackingEventModel
library;

class TrackingEventModel {
  const TrackingEventModel({
    required this.description,
    required this.location,
    required this.timestamp,
    this.detail,
  });

  factory TrackingEventModel.fromJson(final Map<String, dynamic> json) =>
      TrackingEventModel(
        description: json['descricao'] as String,
        location:    json['local']     as String,
        timestamp:   DateTime.parse(json['data'] as String),
        detail:      json['detalhe']   as String?,
      );

  final String   description;
  final String   location;
  final DateTime timestamp;
  final String?  detail;
}
