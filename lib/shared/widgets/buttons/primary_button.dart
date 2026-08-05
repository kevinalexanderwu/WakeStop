import 'package:flutter/material.dart';

/// The app's primary call-to-action button (filled, rounded, primary
/// color) — e.g. "Continue", "Get Started", "Start Trip", "Allow Access".
///
/// Delegates its visual style to [ElevatedButtonThemeData] registered in
/// `AppTheme` (see `lib/core/theme/app_theme.dart`), so this widget only
/// adds the reusable label/icon/loading/full-width conveniences used
/// across the onboarding, auth, permission, and trip-sheet screens.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.fullWidth = true,
    this.isLoading = false,
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

  /// Shows a spinner in place of the label/icon and disables interaction.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final Widget content = isLoading
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.4,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        : icon == null
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

    final button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
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