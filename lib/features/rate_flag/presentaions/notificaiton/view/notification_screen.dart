import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/rate_flag/common/constants/text_constant.dart';
import 'package:rate_flag/features/rate_flag/presentaions/notificaiton/cubit/notification_cubit.dart';
import 'package:rate_flag/features/rate_flag/presentaions/notificaiton/cubit/notification_state.dart';
import 'package:rate_flag/features/rate_flag/presentaions/notificaiton/widget/notification_tile.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => context.read<NotificationCubit>()
        ..askPermission()
        ..loadNotifications(),
      child: Scaffold(
        appBar: AppBar(title: const Text(TextConstants.notficationTitle)),
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
                  return NotificationTile(title: n.title, body: n.body);
                },
              );
            }

            return const Center(
              child: Text(TextConstants.notficationPermissonEror),
            );
          },
        ),
      ),
    );
  }
}
