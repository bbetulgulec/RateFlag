import 'package:rate_flag/features/RateFlag/domain/model/user.dart';

class FollowListState {
  final bool isLoading;
  final List<User> users;

  const FollowListState({this.isLoading = false, this.users = const []});

  FollowListState copyWith({bool? isLoading, List<User>? users}) {
    return FollowListState(
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
    );
  }
}
