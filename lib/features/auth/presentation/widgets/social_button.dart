import 'package:flutter/material.dart';

enum SocialButtonType {
  google,
  apple,
  guest,
}

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.type,
    required this.onPressed,
  });

  final SocialButtonType type;
  final VoidCallback onPressed;

  String get _title {
    switch (type) {
      case SocialButtonType.google:
        return 'Continue with Google';
      case SocialButtonType.apple:
        return 'Continue with Apple';
      case SocialButtonType.guest:
        return 'Continue as Guest';
    }
  }

  IconData get _icon {
    switch (type) {
      case SocialButtonType.google:
        return Icons.g_mobiledata_rounded;

      case SocialButtonType.apple:
        return Icons.apple_rounded;

      case SocialButtonType.guest:
        return Icons.person_outline_rounded;
    }
  }

  Color? _background(BuildContext context) {
    switch (type) {
      case SocialButtonType.guest:
        return Theme.of(context).colorScheme.primary;

      default:
        return null;
    }
  }

  Color _foreground(BuildContext context) {
    switch (type) {
      case SocialButtonType.guest:
        return Colors.white;

      default:
        return Theme.of(context).colorScheme.onSurface;
    }
  }

  @override
  Widget build(BuildContext context) {
    final foreground = _foreground(context);

    return SizedBox(
      width: double.infinity,
      height: 58,
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: _background(context),
          foregroundColor: foreground,
          elevation: 0,
          side: type == SocialButtonType.guest
              ? null
              : BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
        ),
        onPressed: onPressed,
        icon: Icon(_icon),
        label: Text(_title),
      ),
    );
  }
}