import 'package:wakestop/data/models/station.dart';

class TripEngine {
  static int remainingStops({
    required List<Station> stations,
    required Station current,
    required Station destination,
  }) {
    final currentIndex =
        stations.indexWhere((s) => s.id == current.id);

    final destinationIndex =
        stations.indexWhere((s) => s.id == destination.id);

    if (currentIndex == -1 || destinationIndex == -1) {
      return 0;
    }

    return (destinationIndex - currentIndex).abs();
  }

  static bool hasArrived({
    required Station current,
    required Station destination,
  }) {
    return current.id == destination.id;
  }
}