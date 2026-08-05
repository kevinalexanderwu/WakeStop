class TripSummary {
  const TripSummary({
    required this.destination,
    required this.distanceMeters,
    required this.durationMinutes,
    required this.triggerDistance,
  });

  final String destination;
  final double distanceMeters;
  final int durationMinutes;
  final double triggerDistance;
}