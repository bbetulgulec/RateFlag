import 'package:equatable/equatable.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/app_notification.dart';

class NotificationState extends Equatable {
  final bool isGranted;
  final bool isLoading;
  final List<AppNotification> notifications;
  final String? error;

  const NotificationState({
    required this.isGranted,
    required this.isLoading,
    required this.notifications,
    this.error,
  });

  factory NotificationState.initial() {
    return const NotificationState(
      isGranted: false,
      isLoading: false,
      notifications: [],
    );
  }

  NotificationState copyWith({
    bool? isGranted,
    bool? isLoading,
    List<AppNotification>? notifications,
    String? error,
  }) {
    return NotificationState(
      isGranted: isGranted ?? this.isGranted,
      isLoading: isLoading ?? this.isLoading,
      notifications: notifications ?? this.notifications,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isGranted, isLoading, notifications, error];
}
