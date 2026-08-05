import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// A single transit station/stop.
///
/// Mirrors the `Station` interface from the source prototype
/// (`{ id, name, line, eta? }`), with `eta` upgraded from a formatted
/// display string to a [Duration] so formatting stays a presentation
/// concern (see Section 7 — Data Models — of the architecture analysis).
@immutable
class Station extends Equatable {
  const Station({
    required this.id,
    required this.name,
    required this.mode,
    required this.line,
    required this.latitude,
    required this.longitude,
    this.eta,
  });
  final String mode;
  /// Stable unique identifier for the station.
  final String id;

  /// Display name, e.g. "Dukuh Atas BNI".
  final String name;

  /// Owning line name, e.g. "MRT Utara–Selatan", "KRL Bogor".
  final String line;

  final double latitude;

  final double longitude;

  /// Optional estimated time of arrival/travel time to this station.
  /// Formatted for display at the presentation layer (e.g. "12 min").
  final Duration? eta;

  Station copyWith({
    String? id,
    String? mode,
    String? name,
    String? line,
    double? latitude,
    double? longitude,
    Duration? eta,
  }) {
    return Station(
      id: id ?? this.id,
      mode: mode ?? this.mode,
      name: name ?? this.name,
      line: line ?? this.line,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      eta: eta ?? this.eta,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    mode,
    line,
    latitude,
    longitude,
    eta,
  ];

  @override
  bool get stringify => true;
  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      id: json['id'] as String,
      name: json['name'] as String,
      mode: (json['mode'] ?? 'Unknown') as String,
      line: (json['line'] ?? '') as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }
}