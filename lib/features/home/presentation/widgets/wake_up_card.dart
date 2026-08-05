import 'package:flutter/material.dart';

import 'package:wakestop/shared/widgets/app_bottom_sheet_shell.dart';
import 'package:wakestop/shared/widgets/buttons/primary_button.dart';

class WakeUpCard extends StatelessWidget {
  const WakeUpCard({
    super.key,
    required this.station,
    required this.onStopAlarm,
  });

  final String station;
  final VoidCallback onStopAlarm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBottomSheetShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.notifications_active,
            color: Colors.orange,
            size: 64,
          ),

          const SizedBox(height: 20),

          Text(
            "Wake Up!",
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "Next station",
            style: theme.textTheme.titleMedium,
          ),

          const SizedBox(height: 8),

          Text(
            station,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "Your destination is next.\nPlease prepare to get off.",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge,
          ),

          const SizedBox(height: 28),

          PrimaryButton(
            label: "Stop Alarm",
            icon: const Icon(Icons.check),
            onPressed: onStopAlarm,
          ),
        ],
      ),
    );
  }
}