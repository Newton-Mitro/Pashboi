import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/public/deposit_policies/domain/entities/deposit_product_entity.dart';
import 'package:pashboi/features/public/deposit_policies/domain/repositories/deposit_product_repository.dart';

class GetDepositProductUseCase
    implements UseCase<List<DepositProductEntity>, NoParams> {
  final DepositProductRepository depositProductRepository;

  GetDepositProductUseCase({required this.depositProductRepository});

  @override
  ResultFuture<List<DepositProductEntity>> call(NoParams p) async {
    return await depositProductRepository.getDepositProducts();
  }
}
