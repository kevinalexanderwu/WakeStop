import 'package:flutter/material.dart';

/// The app's secondary action button (outlined, muted foreground) —
/// e.g. "Not Now", "End Trip".
///
/// Delegates its visual style to [OutlinedButtonThemeData] registered in
/// `AppTheme` (see `lib/core/theme/app_theme.dart`), so this widget only
/// adds the reusable label/icon/full-width conveniences used alongside
/// [PrimaryButton] across onboarding, permission, and trip-sheet
/// screens.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.fullWidth = true,
  });

  /// Button label text.
  final String label;

  /// Tap callback. Pass `null` to render a disabled button.
  final VoidCallback? onPressed;

  /// Optional leading icon, rendered before [label].
  final Widget? icon;

  /// Whether the button should expand to fill available width (capped at
  /// a comfortable max width on large/tablet screens for readability).
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final Widget content = icon == null
        ? Text(label)
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon!,
              const SizedBox(width: 10),
              Text(label),
            ],
          );

    final button = OutlinedButton(
      onPressed: onPressed,
      child: content,
    );

    if (!fullWidth) return button;

    return Align(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: SizedBox(width: double.infinity, child: button),
      ),
    );
  }
}