// Rastreio Já — Widget: TrackingTimeline reutilizável
library;

import 'package:flutter/material.dart';
import 'package:rastreio_ja/core/constants/app_colors.dart';
import 'package:rastreio_ja/core/utils/date_formatter.dart';
import 'package:rastreio_ja/features/tracking/domain/entities/tracking_event_entity.dart';

class TrackingTimeline extends StatelessWidget {
  const TrackingTimeline({
    required this.events,
    super.key,
    this.shrinkWrap = true,
    this.maxItems,
  });

  final List<TrackingEventEntity> events;
  final bool shrinkWrap;
  final int? maxItems;

  @override
  Widget build(final BuildContext context) {
    final displayed =
        maxItems != null ? events.take(maxItems!).toList() : events;

    if (displayed.isEmpty) {
      return const _EmptyTimeline();
    }

    return ListView.builder(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      itemCount: displayed.length,
      itemBuilder: (final context, final index) => _TimelineItem(
        event: displayed[index],
        isFirst: index == 0,
        isLast: index == displayed.length - 1,
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.event,
    required this.isFirst,
    required this.isLast,
  });

  final TrackingEventEntity event;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final dotColor = isFirst ? AppColors.tealPrimary : AppColors.statusPosted;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            child: Column(
              children: [
                if (!isFirst)
                  Container(
                    width: 2,
                    height: 12,
                    color: AppColors.dividerLight,
                  ),
                Container(
                  width: isFirst ? 14 : 10,
                  height: isFirst ? 14 : 10,
                  margin: EdgeInsets.only(top: isFirst ? 0 : 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: dotColor,
                    boxShadow: isFirst
                        ? [
                            BoxShadow(
                              color: dotColor.withAlpha(80),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: AppColors.dividerLight,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: isFirst ? FontWeight.w700 : FontWeight.w500,
                      color: isFirst
                          ? AppColors.tealPrimary
                          : (isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight),
                    ),
                  ),
                  if (event.location.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 12,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            event.location,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 4),
                  Text(
                    DateFormatter.full(event.timestamp),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyTimeline extends StatelessWidget {
  const _EmptyTimeline();

  @override
  Widget build(final BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.inbox_rounded,
            size: 40,
            color: AppColors.statusUnknown,
          ),
          SizedBox(height: 12),
          Text(
            'Sem eventos de rastreamento',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.statusUnknown,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Os dados podem levar até 24h para aparecer após a postagem.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.statusUnknown,
            ),
          ),
        ],
      ),
    );
  }
}
