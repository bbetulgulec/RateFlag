import 'package:rate_flag/features/RateFlag/domain/entity/app_notification.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/notification_permission_repository.dart';

class LoadLocalNotifications {
  final NotificationPermissionRepository repository;

  LoadLocalNotifications(this.repository);

  Future<List<AppNotification>> call(String userId) {
    return repository.getNotifications(userId);
  }
}
