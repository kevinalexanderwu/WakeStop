import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// A custom pill-shaped toggle switch matching the source design's hand
/// -rolled toggle (used for the alarm on/off row and the Vibrate / Dark
/// Mode settings rows), rather than the stock Material [Switch].
///
/// Reads its track/thumb colors from the themed [AppColors] extension so
/// it stays in sync with light/dark theming automatically.
class AppToggleSwitch extends StatelessWidget {
  const AppToggleSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.activeColor,
    this.width = 44,
    this.height = 26,
  });

  /// Current toggle state.
  final bool value;

  /// Change callback. Pass `null` to render a disabled (non-interactive)
  /// switch.
  final ValueChanged<bool>? onChanged;

  /// Track color when [value] is `true`. Defaults to the themed primary
  /// color.
  final Color? activeColor;

  /// Overall pill width.
  final double width;

  /// Overall pill height.
  final double height;

  bool get _enabled => onChanged != null;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final trackColor = value
        ? (activeColor ?? colors.primary)
        : (isDark ? colors.border : const Color(0xFFD1D5DB));

    final thumbSize = height - 6;

    return Opacity(
      opacity: _enabled ? 1 : 0.5,
      child: GestureDetector(
        onTap: _enabled ? () => onChanged!(!value) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          width: width,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: trackColor,
            borderRadius: BorderRadius.circular(height / 2),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: thumbSize,
              height: thumbSize,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}