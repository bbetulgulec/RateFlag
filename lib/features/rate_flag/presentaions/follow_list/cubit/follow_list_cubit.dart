import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/domain/model/user.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/get_user_info.dart';
import 'package:rate_flag/features/RateFlag/presentaions/follow_list/cubit/follow_list_state.dart';

class FollowListCubit extends Cubit<FollowListState> {
  final GetUserInfo getUserInfo;

  FollowListCubit(this.getUserInfo) : super(const FollowListState());

  Future<void> loadUsers(List<String> ids) async {
    emit(state.copyWith(isLoading: true));

    final List<User> users = [];

    for (final id in ids) {
      final user = await getUserInfo.execute(id);
      if (user != null) users.add(user);
    }

    emit(state.copyWith(users: users, isLoading: false));
  }
}
