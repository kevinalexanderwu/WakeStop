import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/station.dart';

class StationLocalDataSource {
  Future<List<Station>> loadStations() async {
    final jsonString =
        await rootBundle.loadString('assets/data/stations.json');

    final List<dynamic> json = jsonDecode(jsonString);

    return json.map((e) => Station.fromJson(e)).toList();
  }
}