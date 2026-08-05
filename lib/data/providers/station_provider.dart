import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../datasource/station_local_datasource.dart';
import '../models/station.dart';
import '../repository/station_repository.dart';

final stationRepositoryProvider = Provider<StationRepository>((ref) {
  return StationRepository(
    StationLocalDataSource(),
  );
});

final stationsProvider =
    FutureProvider<List<Station>>((ref) async {
  return ref.read(stationRepositoryProvider).getStations();
});