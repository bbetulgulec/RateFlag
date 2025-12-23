import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/local/local_load__notifications.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/local/local_services.dart';
import 'package:rate_flag/features/RateFlag/presentaions/notificaiton/cubit/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final LocalServices requestPermission;
  final LoadLocalNotifications loadLocalNotifications;

  NotificationCubit(this.requestPermission, this.loadLocalNotifications)
    : super(NotificationState.initial());

  /// 🔔 İzin isteme (user'dan bağımsız)
  Future<void> askPermission() async {
    emit(state.copyWith(isLoading: true));

    final granted = await requestPermission();

    emit(state.copyWith(isGranted: granted, isLoading: false));
  }

  /// 📥 User'a özel bildirimleri yükle
  Future<void> loadNotifications() async {
    emit(state.copyWith(isLoading: true));

    final uid = FirebaseAuth.instance.currentUser!.uid;

    final notifications = await loadLocalNotifications(uid);

    emit(state.copyWith(notifications: notifications, isLoading: false));
  }
}
