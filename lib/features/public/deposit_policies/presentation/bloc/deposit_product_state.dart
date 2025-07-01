part of 'deposit_product_bloc.dart';

sealed class DepositProductState extends Equatable {
  const DepositProductState();

  @override
  List<Object> get props => [];
}

class DepositProductInitial extends DepositProductState {
  const DepositProductInitial();
}

class DepositProductSuccess extends DepositProductState {
  final List<DepositProductEntity>? depositProducts;

  const DepositProductSuccess({this.depositProducts});

  @override
  List<Object> get props => [depositProducts!];
}

class DepositProductLoading extends DepositProductState {
  const DepositProductLoading();
}

class DepositProductError extends DepositProductState {
  final String error;
  DepositProductError(this.error);
}
