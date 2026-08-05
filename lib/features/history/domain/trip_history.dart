class TripHistory {
  const TripHistory({
    required this.destination,
    required this.line,
    required this.date,
  });

  final String destination;
  final String line;
  final DateTime date;
}