import 'dart:convert';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rate_flag/app/features/data/domain/repositories/notification_permission_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rate_flag/app/features/data/model/app_notification.dart';

class LocalServicesImpl implements NotificationPermissionRepository {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const _storageKey = 'app_notifications';

  @override
  Future<void> init() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const iosSettings = DarwinInitializationSettings();

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(settings);
  }

  @override
  Future<void> showNotification({
    required String userId,
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'post_channel',
      'Post Notifications',
      channelDescription: 'Post sonrası bildirimler',
      importance: Importance.high,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    final id = DateTime.now().millisecondsSinceEpoch % 2147483647;

    await _plugin.show(id, title, body, details);

    await _saveToLocalDb(
      AppNotification(
        userId: userId,
        id: id.toString(),
        title: title,
        body: body,
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> _saveToLocalDb(AppNotification notification) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_storageKey) ?? [];

    list.insert(0, jsonEncode(notification.toJson()));

    await prefs.setStringList(_storageKey, list);
  }

  @override
  Future<List<AppNotification>> getNotifications(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_storageKey) ?? [];

    return list
        .map((e) => AppNotification.fromJson(jsonDecode(e)))
        .where((n) => n.userId == userId)
        .toList();
  }

  @override
  Future<bool> requestPermission() async {
    if (Platform.isAndroid) {
      final android = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();

      return await android?.requestNotificationsPermission() ?? false;
    }

    if (Platform.isIOS) {
      final ios = _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();

      return await ios?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
    }

    return false;
  }
}
