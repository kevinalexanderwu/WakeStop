import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'station.dart';

/// Position of a [RouteStop] relative to the rider's current progress
/// along a trip.
///
/// Mirrors the `state: 'done' | 'current' | 'next' | 'dest'` values used
/// to render the mini route timeline in the source `SelectedSheet`
/// component (see Section 7 — Data Models — `RouteStop`).
enum RouteStopStatus {
  /// The rider has already passed this stop.
  done,

  /// The rider is currently at/approaching this stop.
  current,

  /// The next stop after the current one.
  next,

  /// The final destination stop of the trip.
  destination,
}

/// A single stop within an ordered trip route, annotated with its
/// progress [status] relative to the rider.
@immutable
class RouteStop extends Equatable {
  const RouteStop({
    required this.station,
    required this.status,
  });

  /// The underlying station for this route entry.
  final Station station;

  /// Where this stop sits relative to the rider's current progress.
  final RouteStopStatus status;

  RouteStop copyWith({
    Station? station,
    RouteStopStatus? status,
  }) {
    return RouteStop(
      station: station ?? this.station,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [station, status];

  @override
  bool get stringify => true;
}