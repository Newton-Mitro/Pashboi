part of 'home_screen_bloc.dart';

class HomeScreenState extends Equatable {
  final int selectedIndex;

  const HomeScreenState({required this.selectedIndex});

  HomeScreenState copyWith({int? selectedIndex}) {
    return HomeScreenState(selectedIndex: selectedIndex ?? this.selectedIndex);
  }

  @override
  List<Object?> get props => [selectedIndex];
}
