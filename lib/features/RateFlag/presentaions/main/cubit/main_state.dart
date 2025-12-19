import 'package:equatable/equatable.dart';

class MainState extends Equatable {
  final int currentIndex;
  const MainState({this.currentIndex = 0});

  MainState copyWith({int? currentIndex}) {
    return MainState(currentIndex: currentIndex ?? this.currentIndex);
  }

  @override
  List<Object?> get props => [currentIndex];
}
