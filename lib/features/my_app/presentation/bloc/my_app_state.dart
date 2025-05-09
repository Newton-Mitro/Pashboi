part of 'my_app_bloc.dart';

abstract class AppStatusState extends Equatable {
  const AppStatusState();

  @override
  List<Object?> get props => [];
}

class AppStatusInitial extends AppStatusState {}

class AppStatusLoading extends AppStatusState {}

class AppStatusLoaded extends AppStatusState {
  final AppStatusEntity status;

  const AppStatusLoaded(this.status);

  @override
  List<Object?> get props => [status];
}

class AppStatusError extends AppStatusState {
  final String message;

  const AppStatusError(this.message);

  @override
  List<Object?> get props => [message];
}
