import 'package:dartz/dartz.dart';
import 'package:pashboi/core/errors/failures.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/public/loan_policies/data/data_sources/remote_datasource.dart';
import 'package:pashboi/features/public/loan_policies/domain/entites/loan_policy_entity.dart';
import 'package:pashboi/features/public/loan_policies/domain/repositories/loan_policy_repository.dart';
import 'package:pashboi/features/public/loan_policies/domain/usecases/fetch_loan_policy_usecase.dart';

class LoanPolicyRepositoryImpl implements LoanPolicyRepository {
  final LoanPolicyRemoteDataSource loanPolicyRemoteDataSource;
  final NetworkInfo networkInfo;

  LoanPolicyRepositoryImpl({
    required this.loanPolicyRemoteDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<List<LoanPolicyEntity>> findLoanPoliciesByCategoryId(
    FetchLoanPolicyProps props,
  ) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(FailureMapper.fromException(NoInternetFailure()));
      }
      final result = await loanPolicyRemoteDataSource
          .fetchLoanPoliciesByCategoryId(props);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
