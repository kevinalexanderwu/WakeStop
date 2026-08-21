import 'package:supabase_flutter/supabase_flutter.dart';


class TripService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String> startTrip({
    required String destinationName,
    required String transportType,
    required double destinationLat,
    required double destinationLng,
    required double alarmDistance,
  }) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception('User belum login');
    }

    final response = await _supabase
        .from('trips')
        .insert({
          'user_id': user.id,
          'destination_name': destinationName,
          'transport_type': transportType,
          'destination_lat': destinationLat,
          'destination_lng': destinationLng,
          'alarm_distance': alarmDistance,
          'status': 'active',
        })
        .select('id')
        .single();

    return response['id'] as String;
  }

  Future<void> cancelTrip(String tripId) async {
    await _supabase
        .from('trips')
        .update({
          'status': 'cancelled',
          'ended_at': DateTime.now().toIso8601String(),
        })
        .eq('id', tripId);
  }

  Future<void> completeTrip(String tripId) async {
    await _supabase
        .from('trips')
        .update({
          'status': 'completed',
          'ended_at': DateTime.now().toIso8601String(),
        })
        .eq('id', tripId);
  }
}