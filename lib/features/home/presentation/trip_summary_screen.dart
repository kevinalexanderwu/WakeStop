import 'package:flutter/material.dart';

class TripSummaryScreen extends StatelessWidget {
  const TripSummaryScreen({
    super.key,
    required this.destination,
    required this.distanceKm,
    required this.durationMinutes,
    required this.triggerDistance,
  });

  final String destination;
  final double distanceKm;
  final int durationMinutes;
  final double triggerDistance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trip Summary"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

            const SizedBox(height: 30),

            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 90,
            ),

            const SizedBox(height: 24),

            Text(
              "Trip Complete!",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall,
            ),

            const SizedBox(height: 32),

            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text("Destination"),
              subtitle: Text(destination),
            ),

            ListTile(
              leading: const Icon(Icons.route),
              title: const Text("Distance"),
              subtitle: Text("${distanceKm.toStringAsFixed(1)} km"),
            ),

            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text("Duration"),
              subtitle: Text("$durationMinutes minutes"),
            ),

            ListTile(
              leading: const Icon(Icons.notifications_active),
              title: const Text("Alarm Triggered"),
              subtitle: Text(
                "${triggerDistance.round()} meters before destination",
              ),
            ),

            const Spacer(),

            FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Done"),
            )
          ],
        ),
      ),
    );
  }
}