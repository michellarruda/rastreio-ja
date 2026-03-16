// Rastreio Já — UseCase: Buscar pacotes
library;

import 'package:rastreio_ja/features/tracking/domain/entities/package_entity.dart';
import 'package:rastreio_ja/features/tracking/domain/repositories/tracking_repository.dart';

class GetPackagesUseCase {
  GetPackagesUseCase(this._repository);
  final TrackingRepository _repository;

  Future<List<PackageEntity>> call() => _repository.getAllPackages();
}
