import 'package:flutter/material.dart';

class OnboardingFooter extends StatelessWidget {
  const OnboardingFooter({
    super.key,
    required this.isLastPage,
    required this.onNext,
    required this.onSkip,
  });

  final bool isLastPage;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Row(
          children: [
            TextButton(
              onPressed: onSkip,
              child: const Text('Skip'),
            ),
            const Spacer(),
            FilledButton(
              onPressed: onNext,
              child: Text(
                isLastPage ? 'Get Started' : 'Continue',
              ),
            ),
          ],
        ),
      ),
    );
  }
}