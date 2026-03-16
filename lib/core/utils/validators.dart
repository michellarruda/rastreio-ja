// Rastreio Já — Validadores
library;

import 'package:rastreio_ja/core/constants/app_constants.dart';
import 'package:rastreio_ja/core/constants/app_strings.dart';

abstract final class Validators {
  static String? trackingCode(final String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.errorInvalidCode;
    }
    final cleaned = value.trim().toUpperCase();
    final regex   = RegExp(r'^[A-Z]{2}[0-9]{9}[A-Z]{2}$');
    if (cleaned.length != AppConstants.trackingCodeLen ||
        !regex.hasMatch(cleaned)) {
      return AppStrings.errorInvalidCode;
    }
    return null;
  }
}
