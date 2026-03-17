// Rastreio Já — Teste: Validators
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:rastreio_ja/core/utils/validators.dart';

void main() {
  group('Validators.trackingCode', () {
    test('deve retornar null para código válido dos Correios', () {
      expect(Validators.trackingCode('AA123456789BR'), isNull);
      expect(Validators.trackingCode('OB935196685BR'), isNull);
      expect(Validators.trackingCode('LO123456789CN'), isNull);
    });

    test('deve retornar erro para código vazio', () {
      expect(Validators.trackingCode(''), isNotNull);
      expect(Validators.trackingCode(null), isNotNull);
    });

    test('deve retornar erro para código com tamanho incorreto', () {
      expect(Validators.trackingCode('AA12345678BR'), isNotNull);
      expect(Validators.trackingCode('AA1234567890BR'), isNotNull);
    });

    test('deve retornar erro para código com formato inválido', () {
      expect(Validators.trackingCode('12345678901BR'), isNotNull);
      expect(Validators.trackingCode('AA12345678901'), isNotNull);
      expect(Validators.trackingCode('AAAAAAAAAAABR'), isNotNull);
    });

    test('deve aceitar código em minúsculas', () {
      expect(Validators.trackingCode('aa123456789br'), isNull);
    });
  });
}
