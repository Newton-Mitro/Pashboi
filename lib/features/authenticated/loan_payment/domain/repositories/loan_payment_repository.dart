import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/loan_payment/domain/entities/loan_payment_entity.dart';
import 'package:pashboi/features/authenticated/loan_payment/domain/usecases/fetch_loan_payment_usecase.dart';

abstract class LoanPaymentRepository {
  ResultFuture<LoanPaymentEntity> fetchLoanPayment(FetchLoanPaymentProps props);
}
