import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakestop/data/models/station.dart';

class TripState {
  const TripState({
    this.origin,
    this.destination,

    this.currentStation,
    this.nextStation,
    this.remainingStops = 0,
    this.startedAt,
    this.distanceMeters = 0,
    this.initialDistance = 0,
    this.isActive = false,
    this.locationReady = false,
  });

  final Station? origin;
  final Station? destination;
  final bool isActive;
  final double distanceMeters;
  final bool locationReady;
  final double initialDistance;
  final Station? currentStation;
  final Station? nextStation;
  final int remainingStops;
  final DateTime? startedAt;

  TripState copyWith({
    Station? origin,
    Station? destination,
    DateTime? startedAt,
    bool? isActive,
    bool? locationReady,
    double? distanceMeters,
    double? initialDistance,
    Station? currentStation,
    Station? nextStation,
    int? remainingStops,
  }) {
    return TripState(
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      isActive: isActive ?? this.isActive,
      startedAt: startedAt ?? this.startedAt,
      distanceMeters: distanceMeters ?? this.distanceMeters,
      initialDistance: initialDistance ?? this.initialDistance,
      locationReady: locationReady ?? this.locationReady,
      currentStation: currentStation ?? this.currentStation,
      nextStation: nextStation ?? this.nextStation,
      remainingStops: remainingStops ?? this.remainingStops,
    );
  }
}

class TripNotifier extends StateNotifier<TripState> {
  TripNotifier() : super(const TripState());

void startTrip({
  required List<Station> stations,
  required Station origin,
  required Station destination,
  required double initialDistance,
}) {

  final originIndex = stations.indexOf(origin);
  final destinationIndex = stations.indexOf(destination);

  final remainingStops =
      (destinationIndex - originIndex).abs();

  final nextStation =
      originIndex + 1 < stations.length
          ? stations[originIndex + 1]
          : destination;

  state = TripState(
    origin: origin,
    destination: destination,

    currentStation: origin,
    nextStation: nextStation,
    remainingStops: remainingStops,

    distanceMeters: initialDistance,
    initialDistance: initialDistance,
    startedAt: DateTime.now(),
    locationReady: true,
    isActive: true,
    
  );
}
  void debugNextStation() {  }

  void debugPreviousStation() {
  }
  void updateCurrentStation({
    required List<Station> stations,
    required Station current,
  }) {
    if (!state.isActive) return;

    final currentIndex = stations.indexOf(current);

    final destinationIndex =
        stations.indexOf(state.destination!);

    final next =
        currentIndex + 1 < stations.length
            ? stations[currentIndex + 1]
            : state.destination;

    final remaining =
        (destinationIndex - currentIndex).abs();

    state = state.copyWith(
      currentStation: current,
      nextStation: next,
      remainingStops: remaining,
    );
  }
  void updateDistance(double distance) {
    if (!state.isActive) return;

    state = state.copyWith(
      distanceMeters: distance,
      locationReady: true,
      initialDistance: state.initialDistance == 0
          ? distance
          : state.initialDistance,
    );
  }

  void stopTrip() {
    state = const TripState();
  }
}

final tripProvider =
    StateNotifierProvider<TripNotifier, TripState>(
  (ref) => TripNotifier(),
);