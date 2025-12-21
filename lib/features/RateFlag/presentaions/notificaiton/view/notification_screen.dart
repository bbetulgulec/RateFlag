import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/presentaions/notificaiton/cubit/notification_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/notificaiton/cubit/notification_state.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<NotificationCubit>().askPermission();
      context.read<NotificationCubit>().loadNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.notifications.isNotEmpty) {
            return ListView.builder(
              itemCount: state.notifications.length,
              itemBuilder: (context, index) {
                final n = state.notifications[index];
                return ListTile(
                  title: Text(n.title),
                  subtitle: Text(n.body),
                  trailing: Text(
                    "${n.createdAt.hour}:${n.createdAt.minute}",
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              },
            );
          }

          return const Center(child: Text("Bildirim izni reddedildi ❌"));
        },
      ),
    );
  }
}
