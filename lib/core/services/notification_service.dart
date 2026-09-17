import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:goals/controllers/goal_controller.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const int _dailyReminderId = 1001;

  static const String _channelId = 'daily_goals_reminder_channel';

  static const String _channelName = 'تذكيرات الأهداف اليومية';

  static const String _channelDescription =
      'إشعارات يومية تشجيعية لتذكيرك بمتابعة وتحديث أهدافك وإنجازاتك';

  static Future<void> init() async {
    debugPrint('🔔 NotificationService: بدء التهيئة');

    try {
      tz.initializeTimeZones();

      try {
        final timeZoneInfo = await FlutterTimezone.getLocalTimezone();

        final String timeZoneName = timeZoneInfo.identifier;

        tz.setLocalLocation(tz.getLocation(timeZoneName));

        debugPrint('🌍 Timezone: $timeZoneName');
      } catch (e) {
        debugPrint('⚠️ تعذر تحديد المنطقة الزمنية بدقة: $e');

        tz.setLocalLocation(tz.getLocation('UTC'));
      }

      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const DarwinInitializationSettings darwinSettings =
          DarwinInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
          );

      const InitializationSettings initSettings = InitializationSettings(
        android: androidSettings,
        iOS: darwinSettings,
      );

      await _notificationsPlugin.initialize(
        initSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          debugPrint('🔔 ضغط المستخدم على الإشعار: ${response.payload}');
        },
      );

      debugPrint('✅ NotificationService: تمت التهيئة بنجاح');
    } catch (e) {
      debugPrint('❌ خطأ في تهيئة NotificationService: $e');
    }
  }

  static Future<bool> requestPermissions() async {
    debugPrint('🔐 طلب صلاحية الإشعارات');

    if (kIsWeb) {
      return false;
    }

    if (Platform.isAndroid) {
      final androidImpl = _notificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();

      final bool? granted = await androidImpl?.requestNotificationsPermission();

      debugPrint('🔐 صلاحية Android: $granted');

      return granted ?? false;
    }

    if (Platform.isIOS) {
      final iosImpl = _notificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();

      final bool? granted = await iosImpl?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );

      debugPrint('🔐 صلاحية iOS: $granted');

      return granted ?? false;
    }

    return false;
  }

  static NotificationDetails _getNotificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
  }

  static Future<void> scheduleDailyReminder({
    int hour = 18,
    int minute = 40,
  }) async {
    try {
      await cancelDailyReminder();

      final GoalController controller = Get.find<GoalController>();

      final String trimmedName = controller.userName.value.trim();

      final String greetingName = trimmedName.isNotEmpty ? trimmedName : 'بطل';

      final tz.TZDateTime scheduledDate = _nextInstanceOfTime(hour, minute);

      await _notificationsPlugin.zonedSchedule(
        _dailyReminderId,
        'هدفك ينتظرك ',
        'يا $greetingName، أنجز خطوة صغيرة اليوم... فكل خطوة تقرّبك من حلمك!',
        scheduledDate,
        _getNotificationDetails(),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );

      debugPrint(
        '✅ تم تفعيل التذكير اليومي '
        'باسم ($greetingName) للساعة $hour:$minute',
      );
    } catch (e) {
      debugPrint('❌ خطأ في جدولة الإشعار: $e');
    }
  }

  static Future<void> showInstantNotification({
    required String title,
    required String body,
  }) async {
    try {
      await _notificationsPlugin.show(
        0,
        title,
        body,
        _getNotificationDetails(),
      );

      debugPrint('✅ تم إرسال الإشعار الفوري');
    } catch (e) {
      debugPrint('❌ خطأ في إرسال الإشعار الفوري: $e');
    }
  }

  static Future<void> cancelDailyReminder() async {
    try {
      await _notificationsPlugin.cancel(_dailyReminderId);

      debugPrint('🗑️ تم إلغاء التذكير اليومي');
    } catch (e) {
      debugPrint('❌ خطأ في إلغاء التذكير: $e');
    }
  }

  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }
}
