import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakestop/core/services/notification_service.dart';

import 'app.dart';
import 'package:wakestop/core/services/alarm_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.instance.initialize();
  await AlarmService.instance.initialize();

  runApp(
    const ProviderScope(
      child: WakeStopApp(),
    ),
  );
}