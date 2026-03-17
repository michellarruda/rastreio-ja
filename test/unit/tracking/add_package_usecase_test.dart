// Rastreio Já — Teste: AddPackageUseCase
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rastreio_ja/features/tracking/domain/entities/package_entity.dart';
import 'package:rastreio_ja/features/tracking/domain/entities/package_status.dart';
import 'package:rastreio_ja/features/tracking/domain/repositories/tracking_repository.dart';
import 'package:rastreio_ja/features/tracking/domain/usecases/add_package_usecase.dart';

class _MockTrackingRepository extends Mock implements TrackingRepository {}

void main() {
  late AddPackageUseCase useCase;
  late _MockTrackingRepository repository;

  final tPackage = PackageEntity(
    id: 'test-id',
    code: 'AA123456789BR',
    carrier: 'Correios',
    status: PackageStatus.posted,
    createdAt: DateTime(2026),
  );

  setUpAll(() {
    registerFallbackValue(tPackage);
  });

  setUp(() {
    repository = _MockTrackingRepository();
    useCase = AddPackageUseCase(repository);
  });

  group('AddPackageUseCase', () {
    test('deve retornar PackageEntity ao adicionar código válido', () async {
      when(
        () => repository.addPackage(
          'AA123456789BR',
          nickname: null,
        ),
      ).thenAnswer((_) async => tPackage);

      final result = await useCase.call('AA123456789BR');

      expect(result, equals(tPackage));
      verify(
        () => repository.addPackage('AA123456789BR', nickname: null),
      ).called(1);
    });

    test('deve passar nickname para o repository quando fornecido', () async {
      when(
        () => repository.addPackage(
          'AA123456789BR',
          nickname: 'Meu Pedido',
        ),
      ).thenAnswer((_) async => tPackage);

      await useCase.call('AA123456789BR', nickname: 'Meu Pedido');

      verify(
        () => repository.addPackage(
          'AA123456789BR',
          nickname: 'Meu Pedido',
        ),
      ).called(1);
    });

    test('deve converter código para maiúsculas antes de chamar repository',
        () async {
      when(
        () => repository.addPackage(
          any(),
          nickname: any(named: 'nickname'),
        ),
      ).thenAnswer((_) async => tPackage);

      await useCase.call('aa123456789br');

      verify(
        () => repository.addPackage(
          'AA123456789BR',
          nickname: null,
        ),
      ).called(1);
    });
  });
}
