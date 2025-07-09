part of 'tenure_bloc.dart';

sealed class TenureState extends Equatable {
  const TenureState();

  @override
  List<Object> get props => [];
}

final class TenureInitial extends TenureState {}

final class TenureLoading extends TenureState {}

final class TenureSuccess extends TenureState {
  final List<TenureEntity> tenures;

  const TenureSuccess(this.tenures);

  @override
  List<Object> get props => [tenures];
}

final class TenureError extends TenureState {
  final String error;
  const TenureError(this.error);

  @override
  List<Object> get props => [error];
}
