import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../service/location_service.dart';

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

final locationProvider =
    StateNotifierProvider<LocationNotifier, AsyncValue<Position?>>((ref) {
  return LocationNotifier(
    ref.read(locationServiceProvider),
  );
});

class LocationNotifier
    extends StateNotifier<AsyncValue<Position?>> {
  LocationNotifier(this._service)
      : super(const AsyncLoading());

  final LocationService _service;

  StreamSubscription<Position>? _subscription;

  Future<void> start() async {
    try {
      final allowed = await _service.ensurePermission();

      if (!allowed) {
        state = const AsyncData(null);
        return;
      }

      final first =
          await _service.getCurrentPosition();

      state = AsyncData(first);

      _subscription?.cancel();

      _subscription = _service
          .getPositionStream()
          .listen((position) {
        state = AsyncData(position);
      });
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}