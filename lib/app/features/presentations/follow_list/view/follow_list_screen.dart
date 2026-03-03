import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/app/common/constants/text_constant.dart';
import 'package:rate_flag/core/get_it/service_locator.dart';
import 'package:rate_flag/app/features/presentations/follow_list/cubit/follow_list_cubit.dart';
import 'package:rate_flag/app/features/presentations/follow_list/cubit/follow_list_state.dart';
import 'package:rate_flag/app/features/presentations/follow_list/widget/follow_user_tile.dart';

class FollowListScreen extends StatelessWidget {
  final List<String> userIds;
  final String title;

  const FollowListScreen({
    super.key,
    required this.userIds,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FollowListCubit>()..loadUsers(userIds),
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: BlocBuilder<FollowListCubit, FollowListState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.users.isEmpty) {
              return const Center(child: Text(TextConstants.dontHaveUser));
            }

            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];

                return FollowUserTile(
                  fullName: "${user.firstName} ${user.lastName}",
                  photoUrl: user.photoUrl,
                  onTap: () {},
                );
              },
            );
          },
        ),
      ),
    );
  }
}
