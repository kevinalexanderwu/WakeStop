import 'package:flutter/material.dart';

import 'social_button.dart';

class AuthActions extends StatelessWidget {
  const AuthActions({
    super.key,
    required this.onGoogle,
    required this.onApple,
    required this.onGuest,
  });

  final VoidCallback onGoogle;
  final VoidCallback onApple;
  final VoidCallback onGuest;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SocialButton(
          type: SocialButtonType.google,
          onPressed: onGoogle,
        ),

        const SizedBox(height: 16),

        SocialButton(
          type: SocialButtonType.apple,
          onPressed: onApple,
        ),

        const SizedBox(height: 16),

        SocialButton(
          type: SocialButtonType.guest,
          onPressed: onGuest,
        ),

        const SizedBox(height: 32),

        Text(
          'By continuing you agree to our',
          textAlign: TextAlign.center,
          style: text.bodySmall,
        ),

        const SizedBox(height: 4),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: const Text('Terms'),
            ),
            const Text('•'),
            TextButton(
              onPressed: () {},
              child: const Text('Privacy Policy'),
            ),
          ],
        ),
      ],
    );
  }
}