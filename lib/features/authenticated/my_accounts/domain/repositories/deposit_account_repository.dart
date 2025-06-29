import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/deposit_account_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/get_account_details_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/get_my_accounts_usecase.dart';

abstract class DepositAccountRepository {
  ResultFuture<List<DepositAccountEntity>> getMyAccounts(
    GetMyAccountsProps props,
  );

  ResultFuture<DepositAccountEntity> getAccountDetails(
    GetAccountDetailsProps props,
  );
}
