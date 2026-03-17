// Rastreio Já — UseCase: Listar pacotes
library;

import 'package:rastreio_ja/features/tracking/domain/entities/package_entity.dart';
import 'package:rastreio_ja/features/tracking/domain/repositories/tracking_repository.dart';

class GetPackagesUseCase {
  const GetPackagesUseCase(this._repository);
  final TrackingRepository _repository;

  Future<List<PackageEntity>> call() => _repository.getAllPackages();
}
