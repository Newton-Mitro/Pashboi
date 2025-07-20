import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/loan_payment/data/datasources/loan_payment_remote_datasource.dart';
import 'package:pashboi/features/authenticated/loan_payment/domain/entities/loan_payment_entity.dart';
import 'package:pashboi/features/authenticated/loan_payment/domain/repositories/loan_payment_repository.dart';
import 'package:pashboi/features/authenticated/loan_payment/domain/usecases/fetch_loan_payment_usecase.dart';

class LoanPaymentRepositoryImpl implements LoanPaymentRepository {
  final LoanPaymentRemoteDataSource loanPaymentRemoteDataSource;
  final NetworkInfo networkInfo;

  LoanPaymentRepositoryImpl({
    required this.loanPaymentRemoteDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<LoanPaymentEntity> fetchLoanPayment(
    FetchLoanPaymentProps props,
  ) async {
    try {
      final result = await loanPaymentRemoteDataSource.fetchLoanPayment(props);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
