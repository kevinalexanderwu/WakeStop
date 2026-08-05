import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakestop/data/models/station.dart';

final selectedDestinationProvider =
    StateProvider<Station?>((ref) => null);