// Rastreio Já — HomeScreen
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rastreio_ja/core/constants/app_colors.dart';
import 'package:rastreio_ja/core/constants/app_strings.dart';
import 'package:rastreio_ja/core/router/app_router.dart';
import 'package:rastreio_ja/features/tracking/domain/entities/package_entity.dart';
import 'package:rastreio_ja/features/tracking/domain/entities/package_status.dart';
import 'package:rastreio_ja/features/tracking/presentation/providers/packages_provider.dart';
import 'package:rastreio_ja/core/widgets/animated_list_item.dart';
import 'package:rastreio_ja/core/widgets/empty_state_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final packagesAsync = ref.watch(packagesProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, theme, isDark),
          packagesAsync.when(
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (final err, final _) => SliverFillRemaining(
              child: _ErrorState(message: err.toString()),
            ),
            data: (final packages) => packages.isEmpty
                ? const SliverFillRemaining(child: _EmptyState())
                : SliverFillRemaining(
                    child: RefreshIndicator(
                      color: AppColors.tealPrimary,
                      onRefresh: () =>
                          ref.read(packagesProvider.notifier).refreshAll(),
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                        itemCount: packages.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (final context, final index) =>
                            AnimatedListItem(
                          index: index,
                          child: _PackageCard(package: packages[index]),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.addPackage),
        backgroundColor: AppColors.tealPrimary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Adicionar'),
      ),
    );
  }

  SliverAppBar _buildAppBar(
    final BuildContext context,
    final ThemeData theme,
    final bool isDark,
  ) =>
      SliverAppBar(
        expandedHeight: 120,
        floating: true,
        snap: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    AppStrings.appName,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.tealPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    AppStrings.homeTitle,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () => context.push(AppRoutes.settings),
                icon: const Icon(Icons.settings_outlined),
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
            ],
          ),
        ),
      );
}

// -------------------------------------------------------
// PackageCard
// -------------------------------------------------------

class _PackageCard extends ConsumerWidget {
  const _PackageCard({required this.package});
  final PackageEntity package;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final statusColor = _statusColor(package.status);
    final statusLabel = _statusLabel(package.status);
    final statusIcon = _statusIcon(package.status);
    final displayName = package.nickname ?? package.code;

    return Dismissible(
      key: ValueKey(package.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_rounded, color: Colors.white, size: 28),
      ),
      confirmDismiss: (_) => _confirmDelete(context, displayName),
      onDismissed: (_) {
        ref.read(packagesProvider.notifier).deletePackage(package.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$displayName removido'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: GestureDetector(
        onTap: () => context.push(AppRoutes.packageDetailOf(package.id)),
        child: Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(statusIcon, color: statusColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayName,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: statusColor.withAlpha(80)),
                      ),
                      child: Text(
                        statusLabel,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              if (package.latestEvent != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.surfaceDark2
                        : AppColors.surfaceLight2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          package.latestEvent!.description,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> _confirmDelete(
    final BuildContext context,
    final String label,
  ) =>
      showDialog<bool>(
        context: context,
        builder: (final ctx) => AlertDialog(
          title: const Text('Remover pacote'),
          content: Text('Deseja remover "$label"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.error,
              ),
              child: const Text('Remover'),
            ),
          ],
        ),
      );

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

  IconData _statusIcon(final PackageStatus status) => switch (status) {
        PackageStatus.posted => Icons.inventory_2_outlined,
        PackageStatus.inTransit => Icons.local_shipping_outlined,
        PackageStatus.outForDelivery => Icons.delivery_dining_outlined,
        PackageStatus.delivered => Icons.check_circle_outline_rounded,
        PackageStatus.alert => Icons.warning_amber_rounded,
        PackageStatus.returned => Icons.keyboard_return_rounded,
        PackageStatus.unknown => Icons.help_outline_rounded,
      };
}

// -------------------------------------------------------
// Empty State
// -------------------------------------------------------

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(final BuildContext context) => const EmptyStateWidget(
        title: AppStrings.homeEmpty,
        subtitle: AppStrings.homeEmptySubtitle,
      );
}

// -------------------------------------------------------
// Error State
// -------------------------------------------------------

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message});
  final String message;

  @override
  Widget build(final BuildContext context) => ErrorStateWidget(
        title: 'Erro ao carregar pacotes',
        subtitle: message,
      );
}
