import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// Shared chrome for the map's bottom sheets (idle / trip-preview /
/// active-trip): rounded top corners, a blurred translucent surface,
/// an optional drag handle, and safe-area-aware padding.
///
/// Consolidates the repeated handle + rounded-top-container + blur
/// markup found in the source `IdleSheet`, `SelectedSheet`, and
/// `ActiveTripSheet` components into a single reusable shell, per
/// Section 3 — Shared / Reusable Components — of the architecture
/// analysis.
class AppBottomSheetShell extends StatelessWidget {
  const AppBottomSheetShell({
    super.key,
    required this.child,
    this.showHandle = true,
    this.padding,
    this.expandChild = false,
    this.borderRadius = 24,
    this.showShadow = true,
  });

  /// Sheet content.
  final Widget child;

  /// Whether to render the small drag-handle bar at the top.
  final bool showHandle;

  /// Content padding. Defaults to responsive horizontal padding (wider
  /// on tablet-sized viewports) with safe-area-aware bottom spacing.
  final EdgeInsetsGeometry? padding;

  /// Corner radius of the top two corners.
  final double borderRadius;

  /// Whether to render the elevated drop shadow above the sheet.
  final bool showShadow;

  final bool expandChild;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final horizontalPadding = screenWidth >= 600 ? 32.0 : 20.0;
    final topRadius = Radius.circular(borderRadius);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.98),
        borderRadius: BorderRadius.vertical(top: topRadius),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 30,
                  offset: const Offset(0, -4),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: topRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Padding(
            padding: padding ??
                EdgeInsets.fromLTRB(
                  horizontalPadding,
                  0,
                  horizontalPadding,
                  0,
                ),
            child: Column(
              mainAxisSize:
                  expandChild ? MainAxisSize.max : MainAxisSize.min,
              children: [
                if (showHandle) ...[
                  const SizedBox(height: 10),
                  Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],

                if (expandChild)
                  Expanded(
                    child: child,
                  )
                else
                  child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}