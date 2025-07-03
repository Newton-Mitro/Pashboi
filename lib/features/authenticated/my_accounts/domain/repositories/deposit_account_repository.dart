import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/account_transaction_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/deposit_account_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/add_operating_account_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/fetch_dependents_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/fetch_operating_accounts_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/get_account_details_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/get_account_statement_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/get_my_accounts_usecase.dart';

abstract class DepositAccountRepository {
  ResultFuture<List<DepositAccountEntity>> getMyAccounts(
    GetMyAccountsProps props,
  );

  ResultFuture<DepositAccountEntity> getAccountDetails(
    GetAccountDetailsProps props,
  );

  ResultFuture<List<DepositAccountEntity>> fetchDependents(
    FetchDependentsProps props,
  );

  ResultFuture<List<DepositAccountEntity>> fetchOperatingAccounts(
    FetchOperatingAccountsProps props,
  );

  ResultFuture<List<AccountTransactionEntity>> getAccountStatement(
    GetAccountStatementProps props,
  );

  ResultFuture<String> addOperatingAccount(AddOperatingAccountProps props);
}
