part of 'surety_bloc.dart';

sealed class SuretyState extends Equatable {
  const SuretyState();

  @override
  List<Object> get props => [];
}

final class SuretyInitial extends SuretyState {}

final class SuretyLoading extends SuretyState {}

final class SuretyLoadingSuccess extends SuretyState {
  final List<SuretyEntity> sureties;
  const SuretyLoadingSuccess(this.sureties);
}

final class SuretyError extends SuretyState {
  final String error;
  const SuretyError(this.error);
}
