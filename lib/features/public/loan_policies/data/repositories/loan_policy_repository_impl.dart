import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/public/loan_policies/data/data_sources/local_datasource.dart';
import 'package:pashboi/features/public/loan_policies/data/data_sources/remote_datasource.dart';
import 'package:pashboi/features/public/loan_policies/domain/entites/loan_policy_entity.dart';
import 'package:pashboi/features/public/loan_policies/domain/repositories/loan_policy_repository.dart';
import 'package:pashboi/features/public/loan_policies/domain/usecases/fetch_loan_policy_usecase.dart';

class LoanPolicyRepositoryImpl implements LoanPolicyRepository {
  final LoanPolicyRemoteDataSource loanPolicyRemoteDataSource;
  final NetworkInfo networkInfo;
  final LoanPolicyLocalDataSource loanPolicyLocalDataSource;

  LoanPolicyRepositoryImpl({
    required this.loanPolicyRemoteDataSource,
    required this.networkInfo,
    required this.loanPolicyLocalDataSource,
  });

  @override
  ResultFuture<List<LoanPolicyEntity>> findLoanPoliciesByCategoryId(
    FetchLoanPolicyProps props,
  ) async {
    try {
      if (!await networkInfo.isConnected) {
        final localResult =
            await loanPolicyLocalDataSource.fetchLoanPoliciesByCategoryId();

        return Right(localResult);
      }
      final result = await loanPolicyRemoteDataSource
          .fetchLoanPoliciesByCategoryId(props);
      await loanPolicyLocalDataSource.storeLoanPolicies(result);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
