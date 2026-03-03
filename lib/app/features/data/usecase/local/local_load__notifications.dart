import 'package:rate_flag/app/features/data/domain/repositories/notification_permission_repository.dart';
import 'package:rate_flag/app/features/data/model/app_notification.dart';

class LoadLocalNotifications {
  final NotificationPermissionRepository repository;

  LoadLocalNotifications(this.repository);

  Future<List<AppNotification>> call(String userId) {
    return repository.getNotifications(userId);
  }
}
