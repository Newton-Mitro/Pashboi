part of 'payment_service_bloc.dart';

sealed class PaymentServiceState extends Equatable {
  const PaymentServiceState();

  @override
  List<Object> get props => [];
}

final class PaymentServiceInitial extends PaymentServiceState {}

final class PaymentServiceLoading extends PaymentServiceState {}

final class PaymentServiceLoaded extends PaymentServiceState {
  final List<ServiceEntity> services;
  const PaymentServiceLoaded(this.services);
}

final class PaymentServiceError extends PaymentServiceState {
  final String message;
  const PaymentServiceError(this.message);
}
