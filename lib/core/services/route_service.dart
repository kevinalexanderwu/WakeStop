import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../config/api_keys.dart';

class RouteService {
  Future<List<LatLng>> getRoute({
    required LatLng start,
    required LatLng end,
  }) async {
    final uri = Uri.parse(
      "https://graphhopper.com/api/1/route"
      "?point=${start.latitude},${start.longitude}"
      "&point=${end.latitude},${end.longitude}"
      "&profile=car"
      "&points_encoded=false"
      "&key=${ApiKeys.graphHopperApiKey}",
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception("Failed to load route");
    }

    final data = jsonDecode(response.body);

    final coordinates =
        data["paths"][0]["points"]["coordinates"] as List;

    return coordinates.map((coord) {
      return LatLng(
        coord[1].toDouble(),
        coord[0].toDouble(),
      );
    }).toList();
  }
}