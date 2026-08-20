import 'package:flutter/material.dart';

import 'package:wakestop/shared/widgets/app_bottom_sheet_shell.dart';
import 'package:wakestop/shared/widgets/buttons/primary_button.dart';
import 'package:wakestop/core/services/alarm_service.dart';

class ActiveTripCard extends StatelessWidget {
  const ActiveTripCard({
    super.key,
    required this.destination,
    required this.line,
    required this.progress,
    required this.etaMinutes,
    
    required this.currentStation,
    required this.nextStation,
    required this.remainingStops,
    required this.distanceMeters,
    required this.onCancel,
    required this.onDebugNext,
    required this.onDebugPrevious,
    required this.locationReady,
  });

  final String destination;
  final String line;
  final bool locationReady;
  final double progress;
  final int etaMinutes;
  final double distanceMeters;
  final String currentStation;
  final String nextStation;
  final int remainingStops;

  final VoidCallback onCancel;
  final VoidCallback onDebugNext;
  final VoidCallback onDebugPrevious;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

return AppBottomSheetShell(
  child: ConstrainedBox(
    constraints: BoxConstraints(
      maxHeight: MediaQuery.sizeOf(context).height * 0.78,
    ),
    child: SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.train_rounded,
            size: 42,
          ),

          const SizedBox(height: 16),

          Text(
            "Wake Alarm Active",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, size: 18),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  destination,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ],
          ),

          Text(
            line,
            style: theme.textTheme.bodyMedium,
          ),

          const SizedBox(height: 24),

          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 500),
            tween: Tween<double>(
              begin: 0,
              end: progress,
            ),
            builder: (context, animatedProgress, child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: LinearProgressIndicator(
                  value: animatedProgress,
                  minHeight: 10,
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          Text(
            locationReady
                ? "Journey Progress • ${(progress * 100).round()}%"
                : "Calculating journey...",
          ),
          const SizedBox(height: 8),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.notifications_active_rounded,
                  color: Colors.orange,
                  size: 30,
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Alarm Status",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        distanceMeters <= 500
                            ? "Wake alarm is active.\nYou have arrived near your destination."
                            : "Wake alarm is armed.\nWe'll wake you up within 500 meters.",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ===========================
          // Journey Details
          // ===========================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Journey Details",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                _InfoRow(
                  title: "Current Station",
                  value: currentStation,
                ),

                const SizedBox(height: 10),

                _InfoRow(
                  title: "Next Station",
                  value: nextStation,
                ),

                const SizedBox(height: 10),

                _InfoRow(
                  title: "Remaining Stops",
                  value: remainingStops == 1
                      ? "1 Stop"
                      : "$remainingStops Stops",
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: _InfoTile(
                  title: "ETA",
                  value: !locationReady
                      ? "--"
                      : etaMinutes >= 60
                          ? "${etaMinutes ~/ 60} h ${etaMinutes % 60} min"
                          : "$etaMinutes min",
                  icon: Icons.schedule,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _InfoTile(
                  title: "Distance",
                  value: !locationReady
                      ? "--"
                      : distanceMeters >= 1000
                          ? "${(distanceMeters / 1000).toStringAsFixed(1)} km"
                          : "${distanceMeters.round()} m",
                  icon: Icons.route,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),


          PrimaryButton(
            label: "Cancel Alarm",
            icon: const Icon(Icons.close),
            onPressed: () async {
              await AlarmService.instance.stop();
              onCancel();
            },
          ),

        ],
      ),
    ),
  ),
);
}

}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(icon),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Text(title),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.bodyMedium,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
