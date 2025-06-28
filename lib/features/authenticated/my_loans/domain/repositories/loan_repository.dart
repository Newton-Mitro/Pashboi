import 'package:pashboi/features/authenticated/my_loans/domain/entities/loan_account_entity.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/entities/loan_transaction_entity.dart';
import 'package:pashboi/features/authenticated/sureties/domain/entities/surety_entity.dart';

abstract class LoanRepository {
  Future<List<LoanAccountEntity>> getMyLoans();
  Future<LoanAccountEntity?> getLoanDetails(int id);
  Future<String> createInstantLoanAccount(LoanAccountEntity loanAccount);
  Future<String> createProductLoanAccount(LoanAccountEntity loanAccount);
  Future<List<SuretyEntity>> getLoanSureties(int id);
  Future<List<LoanTransactionEntity>> getLoanStatement(int id);
  Future<void> getEligibleCollateralAccounts(int id);
  Future<void> getEligibleLoanProducts(int id);
  Future<void> getLoanAgainstProductInterest(int id);
}
