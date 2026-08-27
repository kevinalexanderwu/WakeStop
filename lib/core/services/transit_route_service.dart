import 'package:latlong2/latlong.dart';

import 'package:wakestop/data/models/station.dart';
import 'package:wakestop/features/trip/service/trip_engine.dart';

class TransitRouteService {
  TransitRouteService._();

  static final TransitRouteService instance =
      TransitRouteService._();

  /// Membuat rute transit dari current station menuju destination.
  ///
  /// Polyline dibangun dari koordinat stasiun pada jalur transportasi,
  /// bukan dari rute mobil/jalan raya.
  List<LatLng> getRoutePoints({
    required List<Station> stations,
    required Station current,
    required Station destination,
  }) {
    final routeStations = TripEngine.getRouteStations(
      stations: stations,
      current: current,
      destination: destination,
    );

    if (routeStations.isEmpty) {
      return [];
    }

    return routeStations
        .map(
          (station) => LatLng(
            station.latitude,
            station.longitude,
          ),
        )
        .toList();
  }

  /// Mengambil stasiun-stasiun yang dilalui.
  List<Station> getRouteStations({
    required List<Station> stations,
    required Station current,
    required Station destination,
  }) {
    return TripEngine.getRouteStations(
      stations: stations,
      current: current,
      destination: destination,
    );
  }

  /// Menghitung jumlah perjalanan antar-stasiun.
  int getStops({
    required List<Station> stations,
    required Station current,
    required Station destination,
  }) {
    return TripEngine.remainingStops(
      stations: stations,
      current: current,
      destination: destination,
    );
  }
}