import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 24,
          ),
          child: Column(
            children: [
              const Spacer(),

              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_on_rounded,
                  size: 72,
                  color: theme.colorScheme.primary,
                ),
              ),

              const SizedBox(height: 40),

              Text(
                "Allow Location Access",
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium,
              ),

              const SizedBox(height: 18),

              Text(
                "WakeStop needs your location to monitor your journey and alert you before your destination.",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),

              const Spacer(),

              FilledButton(
                onPressed: () {
                  context.go('/home');
                },
                child: const Text("Allow Location"),
              ),

              const SizedBox(height: 14),

              TextButton(
                onPressed: () {
                  context.go('/home');
                },
                child: const Text("Maybe Later"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}