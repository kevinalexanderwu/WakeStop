import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// User-configurable, persisted alarm preferences.
///
/// Mirrors the "Alarm" settings section in the source `SettingsScreen`
/// (Alert Distance, Alert Timing, Alarm Volume, Vibrate) and the
/// standalone `AlarmSettings` model recommended in Section 7 — Data
/// Models — "Recommended real backing models" of the architecture
/// analysis. Distinct from the per-trip `alarmEnabled` /
/// `alarmTriggerStationsBefore` fields on [TripPlan], which represent a
/// one-off override for a single trip rather than the app-wide default.
@immutable
class AlarmSettings extends Equatable {
  const AlarmSettings({
    required this.alertDistanceMeters,
    required this.alertStationsBefore,
    required this.volumePercent,
    required this.vibrate,
  });

  /// Default alarm settings, matching the source prototype's mock
  /// values ("1 km before stop", "1 station early", "80%", vibrate on).
  const AlarmSettings.defaults()
      : alertDistanceMeters = 1000,
        alertStationsBefore = 1,
        volumePercent = 80,
        vibrate = true;

  /// Distance, in meters, before the destination at which the alarm
  /// should trigger.
  final double alertDistanceMeters;

  /// Number of stations before the destination at which the alarm
  /// should trigger.
  final int alertStationsBefore;

  /// Alarm playback volume, in the range `0–100`.
  final int volumePercent;

  /// Whether the device should vibrate when the alarm triggers.
  final bool vibrate;

  AlarmSettings copyWith({
    double? alertDistanceMeters,
    int? alertStationsBefore,
    int? volumePercent,
    bool? vibrate,
  }) {
    return AlarmSettings(
      alertDistanceMeters: alertDistanceMeters ?? this.alertDistanceMeters,
      alertStationsBefore: alertStationsBefore ?? this.alertStationsBefore,
      volumePercent: volumePercent ?? this.volumePercent,
      vibrate: vibrate ?? this.vibrate,
    );
  }

  @override
  List<Object?> get props => [
        alertDistanceMeters,
        alertStationsBefore,
        volumePercent,
        vibrate,
      ];

  @override
  bool get stringify => true;
}