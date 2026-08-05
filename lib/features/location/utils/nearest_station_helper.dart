import 'package:wakestop/data/models/station.dart';

import 'distance_helper.dart';

class NearestStationHelper {
  static Station? findNearest({
    required double latitude,
    required double longitude,
    required List<Station> stations,
  }) {
    if (stations.isEmpty) return null;

    Station nearest = stations.first;

    double nearestDistance = DistanceHelper.distanceInMeters(
      startLat: latitude,
      startLng: longitude,
      endLat: nearest.latitude,
      endLng: nearest.longitude,
    );

    for (final station in stations.skip(1)) {
      final distance = DistanceHelper.distanceInMeters(
        startLat: latitude,
        startLng: longitude,
        endLat: station.latitude,
        endLng: station.longitude,
      );

      if (distance < nearestDistance) {
        nearest = station;
        nearestDistance = distance;
      }
    }

    return nearest;
  }
}