// Rastreio Já — UseCase: Adicionar pacote
library;

import 'package:rastreio_ja/features/tracking/domain/entities/package_entity.dart';
import 'package:rastreio_ja/features/tracking/domain/repositories/tracking_repository.dart';

class AddPackageUseCase {
  AddPackageUseCase(this._repository);
  final TrackingRepository _repository;

  Future<PackageEntity> call(
    final String code, {
    final String? nickname,
  }) =>
      _repository.addPackage(code, nickname: nickname);
}
