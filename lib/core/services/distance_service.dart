import 'package:geolocator/geolocator.dart';

class DistanceService {
  const DistanceService();

  double calculate({
    required double currentLat,
    required double currentLng,
    required double destinationLat,
    required double destinationLng,
  }) {
    return Geolocator.distanceBetween(
      currentLat,
      currentLng,
      destinationLat,
      destinationLng,
    );
  }
}