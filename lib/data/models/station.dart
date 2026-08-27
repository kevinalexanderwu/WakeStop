import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Station extends Equatable {
  const Station({
    required this.id,
    required this.name,
    required this.mode,
    required this.line,
    required this.latitude,
    required this.longitude,
    required this.order,
    this.eta,
  });

  final String id;
  final String name;
  final String mode;
  final String line;
  final double latitude;
  final double longitude;

  /// Urutan stasiun pada jalur transportasi.
  final int order;

  final Duration? eta;

  Station copyWith({
    String? id,
    String? mode,
    String? name,
    String? line,
    double? latitude,
    double? longitude,
    int? order,
    Duration? eta,
  }) {
    return Station(
      id: id ?? this.id,
      mode: mode ?? this.mode,
      name: name ?? this.name,
      line: line ?? this.line,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      order: order ?? this.order,
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
        order,
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
      order: (json['order'] as num?)?.toInt() ?? 0,
    );
  }
}