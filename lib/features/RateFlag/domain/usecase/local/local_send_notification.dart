import 'package:rate_flag/features/RateFlag/domain/repositories/notification_permission_repository.dart';

class LocalSendNotification {
  final NotificationPermissionRepository repository;
  LocalSendNotification(this.repository);

  Future<void> call({required String title, required String body}) {
    return repository.showNotification(title: title, body: body);
  }
}
