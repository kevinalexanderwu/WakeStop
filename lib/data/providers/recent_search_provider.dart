import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakestop/data/models/station.dart';

class RecentSearchNotifier extends StateNotifier<List<Station>> {
  RecentSearchNotifier() : super([]);

  void add(Station station) {
    final updated = [...state];

    updated.removeWhere((e) => e.id == station.id);

    updated.insert(0, station);

    if (updated.length > 5) {
      updated.removeLast();
    }

    state = updated;
  }

  void clear() {
    state = [];
  }
}

final recentSearchProvider =
    StateNotifierProvider<RecentSearchNotifier, List<Station>>(
  (ref) => RecentSearchNotifier(),
);