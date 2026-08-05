import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../data/models/trip_plan.dart' show Transport;

/// A colored pill representing a transit mode (KRL / MRT / LRT /
/// TransJakarta) — used for the map's mode-filter chips, the trip
/// sheet's mode label, and search result line indicators.
///
/// Colors are sourced from the themed [TransportPalette] extension, so
/// KRL/MRT/LRT/TransJakarta hues stay centralized and theme-aware.
class TransportBadge extends StatelessWidget {
  const TransportBadge({
    super.key,
    required this.transport,
    this.selected = true,
    this.onTap,
    this.dense = false,
  });

  /// The transit mode this badge represents.
  final Transport transport;

  /// Whether this badge renders in its filled/"active" state (true) or
  /// its outlined/"inactive" state (false) — e.g. the currently
  /// selected chip in a mode filter row.
  final bool selected;

  /// Optional tap handler. When provided, the badge becomes interactive
  /// (used for chip-style mode selection); when `null`, it renders as a
  /// static label (used for sheet headers / result rows).
  final VoidCallback? onTap;

  /// Renders a smaller, more compact variant.
  final bool dense;

  Color _colorFor(BuildContext context) {
    final palette = context.transportColors;
    switch (transport) {
      case Transport.krl:
        return palette.krl;
      case Transport.mrt:
        return palette.mrt;
      case Transport.lrt:
        return palette.lrt;
      case Transport.transJakarta:
        return palette.transJakarta;
    }
  }

  String get _label {
    switch (transport) {
      case Transport.krl:
        return 'KRL';
      case Transport.mrt:
        return 'MRT';
      case Transport.lrt:
        return 'LRT';
      case Transport.transJakarta:
        return 'TransJakarta';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textTheme = Theme.of(context).textTheme;
    final lineColor = _colorFor(context);

    final background = selected ? lineColor : Theme.of(context).colorScheme.surface;
    final borderColor = selected ? lineColor : colors.border;
    final textColor = selected ? Colors.white : colors.textSecondary;

    final labelStyle = (dense ? textTheme.labelMedium : textTheme.labelLarge)
        ?.copyWith(color: textColor, fontWeight: FontWeight.w600);

    final badge = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(
        horizontal: dense ? 9 : 14,
        vertical: dense ? 3 : 7,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: selected
                ? lineColor.withValues(alpha: 0.25)
                : Colors.black.withValues(alpha: 0.08),
            blurRadius: selected ? 14 : 8,
            offset: Offset(0, selected ? 4 : 2),
          ),
        ],
      ),
      child: Text(_label, style: labelStyle),
    );

    if (onTap == null) return badge;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: badge,
    );
  }
}