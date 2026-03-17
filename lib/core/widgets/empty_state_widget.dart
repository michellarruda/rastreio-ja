// Rastreio Já — Widget: EmptyStateWidget e ErrorStateWidget
library;

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rastreio_ja/core/constants/app_colors.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    this.title = 'Nada por aqui',
    this.subtitle,
    this.actionLabel,
    this.onAction,
    this.animationPath,
    this.icon = Icons.inventory_2_outlined,
    this.iconColor = AppColors.tealPrimary,
  });

  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;
  final String? animationPath;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(final BuildContext context) => _StateWidget(
        title: title,
        subtitle: subtitle,
        actionLabel: actionLabel,
        onAction: onAction,
        animationPath: animationPath,
        fallbackIcon: icon,
        fallbackColor: iconColor,
      );
}

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({
    super.key,
    this.title = 'Algo deu errado',
    this.subtitle,
    this.actionLabel = 'Tentar novamente',
    this.onAction,
    this.animationPath,
  });

  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;
  final String? animationPath;

  @override
  Widget build(final BuildContext context) => _StateWidget(
        title: title,
        subtitle: subtitle,
        actionLabel: actionLabel,
        onAction: onAction,
        animationPath: animationPath,
        fallbackIcon: Icons.error_outline_rounded,
        fallbackColor: AppColors.error,
      );
}

// -------------------------------------------------------
// Widget interno compartilhado
// -------------------------------------------------------

class _StateWidget extends StatelessWidget {
  const _StateWidget({
    required this.title,
    required this.fallbackIcon,
    required this.fallbackColor,
    this.subtitle,
    this.actionLabel,
    this.onAction,
    this.animationPath,
  });

  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;
  final String? animationPath;
  final IconData fallbackIcon;
  final Color fallbackColor;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _IllustrationOrIcon(
              animationPath: animationPath,
              fallbackIcon: fallbackIcon,
              fallbackColor: fallbackColor,
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.refresh_rounded),
                label: Text(actionLabel!),
                style: FilledButton.styleFrom(
                  backgroundColor: fallbackColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _IllustrationOrIcon extends StatelessWidget {
  const _IllustrationOrIcon({
    required this.fallbackIcon,
    required this.fallbackColor,
    this.animationPath,
  });

  final String? animationPath;
  final IconData fallbackIcon;
  final Color fallbackColor;

  @override
  Widget build(final BuildContext context) {
    if (animationPath != null) {
      return SizedBox(
        width: 180,
        height: 180,
        child: Lottie.asset(
          animationPath!,
          fit: BoxFit.contain,
          errorBuilder: (final context, final error, final _) => _fallback(),
        ),
      );
    }
    return _fallback();
  }

  Widget _fallback() => Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: fallbackColor.withAlpha(20),
          shape: BoxShape.circle,
        ),
        child: Icon(fallbackIcon, size: 72, color: fallbackColor),
      );
}
