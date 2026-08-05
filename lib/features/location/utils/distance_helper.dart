import 'package:geolocator/geolocator.dart';

class DistanceHelper {
  static double distanceInMeters({
    required double startLat,
    required double startLng,
    required double endLat,
    required double endLng,
  }) {
    return Geolocator.distanceBetween(
      startLat,
      startLng,
      endLat,
      endLng,
    );
  }

  static double distanceInKm({
    required double startLat,
    required double startLng,
    required double endLat,
    required double endLng,
  }) {
    return distanceInMeters(
          startLat: startLat,
          startLng: startLng,
          endLat: endLat,
          endLng: endLng,
        ) /
        1000;
  }
}