import 'package:flutter/material.dart';
import 'package:wakestop/features/splash/presentation/widgets/splash_logo.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Column(
      children: [
        const SizedBox(height: 30),

        const SplashLogo(size: 84),

        const SizedBox(height: 24),

        Text(
          'WakeStop',
          style: text.headlineMedium,
        ),

        const SizedBox(height: 8),

        Text(
          'Welcome Back',
          style: text.titleMedium,
        ),

        const SizedBox(height: 12),

        Text(
          'Sign in to continue your journey and never miss your stop again.',
          textAlign: TextAlign.center,
          style: text.bodyMedium,
        ),
      ],
    );
  }
}