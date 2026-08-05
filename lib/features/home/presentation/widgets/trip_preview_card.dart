import 'package:flutter/material.dart';

import 'package:wakestop/data/models/station.dart';
import 'package:wakestop/shared/widgets/app_bottom_sheet_shell.dart';
import 'package:wakestop/shared/widgets/buttons/primary_button.dart';

class TripPreviewCard extends StatelessWidget {
  const TripPreviewCard({
    super.key,
    required this.origin,
    required this.destination,
    required this.stops,
    required this.onStartAlarm,
  });

  final Station origin;
  final Station destination;
  final int stops;
  final VoidCallback onStartAlarm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final eta = stops * 3;

    debugPrint(destination.line);

    return AppBottomSheetShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Trip Preview",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 24),

          _TripPoint(
            icon: Icons.my_location,
            color: Colors.green,
            title: "From",
            subtitle: "Your location",
          ),

          const SizedBox(height: 16),

          Center(
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: scheme.outline,
            ),
          ),

          const SizedBox(height: 16),

          _TripPoint(
            icon: Icons.flag,
            color: Colors.orange,
            title: "Destination",
            subtitle: destination.name,
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.train_rounded),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Transit Line",
                        style: theme.textTheme.labelMedium,
                      ),
                      Text(
                        destination.line,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: scheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(
              thickness: 1,
            ),
          ),

          Row(
            children: [
              Expanded(
                child: _InfoCard(
                  icon: Icons.schedule,
                  title: "ETA",
                  value: "$eta min",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _InfoCard(
                  icon: Icons.train,
                  title: "Stops",
                  value: "$stops",
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          PrimaryButton(
            label: "Start Wake Alarm",
            icon: const Icon(Icons.notifications_active_outlined),
            onPressed: onStartAlarm,
          ),
        ],
      ),
    );
  }
}

class _TripPoint extends StatelessWidget {
  const _TripPoint({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: color.withValues(alpha: .12),
          child: Icon(
            icon,
            color: color,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 22,
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall,
          ),

          const SizedBox(height: 4),

          Text(title),
        ],
      ),
    );
  }
}