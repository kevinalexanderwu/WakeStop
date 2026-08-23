import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../application/home_state_provider.dart';

import 'widgets/transit_map.dart';
import 'widgets/floating_search_bar.dart';
import 'widgets/map_fab.dart';
import 'widgets/transport_filter_chips.dart';
import 'widgets/trip_preview_card.dart';
import 'widgets/active_trip_card.dart';
import 'widgets/wake_up_card.dart';

import 'package:wakestop/core/services/notification_service.dart';

import 'package:wakestop/data/models/station.dart';
import 'package:wakestop/data/providers/station_provider.dart';

import 'package:wakestop/features/location/application/location_provider.dart';
import 'package:wakestop/features/location/application/nearest_station_provider.dart';

import 'package:wakestop/features/trip/application/selected_destination_provider.dart';
import 'package:wakestop/features/trip/application/trip_provider.dart';
import 'package:wakestop/features/trip/service/trip_engine.dart';

import 'dart:async';
import 'package:wakestop/core/services/alarm_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wakestop/core/services/location_service.dart';
import 'package:wakestop/core/services/distance_service.dart';
import 'package:wakestop/features/settings/providers/alarm_settings_provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:wakestop/core/services/trip_service.dart';
import 'package:go_router/go_router.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TripService _tripService = TripService();

  
  
  TransportType _selectedTransport = TransportType.all;
  final LocationService _locationService = LocationService();
  final DistanceService _distanceService = const DistanceService();
  final MapController _mapController = MapController();
  
  bool _alarmTriggered = false;
  double? _alarmTriggerDistance;
  Timer? _demoTimer;
  StreamSubscription<Position>? _locationSubscription;
  String? _activeTripId;
  @override
  void initState() {
    super.initState();
    _listenLocation();

    Future.microtask(() {
      ref.read(locationProvider.notifier).start();
    });
  }
  void _listenLocation() async {
    final granted = await _locationService.requestPermission();

    if (!granted) return;

    _locationSubscription =
        _locationService.getPositionStream().listen((position) async {
      print(
          "📍 LOCATION UPDATE: ${position.latitude}, ${position.longitude}",
        );
      final trip = ref.read(tripProvider);
      if (!trip.isActive || trip.destination == null) {
        return;
      }

      final distance = _distanceService.calculate(
        currentLat: position.latitude,
        currentLng: position.longitude,
        destinationLat: trip.destination!.latitude,
        destinationLng: trip.destination!.longitude,
      );

      ref.read(tripProvider.notifier).updateDistance(distance);
      
      print("📏 Distance: ${distance.toStringAsFixed(1)} m");

      
    final triggerDistance = ref.read(alarmDistanceProvider);

    if (!_alarmTriggered && distance <= triggerDistance) {
      print("🚨 ALARM CONDITION MET");

      _alarmTriggered = true;

      _alarmTriggerDistance = distance;

      debugPrint("🔔 SHOW NOTIFICATION");

      await NotificationService.instance.showWakeAlarm(
        stationName: trip.destination!.name,
      );

      print("🔊 PLAY ALARM");

      await AlarmService.instance.play();

      debugPrint("✅ ALARM PLAY FINISHED");
    }
    });
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    _demoTimer?.cancel();
    super.dispose();
  }

  void _updateTripCurrentStation(
    List<Station> stations,
    Station? currentStation,
  ) {
    if (currentStation == null) return;

    ref.read(tripProvider.notifier).updateCurrentStation(
      stations: stations,
      current: currentStation,
    );
  }
  void _startDemo() {
    _demoTimer?.cancel();

    final trip = ref.read(tripProvider);

    if (!trip.isActive) return;

    double distance = trip.distanceMeters;

    _alarmTriggered = false;

    _demoTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        distance -= 120;

        if (distance < 0) {
          distance = 0;
        }

        ref.read(tripProvider.notifier).updateDistance(distance);

        if (!_alarmTriggered && distance <= 500) {
          _alarmTriggered = true;

          await NotificationService.instance.showWakeAlarm(
            stationName: trip.destination?.name ?? "",
          );

          await AlarmService.instance.play();
        }

        if (distance <= 0) {
          timer.cancel();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    
    final state = ref.watch(homeStateProvider);

    final stationsAsync = ref.watch(stationsProvider);

    final location = ref.watch(locationProvider);

    ref.listen<AsyncValue<Position?>>(
      locationProvider,
      (previous, next) {
        next.whenData((position) async {
          debugPrint("🔥 LOCATION LISTENER CALLED");
          if (position == null) return;

          final trip = ref.read(tripProvider);

          if (!trip.isActive || trip.destination == null) return;

          final distance = _distanceService.calculate(
            currentLat: position.latitude,
            currentLng: position.longitude,
            destinationLat: trip.destination!.latitude,
            destinationLng: trip.destination!.longitude,
          );

          ref.read(tripProvider.notifier).updateDistance(distance);

          if (!_alarmTriggered && distance <= 500) {
            _alarmTriggered = true;

            await NotificationService.instance.showWakeAlarm(
              stationName: trip.destination!.name,
            );

            await AlarmService.instance.play();
          }
        });
      },
    );
    
    final selectedDestination =
        ref.watch(selectedDestinationProvider);

    final nearestStation =
        ref.watch(nearestStationProvider);

    final trip = ref.watch(tripProvider);
    double progress = 0.0;

    if (trip.initialDistance > 0) {
      progress = 1 - (trip.distanceMeters / trip.initialDistance);

      progress = progress.clamp(0.0, 1.0);
    }

    const averageSpeedKmh = 35.0;

    final eta = ((trip.distanceMeters / 1000) / averageSpeedKmh * 60).round();

    ref.listen(
      nearestStationProvider,
      (previous, next) {
        next.whenData((station) {
          stationsAsync.whenData((stations) {
            _updateTripCurrentStation(
              stations,
              station,
            );
          });
        });
      },
    );

    ref.listen(
      tripProvider,
      (previous, next) {
        if (!next.isActive) return;

        if (
          next.isActive &&
          next.initialDistance > 0 &&
          next.distanceMeters <= 20
        ) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Arrived"),
              content: Text(
                "Welcome to ${next.destination?.name ?? "your destination"}",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    final trip = ref.read(tripProvider);

                    final duration = DateTime.now()
                        .difference(trip.startedAt!)
                        .inMinutes;
                      
                    print(duration);
                    Navigator.pop(context);

                    ref.read(homeStateProvider.notifier).reset();
                  },
                  child: const Text("Finish"),
                ),
              ],
            ),
          );
        }
      },
    );

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: TransitMap(
              mapController: _mapController,
              userLocation: location.value == null
                  ? null
                  : LatLng(
                      location.value!.latitude,
                      location.value!.longitude,
                    ),
              destination: selectedDestination == null
                  ? null
                  : LatLng(
                      selectedDestination.latitude,
                      selectedDestination.longitude,
                    ),
              selectedTransport: _selectedTransport,
            ),
          ),
      
          FloatingSearchBar(
            onTap: () async {
              final result = await context.push('/search');

              if (result == null) return;

              final station = result as Station;

              ref.read(selectedDestinationProvider.notifier).state =
                  station;

              ref
                  .read(homeStateProvider.notifier)
                  .selectDestination();
            },
          ),

          Positioned(
            top: 16,
            right: 16,
            child: SafeArea(
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                elevation: 4,
                child: IconButton(
                  icon: const Icon(
                    Icons.person_outline_rounded,
                    color: Colors.black87,
                  ),
                  tooltip: 'Account',
                  onPressed: () {
                    context.push('/account');
                  },
                ),
              ),
            ),
          ),

          Positioned(
            top: 16,
            right: 16,
            child: SafeArea(
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                elevation: 4,
                child: IconButton(
                  icon: const Icon(
                    Icons.history_rounded,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    context.push('/trip-history');
                  },
                ),
              ),
            ),
          ),

          TransportFilterChips(
            selected: _selectedTransport,
            onSelected: (transport) {
              setState(() {
                _selectedTransport = transport;
              });
            },
          ),
          MapFab(
            onPressed: () {
              final current = location.value;

              if (current == null) return;

              _mapController.move(
                LatLng(
                  current.latitude,
                  current.longitude,
                ),
                17,
              );
            },
          ),

          if (state != HomeViewState.searching)
            Align(
              alignment: Alignment.bottomCenter,
              child: stationsAsync.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),

                error: (e, _) => Center(
                  child: Text("Error: $e"),
                ),

                data: (stations) {
                  final previewStops =
                      selectedDestination == null
                          ? 0
                          : TripEngine.remainingStops(
                              stations: stations,
                              current:
                                  nearestStation.value ??
                                      stations.first,
                              destination:
                                  selectedDestination,
                            );

                  return AnimatedSwitcher(
                    duration: const Duration(
                      milliseconds: 250,
                    ),

                    child: switch (state) {
                      HomeViewState.idle =>
                        const SizedBox.shrink(),

                      HomeViewState.searching =>
                        const SizedBox.shrink(),

                      HomeViewState.destinationSelected =>
                        TripPreviewCard(
                          origin:
                              nearestStation.value ??
                                  stations.first,

                          destination:
                              selectedDestination ??
                                  stations.first,

                          stops: previewStops,

                          onStartAlarm: () async {
                            final destination = selectedDestination;

                            if (destination == null) {
                              return;
                            }

                            try {
                              final origin =
                                  nearestStation.value ?? stations.first;

                              final position = await Geolocator.getCurrentPosition();

                              final distance = Geolocator.distanceBetween(
                                position.latitude,
                                position.longitude,
                                destination.latitude,
                                destination.longitude,
                              );

                              // Simpan perjalanan ke Supabase
                              _activeTripId = await _tripService.startTrip(
                                destinationName: destination.name,
                                transportType: destination.line,
                                destinationLat: destination.latitude,
                                destinationLng: destination.longitude,
                                alarmDistance: ref.read(alarmDistanceProvider),
                              );

                              // Mulai perjalanan di aplikasi
                              ref.read(tripProvider.notifier).startTrip(
                                stations: stations,
                                origin: origin,
                                destination: destination,
                                initialDistance: distance,
                              );

                              // Ubah tampilan menjadi active trip
                              ref.read(homeStateProvider.notifier).startTrip();

                              // Jika sudah dekat dengan destinasi
                              if (distance <= ref.read(alarmDistanceProvider)) {
                                _alarmTriggered = true;

                                await NotificationService.instance.showWakeAlarm(
                                  stationName: destination.name,
                                );

                                await AlarmService.instance.play();
                              }

                              debugPrint('Trip berhasil disimpan: $_activeTripId');
                            } catch (e) {
                              debugPrint('Gagal memulai trip: $e');

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Gagal menyimpan perjalanan: $e',
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                        ),

                      HomeViewState.activeTrip =>
                        ActiveTripCard(

                          currentStation:
                              trip.currentStation?.name ?? "-",

                          nextStation:
                              trip.nextStation?.name ?? "-",

                          remainingStops:
                              trip.remainingStops,
                          destination:
                              trip.destination?.name ??
                                  "-",
                          line:
                              trip.destination?.line ??
                                  "-",
                          locationReady: trip.locationReady,
                          progress: progress,
                          distanceMeters: trip.distanceMeters,
                          etaMinutes: eta,
                          onCancel: () async {
                            try {
                              // Stop alarm
                              await AlarmService.instance.stop();

                              // Update perjalanan di Supabase
                              if (_activeTripId != null) {
                                await _tripService.cancelTrip(_activeTripId!);

                                debugPrint(
                                  'Trip dibatalkan: $_activeTripId',
                                );

                                _activeTripId = null;
                              }

                              // Stop perjalanan lokal
                              ref
                                  .read(tripProvider.notifier)
                                  .stopTrip();

                              // Hapus destinasi
                              ref
                                  .read(selectedDestinationProvider.notifier)
                                  .state = null;

                              setState(() {
                                _alarmTriggered = false;
                              });

                              // Kembali ke home
                              ref
                                  .read(homeStateProvider.notifier)
                                  .reset();
                            } catch (e) {
                              debugPrint('Gagal membatalkan trip: $e');
                            }
                          },

                          onDebugPrevious: () {
                            ref
                                .read(
                                  tripProvider.notifier,
                                )
                                .debugPreviousStation();
                          },

                          onDebugNext: () async {
                            ref
                                .read(
                                  tripProvider.notifier,
                                )
                                .debugNextStation();

                            await NotificationService
                                .instance
                                .showWakeAlarm(
                              stationName:
                                  trip.destination?.name ??
                                      "Destination",
                            );
                          },
                        ),

                      HomeViewState.wakeUp =>
                        WakeUpCard(
                          station:
                              trip.destination?.name ??
                                  "",

                          onStopAlarm: () {
                            ref
                                .read(
                                  tripProvider.notifier,
                                )
                                .stopTrip();

                            ref
                                .read(
                                  homeStateProvider
                                      .notifier,
                                )
                                .showIdle();
                          },
                        ),

                      HomeViewState.arriving =>
                        const _ArrivalSheet(),
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _ArrivalSheet extends StatelessWidget {
  const _ArrivalSheet();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Material(
            elevation: 12,
            borderRadius: BorderRadius.circular(28),
            color: Colors.green,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.notifications_active,
                    color: Colors.white,
                    size: 54,
                  ),

                  const SizedBox(height: 18),

                  Text(
                    "Almost There!",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Prepare to get off at the next station.",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 24),

                  FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.check),
                    label: const Text("OK"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}