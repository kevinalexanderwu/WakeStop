import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'route_stop.dart';
import 'station.dart';

/// Supported transit modes.
///
/// Mirrors the `Transport = 'KRL' | 'MRT' | 'LRT' | 'TransJakarta'` union
/// type from the source prototype (see Section 7 — Data Models —
/// Enums).
enum Transport {
  krl,
  mrt,
  lrt,
  transJakarta,
}

/// A planned (not-yet-started) trip from the rider's current location to
/// a chosen [destination], selected transit [transport], and its
/// alarm configuration.
///
/// Mirrors the `TripPlan` shape described in Section 7 — Data Models —
/// of the architecture analysis; corresponds to the local state
/// (`dest`, `transport`, derived route/stats, alarm toggle) held inside
/// the source `MapScreen` / `SelectedSheet` components.
@immutable
class TripPlan extends Equatable {
  const TripPlan({
    required this.origin,
    required this.destination,
    required this.transport,
    required this.routeStops,
    required this.distanceKm,
    required this.durationMinutes,
    required this.alarmEnabled,
    required this.alarmTriggerStationsBefore,
  });

  /// The rider's current/starting station.
  final Station origin;

  /// The chosen destination station.
  final Station destination;

  /// Selected transit mode for this trip.
  final Transport transport;

  /// Ordered list of stops between [origin] and [destination], inclusive.
  final List<RouteStop> routeStops;

  /// Total trip distance in kilometers.
  final double distanceKm;

  /// Estimated total trip duration in minutes.
  final int durationMinutes;

  /// Whether the wake-up alarm is armed for this trip.
  final bool alarmEnabled;

  /// How many stations before [destination] the alarm should trigger.
  final int alarmTriggerStationsBefore;

  TripPlan copyWith({
    Station? origin,
    Station? destination,
    Transport? transport,
    List<RouteStop>? routeStops,
    double? distanceKm,
    int? durationMinutes,
    bool? alarmEnabled,
    int? alarmTriggerStationsBefore,
  }) {
    return TripPlan(
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      transport: transport ?? this.transport,
      routeStops: routeStops ?? this.routeStops,
      distanceKm: distanceKm ?? this.distanceKm,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      alarmEnabled: alarmEnabled ?? this.alarmEnabled,
      alarmTriggerStationsBefore:
          alarmTriggerStationsBefore ?? this.alarmTriggerStationsBefore,
    );
  }

  @override
  List<Object?> get props => [
        origin,
        destination,
        transport,
        routeStops,
        distanceKm,
        durationMinutes,
        alarmEnabled,
        alarmTriggerStationsBefore,
      ];

  @override
  bool get stringify => true;
}