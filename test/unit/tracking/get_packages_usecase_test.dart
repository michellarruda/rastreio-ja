// Rastreio Já — Teste: GetPackagesUseCase
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rastreio_ja/features/tracking/domain/entities/package_entity.dart';
import 'package:rastreio_ja/features/tracking/domain/entities/package_status.dart';
import 'package:rastreio_ja/features/tracking/domain/repositories/tracking_repository.dart';
import 'package:rastreio_ja/features/tracking/domain/usecases/get_packages_usecase.dart';

class _MockTrackingRepository extends Mock implements TrackingRepository {}

void main() {
  late GetPackagesUseCase useCase;
  late _MockTrackingRepository repository;

  setUp(() {
    repository = _MockTrackingRepository();
    useCase = GetPackagesUseCase(repository);
  });

  final tPackages = [
    PackageEntity(
      id: 'id-1',
      code: 'AA123456789BR',
      carrier: 'Correios',
      status: PackageStatus.inTransit,
      createdAt: DateTime(2026),
    ),
    PackageEntity(
      id: 'id-2',
      code: 'BB987654321BR',
      carrier: 'Correios',
      status: PackageStatus.delivered,
      createdAt: DateTime(2026),
    ),
  ];

  group('GetPackagesUseCase', () {
    test('deve retornar lista de pacotes do repository', () async {
      when(() => repository.getAllPackages())
          .thenAnswer((_) async => tPackages);

      final result = await useCase.call();

      expect(result, equals(tPackages));
      expect(result.length, equals(2));
      verify(() => repository.getAllPackages()).called(1);
    });

    test('deve retornar lista vazia quando não há pacotes', () async {
      when(() => repository.getAllPackages()).thenAnswer((_) async => []);

      final result = await useCase.call();

      expect(result, isEmpty);
    });

    test('deve propagar exceção do repository', () async {
      when(() => repository.getAllPackages())
          .thenThrow(Exception('Erro de storage'));

      expect(() => useCase.call(), throwsException);
    });
  });
}
