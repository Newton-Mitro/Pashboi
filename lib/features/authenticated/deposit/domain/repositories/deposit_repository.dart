import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/submit_deposit_now_usecase.dart';

abstract class DepositRepository {
  ResultFuture<String> submitDepositNow(SubmitDepositNowProps props);
  // ResultFuture<String> submitDepositLater(SubmitDepositNowProps props);
}
