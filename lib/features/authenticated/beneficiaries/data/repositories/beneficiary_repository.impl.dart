import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/beneficiaries/data/datasources/remote.datasource.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/entities/beneficiary_entity.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/repositories/beneficiary_repository.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/usecases/add_beneficiary_usecase.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/usecases/fetch_beneficiaries_usecase.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/usecases/remove_beneficiary_usecase.dart';

class BeneficiaryRepositoryImpl implements BeneficiaryRepository {
  final BeneficiaryRemoteDataSource beneficiaryRemoteDataSource;
  final NetworkInfo networkInfo;

  BeneficiaryRepositoryImpl({
    required this.beneficiaryRemoteDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<List<BeneficiaryEntity>> fetchBeneficiaries(
    FetchBeneficiariesProps props,
  ) async {
    try {
      final result = await beneficiaryRemoteDataSource.fetchBeneficiaries(
        props,
      );
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<String> addBeneficiary(AddBeneficiaryProps props) async {
    try {
      final result = await beneficiaryRemoteDataSource.addBeneficiary(props);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<String> removeBeneficiary(RemoveBeneficiaryProps props) async {
    try {
      final result = await beneficiaryRemoteDataSource.removeBeneficiary(props);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
