import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/public/deposit_policies/data/data_sources/deposit_product_local_data_source.dart';
import 'package:pashboi/features/public/deposit_policies/data/data_sources/deposit_product_remote_data_source.dart';
import 'package:pashboi/features/public/deposit_policies/domain/entities/deposit_product_entity.dart';
import 'package:pashboi/features/public/deposit_policies/domain/repositories/deposit_product_repository.dart';

class DepositProductRepositoryImpl implements DepositProductRepository {
  final DepositProductRemoteDataSource depositProductRemoteDataSource;
  final DepositProductLocalDataSource depositProductLocalDataSource;
  final NetworkInfo networkInfo;

  DepositProductRepositoryImpl({
    required this.depositProductRemoteDataSource,
    required this.depositProductLocalDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<List<DepositProductEntity>> getDepositProducts() async {
    try {
      final result =
          await depositProductRemoteDataSource.getDepositProductsDataSource();
      await depositProductLocalDataSource.saveDepositProducts(result);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
