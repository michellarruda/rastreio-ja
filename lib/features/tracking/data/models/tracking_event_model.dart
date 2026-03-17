// Rastreio Já — TrackingEventModel (SeuRastreio API format)
library;

class TrackingEventModel {
  const TrackingEventModel({
    required this.description,
    required this.location,
    required this.timestamp,
    this.detail,
    this.carrierCode,
  });

  factory TrackingEventModel.fromJson(final Map<String, dynamic> json) {
    // Parseia a data — formato ISO ou dd/MM/yyyy HH:mm
    final rawDate = json['data'] as String? ?? '';
    final dateTime = _parseDate(rawDate);

    return TrackingEventModel(
      description: json['descricao'] as String? ?? '',
      location: json['local'] as String? ?? '',
      timestamp: dateTime,
      detail: json['detalhe'] as String?,
      carrierCode: json['carrier'] as String?,
    );
  }

  final String description;
  final String location;
  final DateTime timestamp;
  final String? detail;
  final String? carrierCode;

  static DateTime _parseDate(final String raw) {
    if (raw.isEmpty) return DateTime.now();

    // Tenta ISO 8601 primeiro
    final iso = DateTime.tryParse(raw);
    if (iso != null) return iso;

    // Tenta dd/MM/yyyy HH:mm
    try {
      final parts = raw.split(' ');
      final dateParts = parts[0].split('/');
      final timeParts = parts.length > 1 ? parts[1].split(':') : ['0', '0'];
      return DateTime(
        int.parse(dateParts[2]),
        int.parse(dateParts[1]),
        int.parse(dateParts[0]),
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
      );
    } catch (_) {
      return DateTime.now();
    }
  }
}
