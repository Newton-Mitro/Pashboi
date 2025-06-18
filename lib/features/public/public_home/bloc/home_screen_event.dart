part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  List<Object?> get props => [];
}

class TabChanged extends HomeScreenEvent {
  final int index;

  const TabChanged(this.index);

  @override
  List<Object?> get props => [index];
}
