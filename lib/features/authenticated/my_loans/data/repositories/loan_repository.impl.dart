import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/my_loans/data/datasources/remote.datasource.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/entities/loan_account_entity.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/entities/loan_transaction_entity.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/repositories/loan_repository.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/usecases/fetch_loan_details_usecase.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/usecases/fetch_loan_statement_usecase.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/usecases/fetch_my_loans_usecase.dart';

class LoanRepositoryImpl implements LoanRepository {
  final LoanRemoteDataSource loanRemoteDataSource;
  final NetworkInfo networkInfo;

  LoanRepositoryImpl({
    required this.loanRemoteDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<LoanAccountEntity> fetchLoanDetails(
    FetchLoanDetailsProps props,
  ) async {
    try {
      final result = await loanRemoteDataSource.fetchLoanDetails(props);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<List<LoanTransactionEntity>> fetchLoanStatement(
    FetchLoanStatementProps props,
  ) async {
    try {
      final result = await loanRemoteDataSource.fetchLoanStatement(props);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<List<LoanAccountEntity>> fetchMyLoans(
    FetchMyLoansProps props,
  ) async {
    try {
      final result = await loanRemoteDataSource.fetchMyLoans(props);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
