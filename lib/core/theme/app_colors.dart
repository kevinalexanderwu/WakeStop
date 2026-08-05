import 'package:flutter/material.dart';

/// Design-token color palette for WakeStop.
///
/// Mirrors the `P` palette object and CSS `@theme` tokens from the source
/// React/TS prototype (see Section 4 — Color Palette — of the architecture
/// analysis). Exposed as a [ThemeExtension] so both semantic/brand colors
/// and map-rendering colors can be looked up via `Theme.of(context)`
/// without polluting the Material 3 [ColorScheme].
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    // Brand / semantic
    required this.primary,
    required this.primaryDark,
    required this.primaryLight,
    required this.primaryMid,
    required this.success,
    required this.successLight,
    required this.danger,
    required this.dangerLight,
    required this.warning,
    required this.warningLight,
    // Neutrals
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.background,
    required this.surface,
    required this.border,
    required this.divider,
    // Map-specific
    required this.mapBackground,
    required this.mapRoad,
    required this.mapRoadMajor,
    required this.mapBuilding,
    required this.mapPark,
    required this.mapWater,
  });

  // ── Brand / semantic ──────────────────────────────────────────────────
  final Color primary;
  final Color primaryDark;
  final Color primaryLight;
  final Color primaryMid;

  final Color success;
  final Color successLight;

  final Color danger;
  final Color dangerLight;

  final Color warning;
  final Color warningLight;

  // ── Neutrals ───────────────────────────────────────────────────────────
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;

  final Color background;
  final Color surface;
  final Color border;
  final Color divider;

  // ── Map-specific ──────────────────────────────────────────────────────
  final Color mapBackground;
  final Color mapRoad;
  final Color mapRoadMajor;
  final Color mapBuilding;
  final Color mapPark;
  final Color mapWater;

  /// Light theme instance — values sourced from the `P` object
  /// (light branch) in the source prototype.
  static const AppColors light = AppColors(
    primary: Color(0xFF2563EB),
    primaryDark: Color(0xFF1D4ED8),
    primaryLight: Color(0xFFEFF6FF),
    primaryMid: Color(0xFFDBEAFE),
    success: Color(0xFF10B981),
    successLight: Color(0xFFECFDF5),
    danger: Color(0xFFEF4444),
    dangerLight: Color(0xFFFEF2F2),
    warning: Color(0xFFF59E0B),
    warningLight: Color(0xFFFFFBEB),
    textPrimary: Color(0xFF111827),
    textSecondary: Color(0xFF6B7280),
    textMuted: Color(0xFF9CA3AF),
    background: Color(0xFFF0EDEA),
    surface: Color(0xFFFFFFFF),
    border: Color(0xFFE5E7EB),
    divider: Color(0xFFF3F4F6),
    mapBackground: Color(0xFFF0EDEA),
    mapRoad: Color(0xFFFFFFFF),
    mapRoadMajor: Color(0xFFFFFFFF),
    mapBuilding: Color(0xFFE4DDD5),
    mapPark: Color(0xFFC8DFC8),
    mapWater: Color(0xFFB8D0E6),
  );

  /// Dark theme instance — values sourced from the `P` object
  /// (dark / `d*` and `dm*` branches) in the source prototype.
  static const AppColors dark = AppColors(
    primary: Color(0xFF2563EB),
    primaryDark: Color(0xFF1D4ED8),
    primaryLight: Color(0xFFEFF6FF),
    primaryMid: Color(0xFFDBEAFE),
    success: Color(0xFF10B981),
    successLight: Color(0xFFECFDF5),
    danger: Color(0xFFEF4444),
    dangerLight: Color(0xFFFEF2F2),
    warning: Color(0xFFF59E0B),
    warningLight: Color(0xFFFFFBEB),
    textPrimary: Color(0xFFF1F5F9),
    textSecondary: Color(0xFF94A3B8),
    textMuted: Color(0xFF64748B),
    background: Color(0xFF161C28),
    surface: Color(0xFF1F2738),
    border: Color(0xFF2D3A50),
    divider: Color(0xFF273040),
    mapBackground: Color(0xFF1A1F2E),
    mapRoad: Color(0xFF28334A),
    mapRoadMajor: Color(0xFF2E3C55),
    mapBuilding: Color(0xFF222A3A),
    mapPark: Color(0xFF1A2D22),
    mapWater: Color(0xFF1A2840),
  );

  @override
  AppColors copyWith({
    Color? primary,
    Color? primaryDark,
    Color? primaryLight,
    Color? primaryMid,
    Color? success,
    Color? successLight,
    Color? danger,
    Color? dangerLight,
    Color? warning,
    Color? warningLight,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? background,
    Color? surface,
    Color? border,
    Color? divider,
    Color? mapBackground,
    Color? mapRoad,
    Color? mapRoadMajor,
    Color? mapBuilding,
    Color? mapPark,
    Color? mapWater,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      primaryDark: primaryDark ?? this.primaryDark,
      primaryLight: primaryLight ?? this.primaryLight,
      primaryMid: primaryMid ?? this.primaryMid,
      success: success ?? this.success,
      successLight: successLight ?? this.successLight,
      danger: danger ?? this.danger,
      dangerLight: dangerLight ?? this.dangerLight,
      warning: warning ?? this.warning,
      warningLight: warningLight ?? this.warningLight,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      mapBackground: mapBackground ?? this.mapBackground,
      mapRoad: mapRoad ?? this.mapRoad,
      mapRoadMajor: mapRoadMajor ?? this.mapRoadMajor,
      mapBuilding: mapBuilding ?? this.mapBuilding,
      mapPark: mapPark ?? this.mapPark,
      mapWater: mapWater ?? this.mapWater,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t)!,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t)!,
      primaryMid: Color.lerp(primaryMid, other.primaryMid, t)!,
      success: Color.lerp(success, other.success, t)!,
      successLight: Color.lerp(successLight, other.successLight, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      dangerLight: Color.lerp(dangerLight, other.dangerLight, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningLight: Color.lerp(warningLight, other.warningLight, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      border: Color.lerp(border, other.border, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      mapBackground: Color.lerp(mapBackground, other.mapBackground, t)!,
      mapRoad: Color.lerp(mapRoad, other.mapRoad, t)!,
      mapRoadMajor: Color.lerp(mapRoadMajor, other.mapRoadMajor, t)!,
      mapBuilding: Color.lerp(mapBuilding, other.mapBuilding, t)!,
      mapPark: Color.lerp(mapPark, other.mapPark, t)!,
      mapWater: Color.lerp(mapWater, other.mapWater, t)!,
    );
  }
}