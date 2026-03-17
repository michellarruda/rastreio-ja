// Rastreio Já — UseCase: Atualizar rastreamento
library;

import 'package:rastreio_ja/features/tracking/domain/entities/package_entity.dart';
import 'package:rastreio_ja/features/tracking/domain/repositories/tracking_repository.dart';

class RefreshTrackingUseCase {
  const RefreshTrackingUseCase(this._repository);
  final TrackingRepository _repository;

  Future<PackageEntity> call(final String id) async {
    if (id.trim().isEmpty) {
      throw ArgumentError('ID do pacote não pode ser vazio.');
    }
    return _repository.refreshPackage(id);
  }
}
