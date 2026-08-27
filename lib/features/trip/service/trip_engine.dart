import 'package:wakestop/data/models/station.dart';

class TripEngine {
  /// Mengambil semua stasiun yang berada pada mode dan line yang sama,
  /// kemudian mengurutkannya berdasarkan urutan jalur sebenarnya.
  static List<Station> getRouteStations({
    required List<Station> stations,
    required Station current,
    required Station destination,
  }) {
    if (current.mode != destination.mode ||
        current.line != destination.line) {
      return [];
    }

    final lineStations = stations
        .where(
          (station) =>
              station.mode == current.mode &&
              station.line == current.line,
        )
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));

    final currentIndex =
        lineStations.indexWhere((station) => station.id == current.id);

    final destinationIndex =
        lineStations.indexWhere((station) => station.id == destination.id);

    if (currentIndex == -1 || destinationIndex == -1) {
      return [];
    }

    final startIndex = currentIndex < destinationIndex
        ? currentIndex
        : destinationIndex;

    final endIndex = currentIndex < destinationIndex
        ? destinationIndex
        : currentIndex;

    final route = lineStations.sublist(startIndex, endIndex + 1);

    // Pastikan urutan selalu dari posisi user menuju tujuan.
    if (currentIndex > destinationIndex) {
      return route.reversed.toList();
    }

    return route;
  }

  /// Menghitung jumlah pemberhentian dari current station ke destination.
  static int remainingStops({
    required List<Station> stations,
    required Station current,
    required Station destination,
  }) {
    final routeStations = getRouteStations(
      stations: stations,
      current: current,
      destination: destination,
    );

    if (routeStations.length <= 1) {
      return 0;
    }

    return routeStations.length - 1;
  }

  static bool hasArrived({
    required Station current,
    required Station destination,
  }) {
    return current.id == destination.id;
  }
}