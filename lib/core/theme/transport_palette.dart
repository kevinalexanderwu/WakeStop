import 'package:flutter/material.dart';

/// Transit-mode color tokens for WakeStop.
///
/// Sourced from the inline `lines` color map used across
/// `TransportChips`, `SelectedSheet`, and `SearchOverlay` in the source
/// prototype (see Section 4 — Color Palette — "Transport line colors" —
/// of the architecture analysis). Kept as its own [ThemeExtension] since
/// it is a 4-way domain palette distinct from the general brand/semantic
/// [AppColors] tokens, and is not expressed by [ColorScheme].
///
/// The source design does not define separate dark-mode values for
/// transit-line colors, so the same hues are used for both the light and
/// dark [ThemeData] registrations.
@immutable
class TransportPalette extends ThemeExtension<TransportPalette> {
  const TransportPalette({
    required this.krl,
    required this.mrt,
    required this.lrt,
    required this.transJakarta,
  });

  /// KRL (commuter rail) line color.
  final Color krl;

  /// MRT (mass rapid transit) line color — matches [AppColors.primary].
  final Color mrt;

  /// LRT (light rail transit) line color.
  final Color lrt;

  /// TransJakarta (BRT) line color — matches [AppColors.warning].
  final Color transJakarta;

  /// Single palette instance shared by both light and dark themes.
  static const TransportPalette standard = TransportPalette(
    krl: Color(0xFFDC2626),
    mrt: Color(0xFF2563EB),
    lrt: Color(0xFF7C3AED),
    transJakarta: Color(0xFFF59E0B),
  );

  @override
  TransportPalette copyWith({
    Color? krl,
    Color? mrt,
    Color? lrt,
    Color? transJakarta,
  }) {
    return TransportPalette(
      krl: krl ?? this.krl,
      mrt: mrt ?? this.mrt,
      lrt: lrt ?? this.lrt,
      transJakarta: transJakarta ?? this.transJakarta,
    );
  }

  @override
  TransportPalette lerp(ThemeExtension<TransportPalette>? other, double t) {
    if (other is! TransportPalette) return this;
    return TransportPalette(
      krl: Color.lerp(krl, other.krl, t)!,
      mrt: Color.lerp(mrt, other.mrt, t)!,
      lrt: Color.lerp(lrt, other.lrt, t)!,
      transJakarta: Color.lerp(transJakarta, other.transJakarta, t)!,
    );
  }
}