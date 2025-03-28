import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotifyService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  // ignore: prefer_final_fields
  bool _initialized = false;

  bool get initialized => _initialized;

  Future<void> init() async {
    if (initialized) return;

    tz.initializeTimeZones();
    final String currnetTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currnetTimeZone));

    const initsettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const initsettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initsettings = InitializationSettings(
      android: initsettingsAndroid,
      iOS: initsettingsIOS,
    );

    await notificationsPlugin.initialize(initsettings);
  }

  NotificationDetails notificationDetails(Color color) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        importance: Importance.max,
        priority: Priority.high,
        color: color,
        colorized: true,
        icon: '@mipmap/ic_launcher',
        audioAttributesUsage: AudioAttributesUsage.notification,
        playSound: true,
        enableVibration: true,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required Color color,
  }) async {
    await notificationsPlugin.show(id, title, body, notificationDetails(color));
  }

  Future<void> scheduleNotification({
    required int id,
    required Color color,
    required String title,
    required String body,
    required int year,
    required int month,
    required int day,
    required int hour,
    required int minute,
  }) async {
    var scheduledDate = tz.TZDateTime(tz.local, year, month, day, hour, minute);

    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails(color),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  Future<void> cancelAll() async {
    await notificationsPlugin.cancelAll();
  }

  Future<void> cancel(int id) async {
    await notificationsPlugin.cancel(id);
  }
}
