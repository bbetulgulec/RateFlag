import 'dart:convert';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/app_notification.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/notification_permission_repository.dart';

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
    required String title,
    required String body,
  }) async {
    // 🔔 1. Telefona bildirimi göster
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

    // 💾 2. Local DB'ye kaydet
    await _saveToLocalDb(
      AppNotification(
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

    list.insert(
      0,
      jsonEncode({
        'id': notification.id,
        'title': notification.title,
        'body': notification.body,
        'createdAt': notification.createdAt.toIso8601String(),
      }),
    );

    await prefs.setStringList(_storageKey, list);
  }

  // 📥 Bildirimleri çekmek için
  Future<List<AppNotification>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_storageKey) ?? [];

    return list.map((e) {
      final json = jsonDecode(e);
      return AppNotification(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        createdAt: DateTime.parse(json['createdAt']),
      );
    }).toList();
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
