// Rastreio Já — UseCase: Deletar pacote
library;

import 'package:rastreio_ja/features/tracking/domain/repositories/tracking_repository.dart';

class DeletePackageUseCase {
  DeletePackageUseCase(this._repository);
  final TrackingRepository _repository;

  Future<void> call(final String id) => _repository.deletePackage(id);
}
