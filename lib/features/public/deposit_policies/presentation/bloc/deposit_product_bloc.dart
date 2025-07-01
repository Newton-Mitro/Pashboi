import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/public/deposit_policies/domain/entities/deposit_product_entity.dart';
import 'package:pashboi/features/public/deposit_policies/domain/usecases/get_deposit_product.dart';

part 'deposit_product_event.dart';
part 'deposit_product_state.dart';

class DepositProductBloc
    extends Bloc<DepositProductEvent, DepositProductState> {
  final GetDepositProductUseCase getDepositProductUseCase;

  DepositProductBloc({required this.getDepositProductUseCase})
    : super(const DepositProductInitial()) {
    on<GetDepositProduct>(_onGetProduct);
  }

  Future<void> _onGetProduct(
    DepositProductEvent event,
    Emitter<DepositProductState> emit,
  ) async {
    emit(const DepositProductLoading());
    try {
      final result = await getDepositProductUseCase(NoParams());

      print(result);

      // if (result is DataSuccess<List<DepositProductEntity>>) {
      //   emit(DepositProductSuccess(depositProducts: result.data));
      // } else if (result is DataFailed) {
      //   emit(DepositProductError(result.error.toString()));
      // }
    } catch (e) {
      emit(DepositProductError('Failed to fetch products: $e'));
    }
  }
}
