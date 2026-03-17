// Rastreio Já — UseCase: Deletar pacote
library;

import 'package:rastreio_ja/features/tracking/domain/repositories/tracking_repository.dart';

class DeletePackageUseCase {
  const DeletePackageUseCase(this._repository);
  final TrackingRepository _repository;

  Future<void> call(final String packageId) async {
    if (packageId.trim().isEmpty) {
      throw ArgumentError('ID do pacote não pode ser vazio.');
    }
    await _repository.deletePackage(packageId);
  }
}
