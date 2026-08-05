import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/trip_history.dart';

class HistoryNotifier extends StateNotifier<List<TripHistory>> {
  HistoryNotifier() : super(const []);

  void addTrip(TripHistory trip) {
    state = [
      trip,
      ...state,
    ];
  }

  void clear() {
    state = [];
  }
}

final historyProvider =
    StateNotifierProvider<HistoryNotifier, List<TripHistory>>(
  (ref) => HistoryNotifier(),
);