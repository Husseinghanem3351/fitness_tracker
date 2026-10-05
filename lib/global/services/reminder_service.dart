import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../features/Home/data/cache_helper.dart';

class ReminderService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(settings);
    
    // Request Android 13+ permission
    final androidImplementation =
        _notificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidImplementation != null) {
      await androidImplementation.requestNotificationsPermission();
    }
  }

  static Future<void> showInstantNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'zelora_channel',
      'Zelora Health Reminders',
      channelDescription: 'Reminders for water and meal tracking',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await _notificationsPlugin.show(
      0,
      title,
      body,
      details,
    );
  }

  static bool isWaterReminderEnabled() {
    return CacheHelper.getData(key: 'waterReminderEnabled') ?? true;
  }

  static bool isMealReminderEnabled() {
    return CacheHelper.getData(key: 'mealReminderEnabled') ?? true;
  }

  static Future<void> toggleWaterReminder(bool enable) async {
    await CacheHelper.putData(key: 'waterReminderEnabled', value: enable);
    if (!enable) {
      await _notificationsPlugin.cancel(100);
    } else {
      await showInstantNotification(
        title: "💧 Water Reminders Active",
        body: "Zelora will remind you to drink water and stay hydrated!",
      );
    }
  }

  static Future<void> toggleMealReminder(bool enable) async {
    await CacheHelper.putData(key: 'mealReminderEnabled', value: enable);
    if (!enable) {
      await _notificationsPlugin.cancel(200);
    } else {
      await showInstantNotification(
        title: "🥗 Meal Reminders Active",
        body: "Zelora will remind you to log your meals every day!",
      );
    }
  }
}
