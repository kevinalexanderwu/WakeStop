import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../data/models/station.dart';

/// A reusable station/place row: icon badge, name + line, and an
/// optional trailing ETA label or chevron.
///
/// Used for saved places, search results, and settings' saved-places
/// list — the three near-identical list rows identified in the
/// architecture analysis (Section 3 — Shared / Reusable Components).
class StationListTile extends StatelessWidget {
  const StationListTile({
    super.key,
    required this.station,
    this.iconColor,
    this.iconBackgroundColor,
    this.trailingText,
    this.showChevron = false,
    this.onTap,
    this.dense = false,
  });

  /// The station this row represents.
  final Station station;

  /// Color of the leading pin icon. Defaults to the themed primary
  /// color.
  final Color? iconColor;

  /// Background color of the leading icon badge. Defaults to the
  /// themed primary-tint color.
  final Color? iconBackgroundColor;

  /// Optional trailing label, e.g. a formatted ETA ("12 min"). Takes
  /// precedence over [showChevron] when both are set.
  final String? trailingText;

  /// Whether to show a trailing chevron (used for navigable rows, e.g.
  /// search results) when [trailingText] is not provided.
  final bool showChevron;

  /// Optional tap handler.
  final VoidCallback? onTap;

  /// Renders a smaller, more compact variant.
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textTheme = Theme.of(context).textTheme;

    final resolvedIconColor = iconColor ?? colors.primary;
    final resolvedIconBackground = iconBackgroundColor ?? colors.primaryLight;
    final iconSize = dense ? 32.0 : 40.0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: dense ? 8 : 11, horizontal: 6),
        child: Row(
          children: [
            Container(
              width: iconSize,
              height: iconSize,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: resolvedIconBackground,
                borderRadius: BorderRadius.circular(dense ? 10 : 13),
              ),
              child: Icon(
                Icons.location_on_rounded,
                size: dense ? 16 : 18,
                color: resolvedIconColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    station.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    station.line,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.labelLarge?.copyWith(color: colors.textSecondary),
                  ),
                ],
              ),
            ),
            if (trailingText != null) ...[
              const SizedBox(width: 8),
              Text(
                trailingText!,
                style: textTheme.labelLarge?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ] else if (showChevron) ...[
              const SizedBox(width: 8),
              Icon(Icons.chevron_right_rounded, size: 16, color: colors.textSecondary),
            ],
          ],
        ),
      ),
    );
  }
}