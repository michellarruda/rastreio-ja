// Rastreio Já — UseCase: Atualizar rastreio
library;

import 'package:rastreio_ja/features/tracking/domain/entities/package_entity.dart';
import 'package:rastreio_ja/features/tracking/domain/repositories/tracking_repository.dart';

class RefreshTrackingUseCase {
  RefreshTrackingUseCase(this._repository);
  final TrackingRepository _repository;

  Future<PackageEntity> call(final String id) =>
      _repository.refreshPackage(id);
}
