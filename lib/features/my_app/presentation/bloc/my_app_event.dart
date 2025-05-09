part of 'my_app_bloc.dart';

abstract class AppStatusEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAppStatusEvent extends AppStatusEvent {}
