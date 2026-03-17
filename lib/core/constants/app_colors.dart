// Rastreio Já — Paleta de cores completa (design Vitality)
library;

import 'package:flutter/material.dart';

abstract final class AppColors {
  // -------------------------------------------------------
  // Vitality — Cores principais (baseadas no design anexo)
  // -------------------------------------------------------
  static const tealPrimary = Color(0xFF2ECFCF);
  static const tealLight = Color(0xFF4ADEDE);
  static const tealDark = Color(0xFF1DA8A8);
  static const tealSurface = Color(0xFFE0FAFA);

  static const accentYellow = Color(0xFFF5A623);
  static const accentYellowLight = Color(0xFFFFC857);
  static const accentOrange = Color(0xFFFF8E53);

  // -------------------------------------------------------
  // Superfícies — Light
  // -------------------------------------------------------
  static const backgroundLight = Color(0xFFF5FFFE);
  static const surfaceLight = Color(0xFFFFFFFF);
  static const surfaceLight2 = Color(0xFFF0FAFA);
  static const surfaceLight3 = Color(0xFFE0F7F7);
  static const cardLight = Color(0xFFFFFFFF);

  // -------------------------------------------------------
  // Superfícies — Dark
  // -------------------------------------------------------
  static const backgroundDark = Color(0xFF0F1923);
  static const surfaceDark = Color(0xFF1A2633);
  static const surfaceDark2 = Color(0xFF243040);
  static const surfaceDark3 = Color(0xFF2E3D50);
  static const cardDark = Color(0xFF1E2D3D);

  // -------------------------------------------------------
  // Sidebar gradient (igual ao design Vitality)
  // -------------------------------------------------------
  static const sidebarTop = Color(0xFF3DE0D0);
  static const sidebarBottom = Color(0xFF1DA8C8);

  static const List<Color> sidebarGradient = [
    sidebarTop,
    sidebarBottom,
  ];

  // -------------------------------------------------------
  // Texto — Light
  // -------------------------------------------------------
  static const textPrimaryLight = Color(0xFF1A1A2E);
  static const textSecondaryLight = Color(0xFF6B7280);
  static const textDisabledLight = Color(0xFFB0B7C3);
  static const textOnPrimary = Color(0xFFFFFFFF);

  // -------------------------------------------------------
  // Texto — Dark
  // -------------------------------------------------------
  static const textPrimaryDark = Color(0xFFF1F5F9);
  static const textSecondaryDark = Color(0xFF94A3B8);
  static const textDisabledDark = Color(0xFF4A5568);

  // -------------------------------------------------------
  // Semânticas — Status de pacote
  // -------------------------------------------------------
  static const statusPosted = Color(0xFF6B7280);
  static const statusInTransit = Color(0xFF3498DB);
  static const statusOutForDel = Color(0xFFF5A623);
  static const statusDelivered = Color(0xFF27AE60);
  static const statusAlert = Color(0xFFE74C3C);
  static const statusReturned = Color(0xFF9B59B6);
  static const statusUnknown = Color(0xFFB0B7C3);

  // -------------------------------------------------------
  // Semânticas — Feedback
  // -------------------------------------------------------
  static const success = Color(0xFF27AE60);
  static const successLight = Color(0xFFD4EDDA);
  static const warning = Color(0xFFF39C12);
  static const warningLight = Color(0xFFFFF3CD);
  static const error = Color(0xFFE74C3C);
  static const errorLight = Color(0xFFF8D7DA);
  static const info = Color(0xFF3498DB);
  static const infoLight = Color(0xFFD1ECF1);

  // -------------------------------------------------------
  // Sombras
  // -------------------------------------------------------
  static const shadowLight = Color(0x1A2ECFCF);
  static const shadowDark = Color(0x33000000);

  // -------------------------------------------------------
  // Divisores
  // -------------------------------------------------------
  static const dividerLight = Color(0xFFE5E7EB);
  static const dividerDark = Color(0xFF2D3748);

  // -------------------------------------------------------
  // Presets — Ocean
  // -------------------------------------------------------
  static const oceanPrimary = Color(0xFF1A73E8);
  static const oceanSecondary = Color(0xFF4FC3F7);
  static const oceanTertiary = Color(0xFF00BCD4);
  static const oceanSurface = Color(0xFFE8F4FD);

  // -------------------------------------------------------
  // Presets — Sunset
  // -------------------------------------------------------
  static const sunsetPrimary = Color(0xFFFF6B6B);
  static const sunsetSecondary = Color(0xFFFFB347);
  static const sunsetTertiary = Color(0xFFFF8E53);
  static const sunsetSurface = Color(0xFFFFF0ED);

  // -------------------------------------------------------
  // Presets — Minimal
  // -------------------------------------------------------
  static const minimalPrimary = Color(0xFF2D3436);
  static const minimalSecondary = Color(0xFF636E72);
  static const minimalTertiary = Color(0xFF0984E3);
  static const minimalSurface = Color(0xFFF8F9FA);
}
