// Rastreio Já — Widget: StatusBadge
library;

import 'package:flutter/material.dart';
import 'package:rastreio_ja/core/constants/app_colors.dart';
import 'package:rastreio_ja/core/constants/app_strings.dart';
import 'package:rastreio_ja/features/tracking/domain/entities/package_status.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    required this.status,
    super.key,
    this.compact = false,
  });

  final PackageStatus status;
  final bool compact;

  @override
  Widget build(final BuildContext context) {
    final color = colorOf(status);
    final label = labelOf(status);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 3 : 4,
      ),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withAlpha(80)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: compact ? 6 : 8,
            height: compact ? 6 : 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          SizedBox(width: compact ? 4 : 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: compact ? 10 : 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  static Color colorOf(final PackageStatus status) => switch (status) {
        PackageStatus.posted => AppColors.statusPosted,
        PackageStatus.inTransit => AppColors.statusInTransit,
        PackageStatus.outForDelivery => AppColors.statusOutForDel,
        PackageStatus.delivered => AppColors.statusDelivered,
        PackageStatus.alert => AppColors.statusAlert,
        PackageStatus.returned => AppColors.statusReturned,
        PackageStatus.unknown => AppColors.statusUnknown,
      };

  static String labelOf(final PackageStatus status) => switch (status) {
        PackageStatus.posted => AppStrings.statusPosted,
        PackageStatus.inTransit => AppStrings.statusInTransit,
        PackageStatus.outForDelivery => AppStrings.statusOutForDel,
        PackageStatus.delivered => AppStrings.statusDelivered,
        PackageStatus.alert => AppStrings.statusAlert,
        PackageStatus.returned => 'Devolvido',
        PackageStatus.unknown => AppStrings.statusUnknown,
      };

  static IconData iconOf(final PackageStatus status) => switch (status) {
        PackageStatus.posted => Icons.inventory_2_outlined,
        PackageStatus.inTransit => Icons.local_shipping_outlined,
        PackageStatus.outForDelivery => Icons.delivery_dining_outlined,
        PackageStatus.delivered => Icons.check_circle_outline_rounded,
        PackageStatus.alert => Icons.warning_amber_rounded,
        PackageStatus.returned => Icons.keyboard_return_rounded,
        PackageStatus.unknown => Icons.help_outline_rounded,
      };
}
