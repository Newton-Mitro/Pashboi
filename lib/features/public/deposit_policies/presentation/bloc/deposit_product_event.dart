part of 'deposit_product_bloc.dart';

abstract class DepositProductEvent {
  const DepositProductEvent();
}

class GetDepositProduct extends DepositProductEvent {
  GetDepositProduct();
}
