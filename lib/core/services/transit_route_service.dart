import 'package:latlong2/latlong.dart';
import 'package:wakestop/data/models/station.dart';

class TransitRouteService {
  const TransitRouteService();

  /// Mendapatkan titik-titik polyline untuk perjalanan transit.
  ///
  /// Saat ini mendukung perjalanan dalam jalur yang sama,
  /// misalnya MRT North-South.
  List<LatLng> getRoute({
    required List<Station> stations,
    required Station origin,
    required Station destination,
  }) {
    // Harus menggunakan mode transportasi yang sama.
    if (origin.mode.toLowerCase() != destination.mode.toLowerCase()) {
      return [];
    }

    // Harus berada pada line yang sama.
    if (origin.line.toLowerCase() != destination.line.toLowerCase()) {
      return [];
    }

    // Ambil semua stasiun dalam mode dan line yang sama.
    final routeStations = stations.where((station) {
      return station.mode.toLowerCase() ==
              origin.mode.toLowerCase() &&
          station.line.toLowerCase() ==
              origin.line.toLowerCase();
    }).toList();

    if (routeStations.isEmpty) {
      return [];
    }

    // Urutkan berdasarkan nomor pada ID.
    //
    // Contoh:
    // mrt_001
    // mrt_002
    // mrt_003
    routeStations.sort(
      (a, b) => _stationOrder(a).compareTo(_stationOrder(b)),
    );

    final originIndex = routeStations.indexWhere(
      (station) => station.id == origin.id,
    );

    final destinationIndex = routeStations.indexWhere(
      (station) => station.id == destination.id,
    );

    if (originIndex == -1 || destinationIndex == -1) {
      return [];
    }

    final startIndex =
        originIndex < destinationIndex
            ? originIndex
            : destinationIndex;

    final endIndex =
        originIndex > destinationIndex
            ? originIndex
            : destinationIndex;

    final selectedStations = routeStations
        .sublist(startIndex, endIndex + 1)
        .toList();

    // Jika perjalanan menuju arah urutan yang lebih kecil,
    // balik urutan polyline.
  if (originIndex > destinationIndex) {
    return selectedStations
        .reversed
        .map(
          (station) => LatLng(
            station.latitude,
            station.longitude,
          ),
        )
        .toList();
  }

    return selectedStations
        .map(
          (station) => LatLng(
            station.latitude,
            station.longitude,
          ),
        )
        .toList();
  }

  /// Mengambil angka urutan dari ID station.
  ///
  /// Contoh:
  /// mrt_001 -> 1
  /// mrt_012 -> 12
  int _stationOrder(Station station) {
    final match = RegExp(r'(\d+)$').firstMatch(station.id);

    if (match == null) {
      return 999999;
    }

    return int.tryParse(match.group(1)!) ?? 999999;
  }
}