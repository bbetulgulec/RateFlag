import 'package:rate_flag/features/RateFlag/domain/repositories/notification_permission_repository.dart';

class LocalSendNotification {
  final NotificationPermissionRepository repository;

  LocalSendNotification(this.repository);

  Future<void> call({
    required String userId,
    required String title,
    required String body,
  }) {
    return repository.showNotification(
      userId: userId,
      title: title,
      body: body,
    );
  }
}
