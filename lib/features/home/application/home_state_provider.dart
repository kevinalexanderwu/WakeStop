import 'package:flutter_riverpod/flutter_riverpod.dart';

enum HomeViewState {
  idle,
  searching,
  destinationSelected,
  activeTrip,
  wakeUp,
  arriving,
}

class HomeStateNotifier extends Notifier<HomeViewState> {
  @override
  HomeViewState build() => HomeViewState.idle;

  void showSearch() {
    state = HomeViewState.searching;
  }

  void showIdle() {
    state = HomeViewState.idle;
  }

  void selectDestination() {
    state = HomeViewState.destinationSelected;
  }

  void startTrip() {
    state = HomeViewState.activeTrip;
  }

  void arrive() {
    state = HomeViewState.arriving;
  }

  void reset() {
    state = HomeViewState.idle;
  }

  void showWakeUp() {
    state = HomeViewState.wakeUp;
  }
}

final homeStateProvider =
    NotifierProvider<HomeStateNotifier, HomeViewState>(
  HomeStateNotifier.new,
);