import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wakestop/features/splash/presentation/splash_screen.dart';
import 'package:wakestop/features/onboarding/presentation/onboarding_screen.dart';
import 'package:wakestop/features/auth/presentation/auth_screen.dart';
import 'package:wakestop/features/permissions/presentation/location_permission_screen.dart';
import 'package:wakestop/features/home/presentation/home_screen.dart';
import 'package:wakestop/features/home/presentation/screens/search_screen.dart';
import 'package:wakestop/features/settings/presentation/settings_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),

    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),

    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthScreen(),
    ),

    GoRoute(
      path: '/permission/location',
      builder: (context, state) =>
          const LocationPermissionScreen(),
    ),

    GoRoute(
      path: '/permission/notification',
      builder: (context, state) =>
          const _PlaceholderPage(title: 'Notification Permission'),
    ),

    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),

    GoRoute(
      path: '/alarm',
      builder: (context, state) =>
          const _PlaceholderPage(title: 'Alarm'),
    ),

    GoRoute(
      path: '/settings',
      builder: (context, state) =>
          const _PlaceholderPage(title: 'Settings'),
    ),

    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}