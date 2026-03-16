// Rastreio Já — Constantes gerais
library;

abstract final class AppConstants {
  static const cacheDurationHours = 2;
  static const maxPackagesPerUser = 50;

  static const packagesBoxName = 'rastreio_ja_packages';
  static const settingsBoxName = 'rastreio_ja_settings';

  static const prefThemeMode   = 'pref_theme_mode';
  static const prefColorPreset = 'pref_color_preset';

  static const apiBaseUrl       = 'https://api.seurastreio.com.br';
  static const apiTimeout       = 15000;
  static const apiRetryAttempts = 3;

  static const trackingCodeLen = 13;
}
