import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// Pagination dot indicator for the onboarding carousel — the active
/// dot stretches into a pill while inactive dots stay round.
///
/// Colors default to the themed [AppColors] extension (primary /
/// border) but can be overridden, e.g. to match a per-slide accent
/// color.
class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    this.activeColor,
    this.inactiveColor,
    this.dotSize = 6,
    this.activeDotWidth = 22,
    this.spacing = 6,
  });

  /// Total number of pages/dots.
  final int count;

  /// Index of the currently active page.
  final int currentIndex;

  /// Color of the active dot. Defaults to the themed primary color.
  final Color? activeColor;

  /// Color of inactive dots. Defaults to the themed border color.
  final Color? inactiveColor;

  /// Diameter of an inactive dot, and the height of every dot.
  final double dotSize;

  /// Width of the active (stretched) dot.
  final double activeDotWidth;

  /// Horizontal gap between dots.
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final active = activeColor ?? colors.primary;
    final inactive = inactiveColor ?? colors.border;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutBack,
          margin: EdgeInsets.only(right: index == count - 1 ? 0 : spacing),
          width: isActive ? activeDotWidth : dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            color: isActive ? active : inactive,
            borderRadius: BorderRadius.circular(dotSize / 2),
          ),
        );
      }),
    );
  }
}