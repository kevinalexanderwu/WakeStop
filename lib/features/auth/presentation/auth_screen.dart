import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets/auth_actions.dart';
import 'widgets/auth_header.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  void _continue(BuildContext context) {
    context.go('/permission/location');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 24,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 420,
              ),
              child: Column(
                children: [
                  const AuthHeader(),

                  const SizedBox(height: 48),

                  AuthActions(
                    onGoogle: () => _continue(context),
                    onApple: () => _continue(context),
                    onGuest: () => _continue(context),
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