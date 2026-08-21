import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:wakestop/core/services/notification_service.dart';
import 'package:wakestop/core/services/alarm_service.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://tloomottmsynrmjvhvsl.supabase.co',
    anonKey: 'sb_publishable_8iZ8GYezItxzA8rP3R6zgQ_GvsoHwaE',
  );

  await NotificationService.instance.initialize();
  await AlarmService.instance.initialize();

  runApp(
    const ProviderScope(
      child: WakeStopApp(),
    ),
  );
}