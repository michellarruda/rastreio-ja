// Rastreio Já — Rotas (GoRouter) — configuração completa
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rastreio_ja/core/constants/app_colors.dart';
import 'package:rastreio_ja/features/settings/presentation/screens/settings_screen.dart';
import 'package:rastreio_ja/features/tracking/presentation/screens/add_package_screen.dart';
import 'package:rastreio_ja/features/tracking/presentation/screens/home_screen.dart';
import 'package:rastreio_ja/features/tracking/presentation/screens/package_detail_screen.dart';

// -------------------------------------------------------
// Breakpoints
// -------------------------------------------------------
const _kWideBreakpoint = 600.0;

// -------------------------------------------------------
// Rotas nomeadas
// -------------------------------------------------------
abstract final class AppRoutes {
  static const home = '/';
  static const addPackage = '/add';
  static const packageDetail = '/package/:id';
  static const settings = '/settings';

  static String packageDetailOf(final String id) => '/package/$id';
}

// -------------------------------------------------------
// Router principal com ShellRoute
// -------------------------------------------------------
final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  observers: [_AppRouteObserver()],
  errorBuilder: (final BuildContext context, final GoRouterState state) =>
      _NotFoundScreen(location: state.uri.toString()),
  routes: [
    ShellRoute(
      builder: (
        final BuildContext context,
        final GoRouterState state,
        final Widget child,
      ) =>
          _AdaptiveShell(
        currentLocation: state.uri.toString(),
        child: child,
      ),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          name: 'home',
          pageBuilder: (final context, final state) =>
              _fadePage(state, const HomeScreen()),
        ),
        GoRoute(
          path: AppRoutes.settings,
          name: 'settings',
          pageBuilder: (final context, final state) =>
              _fadePage(state, const SettingsScreen()),
        ),
      ],
    ),
    // Rotas fora do shell — sem NavigationRail
    GoRoute(
      path: AppRoutes.addPackage,
      name: 'add-package',
      pageBuilder: (final context, final state) =>
          _slidePage(state, const AddPackageScreen()),
    ),
    GoRoute(
      path: AppRoutes.packageDetail,
      name: 'package-detail',
      pageBuilder: (final context, final state) => _slidePage(
        state,
        PackageDetailScreen(
          packageId: state.pathParameters['id'] ?? '',
        ),
      ),
    ),
  ],
);

// -------------------------------------------------------
// AdaptiveShell
// -------------------------------------------------------
class _AdaptiveShell extends StatelessWidget {
  const _AdaptiveShell({
    required this.currentLocation,
    required this.child,
  });

  final String currentLocation;
  final Widget child;

  int get _selectedIndex {
    if (currentLocation.startsWith(AppRoutes.settings)) return 1;
    return 0;
  }

  void _onDestinationSelected(
    final int index,
    final BuildContext context,
  ) {
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
      case 1:
        context.go(AppRoutes.settings);
    }
  }

  @override
  Widget build(final BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= _kWideBreakpoint;

    if (isWide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (final i) =>
                  _onDestinationSelected(i, context),
              labelType: NavigationRailLabelType.all,
              leading: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: AppColors.tealPrimary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.local_shipping_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'RJ',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: AppColors.tealPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.inventory_2_outlined),
                  selectedIcon: Icon(Icons.inventory_2_rounded),
                  label: Text('Pacotes'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings_rounded),
                  label: Text('Config'),
                ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: child),
          ],
        ),
      );
    }

    // Mobile — BottomNavigationBar
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (final i) => _onDestinationSelected(i, context),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2_rounded),
            label: 'Pacotes',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings_rounded),
            label: 'Config',
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------
// Transições
// -------------------------------------------------------
CustomTransitionPage<void> _fadePage(
  final GoRouterState state,
  final Widget child,
) =>
    CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 250),
      transitionsBuilder: (
        final context,
        final animation,
        final __,
        final child,
      ) =>
          FadeTransition(opacity: animation, child: child),
    );

CustomTransitionPage<void> _slidePage(
  final GoRouterState state,
  final Widget child,
) =>
    CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (
        final context,
        final animation,
        final __,
        final child,
      ) =>
          SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        ),
        child: child,
      ),
    );

// -------------------------------------------------------
// Observer
// -------------------------------------------------------
class _AppRouteObserver extends NavigatorObserver {
  @override
  void didPush(
    final Route<dynamic> route,
    final Route<dynamic>? previousRoute,
  ) {
    debugPrint('[Router] push: ${route.settings.name}');
  }

  @override
  void didPop(
    final Route<dynamic> route,
    final Route<dynamic>? previousRoute,
  ) {
    debugPrint('[Router] pop: ${route.settings.name}');
  }

  @override
  void didReplace({
    final Route<dynamic>? newRoute,
    final Route<dynamic>? oldRoute,
  }) {
    debugPrint('[Router] replace: ${newRoute?.settings.name}');
  }
}

// -------------------------------------------------------
// 404
// -------------------------------------------------------
class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen({required this.location});
  final String location;

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Página não encontrada',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              location,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Voltar para o início'),
            ),
          ],
        ),
      ),
    );
  }
}
