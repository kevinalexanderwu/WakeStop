import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Builds the WakeStop [TextTheme] on top of Material 3's type scale.
///
/// The source prototype uses a single typeface — Inter, weights 300–700 —
/// with ad hoc per-widget sizes (see Section 5 — Typography — of the
/// architecture analysis). Those roles are mapped onto the Material 3
/// scale (`displayLarge` → `labelSmall`) below, ordered largest to
/// smallest, so the rest of the app can consume `Theme.of(context).textTheme`
/// instead of one-off styles.
///
/// | Material 3 role | size / weight / spacing | source usage |
/// |---|---|---|
/// | displayLarge  | 34 / w700 / -0.5 | Splash wordmark |
/// | headlineLarge | 32 / w700 / -0.5 | Alarm screen "Wake up!" |
/// | headlineMedium| 30 / w700 / -0.5 | Onboarding headline |
/// | headlineSmall | 26 / w700 / -0.4 | Auth "Welcome back" |
/// | titleLarge    | 24 / w700 / -0.4 | Permission screen title |
/// | titleMedium   | 22 / w700 / -0.3 | Sheet title / destination name |
/// | titleSmall    | 20 / w700 / -0.3 | Settings screen title |
/// | bodyLarge     | 16 / w600 / -0.1 | Primary button label |
/// | bodyMedium    | 15 / w500 /  0.0 | Descriptions, list titles |
/// | bodySmall     | 14 / w500 /  0.0 | Search bar placeholder, row label |
/// | labelLarge    | 13 / w500 /  0.0 | Captions, subtitles, line names |
/// | labelMedium   | 12 / w600 /  0.5 | Uppercase eyebrows / badges |
/// | labelSmall    |  9 / w400 /  0.0 | Map micro labels |
abstract final class AppTextTheme {
  /// Text theme for use on light backgrounds / light [ThemeData].
  static TextTheme light = _build(baseColor: const Color(0xFF111827));

  /// Text theme for use on dark backgrounds / dark [ThemeData].
  static TextTheme dark = _build(baseColor: const Color(0xFFF1F5F9));

  static TextTheme _build({required Color baseColor}) {
    final base = GoogleFonts.interTextTheme();

    return base.copyWith(
      displayLarge: GoogleFonts.inter(
        color: baseColor,
        fontSize: 34,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        height: 1.15,
      ),
      headlineLarge: GoogleFonts.inter(
        color: baseColor,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        height: 1.15,
      ),
      headlineMedium: GoogleFonts.inter(
        color: baseColor,
        fontSize: 30,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        height: 1.18,
      ),
      headlineSmall: GoogleFonts.inter(
        color: baseColor,
        fontSize: 26,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        height: 1.2,
      ),
      titleLarge: GoogleFonts.inter(
        color: baseColor,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        height: 1.2,
      ),
      titleMedium: GoogleFonts.inter(
        color: baseColor,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
        height: 1.2,
      ),
      titleSmall: GoogleFonts.inter(
        color: baseColor,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
        height: 1.2,
      ),
      bodyLarge: GoogleFonts.inter(
        color: baseColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.1,
        height: 1.3,
      ),
      bodyMedium: GoogleFonts.inter(
        color: baseColor,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
        height: 1.5,
      ),
      bodySmall: GoogleFonts.inter(
        color: baseColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
        height: 1.4,
      ),
      labelLarge: GoogleFonts.inter(
        color: baseColor,
        fontSize: 13,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
        height: 1.3,
      ),
      labelMedium: GoogleFonts.inter(
        color: baseColor,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        height: 1.2,
      ),
      labelSmall: GoogleFonts.inter(
        color: baseColor,
        fontSize: 9,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
        height: 1.1,
      ),
    );
  }
}