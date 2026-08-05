import '../datasource/station_local_datasource.dart';
import '../models/station.dart';

class StationRepository {
  StationRepository(this._localDataSource);

  final StationLocalDataSource _localDataSource;

  Future<List<Station>> getStations() {
    return _localDataSource.loadStations();
  }
}