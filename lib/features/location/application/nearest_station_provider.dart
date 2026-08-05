import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wakestop/data/models/station.dart';
import 'package:wakestop/data/providers/station_provider.dart';
import 'package:wakestop/features/location/application/location_provider.dart';
import 'package:wakestop/features/location/utils/nearest_station_helper.dart';

final nearestStationProvider = FutureProvider<Station?>((ref) async {
  final stations = await ref.watch(stationsProvider.future);

  final position = ref.watch(locationProvider).value;

  if (position == null) {
    return null;
  }

  return NearestStationHelper.findNearest(
    latitude: position.latitude,
    longitude: position.longitude,
    stations: stations,
  );
});