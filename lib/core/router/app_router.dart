// Rastreio Já — Rotas (GoRouter) — configuração completa
// Rastreio Já — Rotas (GoRouter) — configuração completa
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rastreio_ja/features/settings/presentation/screens/settings_screen.dart';
import 'package:rastreio_ja/features/tracking/presentation/screens/add_package_screen.dart';
import 'package:rastreio_ja/features/tracking/presentation/screens/home_screen.dart';
import 'package:rastreio_ja/features/tracking/presentation/screens/package_detail_screen.dart';

// -------------------------------------------------------
// Rotas nomeadas
// -------------------------------------------------------
abstract final class AppRoutes {
  static const home = '/';
  static const addPackage = '/add';
  static const packageDetail = '/package/:id';
  static const settings = '/settings';

  /// Gera a rota de detalhe com o [id] preenchido
  static String packageDetailOf(final String id) => '/package/$id';
}

// -------------------------------------------------------
// Router principal
// -------------------------------------------------------
final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  observers: [_AppRouteObserver()],
  errorBuilder: (final BuildContext context, final GoRouterState state) =>
      _NotFoundScreen(location: state.uri.toString()),
  routes: [
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      pageBuilder: (
        final BuildContext context,
        final GoRouterState state,
      ) =>
          _fadePage(state, const HomeScreen()),
    ),
    GoRoute(
      path: AppRoutes.addPackage,
      name: 'add-package',
      pageBuilder: (
        final BuildContext context,
        final GoRouterState state,
      ) =>
          _slidePage(state, const AddPackageScreen()),
    ),
    GoRoute(
      path: AppRoutes.packageDetail,
      name: 'package-detail',
      pageBuilder: (
        final BuildContext context,
        final GoRouterState state,
      ) =>
          _slidePage(
        state,
        PackageDetailScreen(
          packageId: state.pathParameters['id'] ?? '',
        ),
      ),
    ),
    GoRoute(
      path: AppRoutes.settings,
      name: 'settings',
      pageBuilder: (
        final BuildContext context,
        final GoRouterState state,
      ) =>
          _slidePage(state, const SettingsScreen()),
    ),
  ],
);

// -------------------------------------------------------
// Transições de página
// -------------------------------------------------------

/// Transição fade — usada na Home
CustomTransitionPage<void> _fadePage(
  final GoRouterState state,
  final Widget child,
) =>
    CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 250),
      transitionsBuilder: (
        final BuildContext context,
        final Animation<double> animation,
        final Animation<double> secondaryAnimation,
        final Widget child,
      ) =>
          FadeTransition(opacity: animation, child: child),
    );

/// Transição slide da direita — usada nas demais telas
CustomTransitionPage<void> _slidePage(
  final GoRouterState state,
  final Widget child,
) =>
    CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (
        final BuildContext context,
        final Animation<double> animation,
        final Animation<double> secondaryAnimation,
        final Widget child,
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
// Observer — loga navegação em debug
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
  void didPop(final Route<dynamic> route, final Route<dynamic>? previousRoute) {
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
// Tela 404 — rota não encontrada
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
