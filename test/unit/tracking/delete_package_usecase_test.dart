// Rastreio Já — Teste: DeletePackageUseCase
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rastreio_ja/features/tracking/domain/repositories/tracking_repository.dart';
import 'package:rastreio_ja/features/tracking/domain/usecases/delete_package_usecase.dart';

class _MockTrackingRepository extends Mock implements TrackingRepository {}

void main() {
  late DeletePackageUseCase useCase;
  late _MockTrackingRepository repository;

  setUp(() {
    repository = _MockTrackingRepository();
    useCase = DeletePackageUseCase(repository);
  });

  group('DeletePackageUseCase', () {
    test('deve chamar deletePackage no repository com o id correto', () async {
      when(() => repository.deletePackage('test-id')).thenAnswer((_) async {});

      await useCase.call('test-id');

      verify(() => repository.deletePackage('test-id')).called(1);
    });

    test('deve propagar exceção do repository', () async {
      when(() => repository.deletePackage(any()))
          .thenThrow(Exception('Erro ao deletar'));

      expect(() => useCase.call('test-id'), throwsException);
    });
  });
}
