import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/submit_deposit_from_bkash_usecase.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/submit_deposit_later_usecase.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/submit_deposit_now_usecase.dart';

abstract class DepositRepository {
  ResultFuture<String> submitDepositNow(SubmitDepositNowProps props);
  ResultFuture<String> submitDepositLater(SubmitDepositLaterProps props);
  ResultFuture<String> submitDepositFromBkash(
    SubmitDepositFromBkashProps props,
  );
}
