import 'package:flutter/material.dart';

/// A low-emphasis, no-background text action — e.g. "Skip", "Snooze 30
/// Seconds", "Continue as Guest".
///
/// Delegates its visual style to [TextButtonThemeData] registered in
/// `AppTheme` (see `lib/core/theme/app_theme.dart`), so this widget only
/// adds the reusable label/icon convenience used across onboarding,
/// auth, and alarm screens.
class TextActionButton extends StatelessWidget {
  const TextActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.color,
  });

  /// Button label text.
  final String label;

  /// Tap callback. Pass `null` to render a disabled button.
  final VoidCallback? onPressed;

  /// Optional leading icon, rendered before [label].
  final Widget? icon;

  /// Optional foreground color override (e.g. a warning/amber accent for
  /// "Snooze"). Defaults to the themed text-button color.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final Widget content = icon == null
        ? Text(label)
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon!,
              const SizedBox(width: 8),
              Text(label),
            ],
          );

    return TextButton(
      onPressed: onPressed,
      style: color != null
          ? TextButton.styleFrom(foregroundColor: color)
          : null,
      child: content,
    );
  }
}