import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const android = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings = InitializationSettings(
      android: android,
    );

    await _notifications.initialize(settings);
    await _notifications
    .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
    ?.requestNotificationsPermission();
  }

  Future<void> showWakeAlarm({
    required String stationName,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'wake_alarm_channel',
      'Wake Alarm',
      channelDescription: 'Notification before destination arrival',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(
      android: androidDetails,
    );

    await _notifications.show(
      100,
      'WakeStop',
      'Next station: $stationName',
      details,
    );
  }
}