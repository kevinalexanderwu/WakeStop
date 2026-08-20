import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  Future<void> _requestLocation(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission =
        await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      if (context.mounted) {
        context.go('/home');
      }
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('setup_completed', true);

    if (context.mounted) {
      context.go('/home');
    }
  }

  Future<void> _skip(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('setup_completed', true);

    if (context.mounted) {
      context.go('/home');
    }
  }

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

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => _requestLocation(context),
                  child: const Text("Allow Location"),
                ),
              ),

              const SizedBox(height: 14),

              TextButton(
                onPressed: () => _skip(context),
                child: const Text("Maybe Later"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}