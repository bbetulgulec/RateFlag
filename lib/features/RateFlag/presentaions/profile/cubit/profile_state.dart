import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final int tabIndex;

  const ProfileState({this.tabIndex = 0});

  ProfileState copyWith({int? tabIndex}) {
    return ProfileState(tabIndex: tabIndex ?? this.tabIndex);
  }

  @override
  List<Object?> get props => [tabIndex];
}
