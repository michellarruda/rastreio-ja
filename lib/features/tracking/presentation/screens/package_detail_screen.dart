// Rastreio Já — PackageDetailScreen
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rastreio_ja/core/constants/app_colors.dart';
import 'package:rastreio_ja/core/constants/app_strings.dart';
import 'package:rastreio_ja/core/utils/date_formatter.dart';
import 'package:rastreio_ja/features/tracking/domain/entities/package_entity.dart';
import 'package:rastreio_ja/features/tracking/domain/entities/package_status.dart';
import 'package:rastreio_ja/features/tracking/domain/entities/tracking_event_entity.dart';
import 'package:rastreio_ja/features/tracking/presentation/providers/packages_provider.dart';

class PackageDetailScreen extends ConsumerWidget {
  const PackageDetailScreen({required this.packageId, super.key});
  final String packageId;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final package = ref.watch(packageByIdProvider(packageId));

    if (package == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Pacote não encontrado')),
      );
    }

    return _DetailView(package: package);
  }
}

// -------------------------------------------------------
// View principal
// -------------------------------------------------------

class _DetailView extends ConsumerWidget {
  const _DetailView({required this.package});
  final PackageEntity package;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final statusColor = _statusColor(package.status);
    final displayName = package.nickname ?? package.code;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: statusColor,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
              onPressed: context.pop,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.copy_rounded, color: Colors.white),
                tooltip: 'Copiar código',
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: package.code));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Código copiado!'),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              IconButton(
                icon: package.isRefreshing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.refresh_rounded,
                        color: Colors.white,
                      ),
                tooltip: AppStrings.detailRefresh,
                onPressed: package.isRefreshing
                    ? null
                    : () => ref
                        .read(packagesProvider.notifier)
                        .refreshPackage(package.id),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [statusColor, statusColor.withAlpha(180)],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 56, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          displayName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          package.code,
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 14,
                            fontFamily: 'monospace',
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _StatusBadge(
                          label: _statusLabel(package.status),
                          color: Colors.white,
                          backgroundColor: Colors.white.withAlpha(40),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoCard(
                    package: package,
                    isDark: isDark,
                    theme: theme,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Histórico de rastreamento',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  package.events.isEmpty
                      ? _NoEventsCard(isDark: isDark)
                      : _Timeline(events: package.events),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------
// Info Card
// -------------------------------------------------------

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.package,
    required this.isDark,
    required this.theme,
  });

  final PackageEntity package;
  final bool isDark;
  final ThemeData theme;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        children: [
          _InfoRow(
            icon: Icons.local_shipping_outlined,
            label: 'Transportadora',
            value: package.carrier,
          ),
          _Divider(isDark: isDark),
          _InfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'Cadastrado em',
            value: DateFormatter.short(package.createdAt),
          ),
          if (package.lastUpdatedAt != null) ...[
            _Divider(isDark: isDark),
            _InfoRow(
              icon: Icons.update_rounded,
              label: AppStrings.detailLastUpdate,
              value: DateFormatter.relative(package.lastUpdatedAt!),
            ),
          ],
          if (package.estimatedDelivery != null) ...[
            _Divider(isDark: isDark),
            _InfoRow(
              icon: Icons.event_available_rounded,
              label: 'Previsão de entrega',
              value: DateFormatter.short(package.estimatedDelivery!),
              valueColor: AppColors.statusDelivered,
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({required this.isDark});
  final bool isDark;

  @override
  Widget build(final BuildContext context) => Divider(
        height: 1,
        color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
      );
}

// -------------------------------------------------------
// Timeline
// -------------------------------------------------------

class _Timeline extends StatelessWidget {
  const _Timeline({required this.events});
  final List<TrackingEventEntity> events;

  @override
  Widget build(final BuildContext context) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: events.length,
        itemBuilder: (final context, final index) => _TimelineItem(
          event: events[index],
          isFirst: index == 0,
          isLast: index == events.length - 1,
        ),
      );
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

// -------------------------------------------------------
// Empty events
// -------------------------------------------------------

class _NoEventsCard extends StatelessWidget {
  const _NoEventsCard({required this.isDark});
  final bool isDark;

  @override
  Widget build(final BuildContext context) => Container(
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

// -------------------------------------------------------
// Status Badge
// -------------------------------------------------------

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.label,
    required this.color,
    required this.backgroundColor,
  });

  final String label;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(final BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
      );
}

// -------------------------------------------------------
// Helpers
// -------------------------------------------------------

Color _statusColor(final PackageStatus status) => switch (status) {
      PackageStatus.posted => AppColors.statusPosted,
      PackageStatus.inTransit => AppColors.statusInTransit,
      PackageStatus.outForDelivery => AppColors.statusOutForDel,
      PackageStatus.delivered => AppColors.statusDelivered,
      PackageStatus.alert => AppColors.statusAlert,
      PackageStatus.returned => AppColors.statusReturned,
      PackageStatus.unknown => AppColors.statusUnknown,
    };

String _statusLabel(final PackageStatus status) => switch (status) {
      PackageStatus.posted => AppStrings.statusPosted,
      PackageStatus.inTransit => AppStrings.statusInTransit,
      PackageStatus.outForDelivery => AppStrings.statusOutForDel,
      PackageStatus.delivered => AppStrings.statusDelivered,
      PackageStatus.alert => AppStrings.statusAlert,
      PackageStatus.returned => 'Devolvido',
      PackageStatus.unknown => AppStrings.statusUnknown,
    };
