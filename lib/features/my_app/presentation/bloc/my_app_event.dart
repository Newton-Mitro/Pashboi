part of 'my_app_bloc.dart';

sealed class MyAppEvent extends Equatable {
  const MyAppEvent();

  @override
  List<Object> get props => [];
}

// For Under Maintenance, Version Check, etc
sealed class LoadAppStatusEvent extends MyAppEvent {
  const LoadAppStatusEvent();
}
