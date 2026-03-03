
import 'package:rate_flag/app/features/data/domain/repositories/notification_permission_repository.dart';

class LocalServices {
  final NotificationPermissionRepository repository;

  LocalServices(this.repository);

  Future<bool> call() {
    return repository.requestPermission();
  }
}
