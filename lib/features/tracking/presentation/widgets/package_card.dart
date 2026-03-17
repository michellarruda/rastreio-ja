// Rastreio Já — Widget: PackageCard reutilizável
library;

import 'package:flutter/material.dart';
import 'package:rastreio_ja/core/constants/app_colors.dart';
import 'package:rastreio_ja/features/tracking/domain/entities/package_entity.dart';
import 'package:rastreio_ja/features/tracking/presentation/widgets/status_badge.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({
    required this.package,
    super.key,
    this.onTap,
    this.compact = false,
  });

  final PackageEntity package;
  final VoidCallback? onTap;
  final bool compact;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final statusColor = StatusBadge.colorOf(package.status);
    final displayName = package.nickname ?? package.code;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(compact ? 12 : 16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : AppColors.cardLight,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDark ? AppColors.shadowDark : AppColors.shadowLight,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(compact ? 6 : 8),
              decoration: BoxDecoration(
                color: statusColor.withAlpha(30),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                StatusBadge.iconOf(package.status),
                color: statusColor,
                size: compact ? 16 : 20,
              ),
            ),
            SizedBox(width: compact ? 8 : 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: compact ? 13 : null,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    package.code,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                      fontFamily: 'monospace',
                      fontSize: compact ? 10 : null,
                    ),
                  ),
                ],
              ),
            ),
            if (package.isRefreshing)
              const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else
              StatusBadge(status: package.status, compact: compact),
          ],
        ),
      ),
    );
  }
}
