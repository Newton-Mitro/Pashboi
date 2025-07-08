import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/openable_account_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/tenure_amount_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/tenure_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/fetch_account_tenure_amounts_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/fetch_account_tenures_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/fetch_openable_accounts_usecase.dart';

abstract class AccountUtilRepository {
  ResultFuture<List<OpenableAccountEntity>> fetchOpenableAccounts(
    FetchOpenableAccountsProps props,
  );
  ResultFuture<List<TenureAmountEntity>> fetchAccountTenureAmounts(
    FetchAccountTenureAmountsProps props,
  );
  ResultFuture<List<TenureEntity>> fetchAccountTenures(
    FetchAccountTenuresProps props,
  );
}
