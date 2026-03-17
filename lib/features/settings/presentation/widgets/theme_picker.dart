// Rastreio Já — Widget: Seletor de tema completo
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rastreio_ja/core/theme/color_scheme_preset.dart';
import 'package:rastreio_ja/core/theme/theme_notifier.dart';

class ThemePicker extends ConsumerWidget {
  const ThemePicker({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final themeAsync = ref.watch(themeProvider);
    final state = themeAsync.valueOrNull ?? const ThemeState();
    final notifier = ref.read(themeProvider.notifier);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // -------------------------------------------------------
        // Modo de tema (Light / Dark / System)
        // -------------------------------------------------------
        Text('Modo', style: textTheme.titleSmall),
        const SizedBox(height: 12),
        _ThemeModeSelector(
          current: state.mode,
          onSelect: notifier.setMode,
        ),

        const SizedBox(height: 28),

        // -------------------------------------------------------
        // Preset de cores
        // -------------------------------------------------------
        Text('Esquema de cores', style: textTheme.titleSmall),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.8,
          ),
          itemCount: AppColorPreset.values.length,
          itemBuilder: (final BuildContext context, final int index) {
            final preset = AppColorPreset.values[index];
            final selected = preset == state.preset;
            return _PresetCard(
              preset: preset,
              selected: selected,
              onTap: () => notifier.setPreset(preset),
              scheme: scheme,
            );
          },
        ),
      ],
    );
  }
}

// -------------------------------------------------------
// Seletor de modo (Light / Dark / System)
// -------------------------------------------------------
class _ThemeModeSelector extends StatelessWidget {
  const _ThemeModeSelector({
    required this.current,
    required this.onSelect,
  });

  final ThemeMode current;
  final void Function(ThemeMode mode) onSelect;

  @override
  Widget build(final BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: ThemeMode.values.map((final ThemeMode mode) {
        final selected = mode == current;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _ModeButton(
              mode: mode,
              selected: selected,
              scheme: scheme,
              onTap: () => onSelect(mode),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ModeButton extends StatelessWidget {
  const _ModeButton({
    required this.mode,
    required this.selected,
    required this.scheme,
    required this.onTap,
  });

  final ThemeMode mode;
  final bool selected;
  final ColorScheme scheme;
  final VoidCallback onTap;

  IconData get _icon => switch (mode) {
        ThemeMode.light => Icons.light_mode_rounded,
        ThemeMode.dark => Icons.dark_mode_rounded,
        ThemeMode.system => Icons.brightness_auto_rounded,
      };

  String get _label => switch (mode) {
        ThemeMode.light => 'Claro',
        ThemeMode.dark => 'Escuro',
        ThemeMode.system => 'Sistema',
      };

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? scheme.primary : scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? scheme.primary : scheme.outline,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _icon,
              size: 20,
              color: selected ? scheme.onPrimary : scheme.onSurfaceVariant,
            ),
            const SizedBox(height: 4),
            Text(
              _label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: selected ? scheme.onPrimary : scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------
// Card de preset de cor
// -------------------------------------------------------
class _PresetCard extends StatelessWidget {
  const _PresetCard({
    required this.preset,
    required this.selected,
    required this.onTap,
    required this.scheme,
  });

  final AppColorPreset preset;
  final bool selected;
  final VoidCallback onTap;
  final ColorScheme scheme;

  @override
  Widget build(final BuildContext context) {
    final color = preset.previewColor;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color:
              selected ? color.withAlpha(30) : scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? color : scheme.outline,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Bolinha de preview da cor
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withAlpha(80),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: selected
                  ? const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    preset.displayName,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: selected ? color : scheme.onSurface,
                    ),
                  ),
                  Text(
                    preset.description,
                    style: TextStyle(
                      fontSize: 10,
                      color: scheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
