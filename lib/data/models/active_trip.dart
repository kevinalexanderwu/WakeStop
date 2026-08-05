import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'trip_plan.dart';

/// A [TripPlan] that is currently in progress, carrying the live
/// runtime state that drives the active-trip bottom sheet and the
/// moving current-location marker.
///
/// Mirrors the `ActiveTrip (extends TripPlan at runtime)` shape from
/// Section 7 — Data Models — of the architecture analysis; corresponds
/// to the `tripProgress` state and derived stats in the source
/// `MapScreen` / `ActiveTripSheet` components. Modeled here as
/// composition over [TripPlan] rather than inheritance, to keep the
/// model immutable and `Equatable`-friendly.
@immutable
class ActiveTrip extends Equatable {
  const ActiveTrip({
    required this.plan,
    required this.progressPercent,
    required this.stopsRemaining,
    required this.etaMinutes,
    required this.distanceRemainingKm,
  });

  /// The trip plan this active trip was started from.
  final TripPlan plan;

  /// Overall trip completion, in the range `0–100`.
  final double progressPercent;

  /// Number of stops remaining before [TripPlan.destination].
  final int stopsRemaining;

  /// Estimated minutes remaining until arrival.
  final int etaMinutes;

  /// Estimated distance remaining, in kilometers.
  final double distanceRemainingKm;

  /// Whether the trip has reached the alarm-trigger threshold, i.e. the
  /// rider is now within [TripPlan.alarmTriggerStationsBefore] stops of
  /// the destination.
  bool get isArriving =>
      plan.alarmEnabled && stopsRemaining <= plan.alarmTriggerStationsBefore;

  ActiveTrip copyWith({
    TripPlan? plan,
    double? progressPercent,
    int? stopsRemaining,
    int? etaMinutes,
    double? distanceRemainingKm,
  }) {
    return ActiveTrip(
      plan: plan ?? this.plan,
      progressPercent: progressPercent ?? this.progressPercent,
      stopsRemaining: stopsRemaining ?? this.stopsRemaining,
      etaMinutes: etaMinutes ?? this.etaMinutes,
      distanceRemainingKm: distanceRemainingKm ?? this.distanceRemainingKm,
    );
  }

  @override
  List<Object?> get props => [
        plan,
        progressPercent,
        stopsRemaining,
        etaMinutes,
        distanceRemainingKm,
      ];

  @override
  bool get stringify => true;
}