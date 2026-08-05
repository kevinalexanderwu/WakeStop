import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import 'package:wakestop/data/providers/station_provider.dart';
import 'package:wakestop/features/home/presentation/widgets/transport_filter_chips.dart';

import 'package:wakestop/core/services/route_service.dart';

class TransitMap extends ConsumerStatefulWidget {
  const TransitMap({
    super.key,
    required this.mapController,
    required this.userLocation,
    this.destination,
    required this.selectedTransport,
  });

  final MapController mapController;
  final LatLng? userLocation;
  final LatLng? destination;

  final TransportType selectedTransport;

  @override
  ConsumerState<TransitMap> createState() => _TransitMapState();
}

class _TransitMapState extends ConsumerState<TransitMap> {

  final RouteService _routeService = RouteService();

  List<LatLng> _routePoints = [];
  bool _hasCentered = false;
  LatLng? _lastDestination;

  @override
  void didUpdateWidget(covariant TransitMap oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.destination != null &&
        widget.destination != _lastDestination) {
      _lastDestination = widget.destination;

      WidgetsBinding.instance.addPostFrameCallback((_)async {
        final camera = CameraFit.coordinates(
          coordinates: [
            widget.userLocation!,
            widget.destination!,
          ],
          padding: const EdgeInsets.only(
            top: 80,
            left: 40,
            right: 40,
            bottom: 260, // ruang untuk Trip Preview
          ),
        );

        widget.mapController.fitCamera(camera);
        try {
          final points = await _routeService.getRoute(
            start: widget.userLocation!,
            end: widget.destination!,
          );

          if (!mounted) return;

          setState(() {
            _routePoints = points;
          });
        } catch (e) {
          debugPrint("Failed to load route: $e");
        }
      });
    }
  }

  Color _stationColor(String line) {
    final lower = line.toLowerCase();

    if (lower.contains("mrt")) {
      return Colors.red;
    }

    if (lower.contains("krl")) {
      return Colors.green;
    }

    if (lower.contains("lrt")) {
      return Colors.deepPurple;
    }

    if (lower.contains("transjakarta")) {
      return Colors.blue;
    }

    return Colors.grey;
  }

  IconData _stationIcon(String line) {
    final lower = line.toLowerCase();

    if (lower.contains("mrt")) {
      return Icons.subway;
    }

    if (lower.contains("krl")) {
      return Icons.train;
    }

    if (lower.contains("lrt")) {
      return Icons.tram;
    }

    if (lower.contains("transjakarta") ||
        lower.contains("bus")) {
      return Icons.directions_bus;
    }

    return Icons.location_on;
  }

  @override
  Widget build(BuildContext context) {
    final stationsAsync = ref.watch(stationsProvider);

    if (!_hasCentered && widget.userLocation != null) {
      WidgetsBinding.instance.addPostFrameCallback((_)async {
        widget.mapController.move(
          widget.userLocation!,
          15,
        );
      });

      _hasCentered = true;
    }

    return FlutterMap(
      mapController: widget.mapController,
      options: const MapOptions(
        initialCenter: LatLng(-6.2088, 106.8456),
        initialZoom: 12,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: "com.example.wakestop",
        ),

        if (widget.userLocation != null && widget.destination != null)
          PolylineLayer(
            polylines: [
              Polyline(
                points: _routePoints.isNotEmpty
                    ? _routePoints
                    : [
                        widget.userLocation!,
                        widget.destination!,
                      ],
                strokeWidth: 6,
                color: Colors.blue.shade600
              ),
            ],
          ),

        // ==========================
        // User Marker
        // ==========================
        if (widget.userLocation != null)
          MarkerLayer(
            markers: [
              Marker(
                point: widget.userLocation!,
                width: 28,
                height: 28,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 6,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

        if (widget.destination != null)
          MarkerLayer(
            markers: [
              Marker(
                point: widget.destination!,
                width: 36,
                height: 36,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 36,
                ),
              ),
            ],
          ),

        // ==========================
        // Station Markers (dengan filter)
        // ==========================
        stationsAsync.when(
          data: (stations) {
            final visibleStations = stations.where((station) {
              switch (widget.selectedTransport) {
                case TransportType.all:
                  return true;

                case TransportType.mrt:
                  return station.mode.toLowerCase().contains("mrt");

                case TransportType.krl:
                  return station.mode.toLowerCase().contains("krl");

                case TransportType.lrt:
                  return station.mode.toLowerCase().contains("lrt");

                case TransportType.bus:
                  return station.mode.toLowerCase().contains("transjakarta");
              }
            }).toList();

            return MarkerLayer(
              markers: visibleStations.map((station) {
                return Marker(
                  point: LatLng(
                    station.latitude,
                    station.longitude,
                  ),
                  width: 16,
                  height: 16,
                  child: Tooltip(
                    message: station.name,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: _stationColor(station.line),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                      child: Icon(
                        _stationIcon(station.line),
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
          loading: () => const MarkerLayer(
            markers: [],
          ),
          error: (_, _) => const MarkerLayer(
            markers: [],
          ),
        ),
      ],
    );
  }
}