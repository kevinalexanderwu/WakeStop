import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_theme.dart';
import 'transport_palette.dart';

/// Central Material 3 [ThemeData] factory for WakeStop.
///
/// Wires together:
/// - [ColorScheme] (Material 3), seeded from the brand primary and
///   overridden with the exact tokens from [AppColors] so semantic
///   Material roles (primary/error/surface/outline/...) match the
///   source design exactly rather than being algorithmically derived.
/// - [AppTextTheme] — the Inter type scale.
/// - [AppColors] / [TransportPalette] — registered as [ThemeExtension]s
///   for design tokens with no direct Material 3 [ColorScheme] slot
///   (map rendering colors, per-transit-line colors, tint backgrounds).
abstract final class AppTheme {
  static ThemeData get light => _build(
        brightness: Brightness.light,
        appColors: AppColors.light,
        textTheme: AppTextTheme.light,
      );

  static ThemeData get dark => _build(
        brightness: Brightness.dark,
        appColors: AppColors.dark,
        textTheme: AppTextTheme.dark,
      );

  static ThemeData _build({
    required Brightness brightness,
    required AppColors appColors,
    required TextTheme textTheme,
  }) {
    final isDark = brightness == Brightness.dark;

    final colorScheme = ColorScheme.fromSeed(
      seedColor: appColors.primary,
      brightness: brightness,
    ).copyWith(
      primary: appColors.primary,
      onPrimary: Colors.white,
      primaryContainer: appColors.primaryLight,
      onPrimaryContainer: appColors.primaryDark,
      secondary: appColors.success,
      onSecondary: Colors.white,
      secondaryContainer: appColors.successLight,
      onSecondaryContainer: appColors.success,
      tertiary: appColors.warning,
      onTertiary: Colors.white,
      tertiaryContainer: appColors.warningLight,
      onTertiaryContainer: appColors.warning,
      error: appColors.danger,
      onError: Colors.white,
      errorContainer: appColors.dangerLight,
      onErrorContainer: appColors.danger,
      surface: appColors.surface,
      onSurface: appColors.textPrimary,
      surfaceContainerHighest: isDark ? appColors.divider : appColors.divider,
      outline: appColors.border,
      outlineVariant: appColors.divider,
      inverseSurface: isDark ? AppColors.light.surface : AppColors.dark.surface,
      onInverseSurface: isDark ? AppColors.light.textPrimary : AppColors.dark.textPrimary,
      inversePrimary: appColors.primaryLight,
      scrim: Colors.black,
      shadow: Colors.black,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: appColors.background,
      canvasColor: appColors.background,
      textTheme: textTheme,
      fontFamily: textTheme.bodyMedium?.fontFamily,
      dividerColor: appColors.divider,
      dividerTheme: DividerThemeData(
        color: appColors.divider,
        thickness: 1,
        space: 1,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: appColors.background,
        foregroundColor: appColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: textTheme.titleSmall,
      ),
      cardTheme: CardThemeData(
        color: appColors.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: appColors.border, width: 1),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: appColors.surface,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: appColors.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: appColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: appColors.border,
          disabledForegroundColor: appColors.textMuted,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          textStyle: textTheme.bodyLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: appColors.textSecondary,
          side: BorderSide(color: appColors.border, width: 1.5),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          textStyle: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: appColors.textMuted,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          textStyle: textTheme.bodyMedium,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: appColors.divider,
        contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: appColors.border, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: appColors.border, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: appColors.primary, width: 1.5),
        ),
        hintStyle: textTheme.bodySmall?.copyWith(color: appColors.textSecondary),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.white),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return appColors.primary;
          return isDark ? appColors.border : const Color(0xFFD1D5DB);
        }),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
      iconTheme: IconThemeData(color: appColors.textSecondary, size: 20),
      splashFactory: InkRipple.splashFactory,
      extensions: <ThemeExtension<dynamic>>[
        appColors,
        TransportPalette.standard,
      ],
    );
  }
}

/// Convenience accessors for the WakeStop [ThemeExtension]s, so call sites
/// can write `context.appColors.primary` / `context.transportColors.mrt`
/// instead of `Theme.of(context).extension<AppColors>()!`.
extension WakeStopThemeX on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;

  TransportPalette get transportColors =>
      Theme.of(this).extension<TransportPalette>()!;
}