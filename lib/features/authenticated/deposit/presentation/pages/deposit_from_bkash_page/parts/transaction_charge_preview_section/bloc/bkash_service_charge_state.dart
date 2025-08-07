part of 'bkash_service_charge_bloc.dart';

sealed class BkashServiceChargeState extends Equatable {
  const BkashServiceChargeState();

  @override
  List<Object> get props => [];
}

final class BkashServiceChargeInitial extends BkashServiceChargeState {}

final class BkashServiceChargeLoading extends BkashServiceChargeState {}

final class BkashServiceChargeLoaded extends BkashServiceChargeState {
  final double serviceCharge;

  const BkashServiceChargeLoaded({required this.serviceCharge});

  @override
  List<Object> get props => [serviceCharge];
}

final class BkashServiceChargeError extends BkashServiceChargeState {
  final String message;

  const BkashServiceChargeError(this.message);

  @override
  List<Object> get props => [message];
}
