import 'package:flutter/material.dart';

@immutable
class OnboardingItem {
  const OnboardingItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.colors,
  });

  final String title;
  final String description;
  final IconData icon;
  final List<Color> colors;
}

const onboardingItems = <OnboardingItem>[
  OnboardingItem(
    title: 'Never Miss Your Stop',
    description:
        'WakeStop monitors your journey and alerts you before reaching your destination.',
    icon: Icons.notifications_active_rounded,
    colors: [
      Color(0xFF2563EB),
      Color(0xFF60A5FA),
    ],
  ),
  OnboardingItem(
    title: 'Track Public Transport',
    description:
        'Works with MRT, KRL, LRT and TransJakarta across Jakarta using real-time trip monitoring.',
    icon: Icons.train_rounded,
    colors: [
      Color(0xFF7C3AED),
      Color(0xFFA78BFA),
    ],
  ),
  OnboardingItem(
    title: 'Travel With Confidence',
    description:
        'Relax, read, or even take a nap while WakeStop makes sure you get off at the right station.',
    icon: Icons.location_on_rounded,
    colors: [
      Color(0xFF10B981),
      Color(0xFF6EE7B7),
    ],
  ),
];