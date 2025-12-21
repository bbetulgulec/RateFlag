import 'package:rate_flag/features/RateFlag/domain/entity/app_notification.dart';

abstract class NotificationPermissionRepository {
  Future<void> init();
  Future<bool> requestPermission();
  Future<void> showNotification({required String title, required String body});
  Future<List<AppNotification>> getNotifications();
}
