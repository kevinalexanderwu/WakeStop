import 'package:flutter/material.dart';

class MapFab extends StatelessWidget {
  const MapFab({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          right: 20,
          bottom: 220,
        ),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            heroTag: 'map_fab',
            elevation: 8,
            backgroundColor: scheme.surface,
            foregroundColor: scheme.primary,
            onPressed: onPressed,
            child: const Icon(
              Icons.my_location_rounded,
            ),
          ),
        ),
      ),
    );
  }
}