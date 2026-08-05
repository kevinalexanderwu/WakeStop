import 'package:flutter/material.dart';

import '../../domain/trip_history.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
    required this.trip,
  });

  final TripHistory trip;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.history),
      ),
      title: Text(trip.destination),
      subtitle: Text(trip.line),
      trailing: Text(
        "${trip.date.day}/${trip.date.month}",
      ),
    );
  }
}