import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/withdraw/domain/usecases/generate_withdrawl_qr_usecase.dart';

abstract class WithdrawlRepository {
  ResultFuture<String> generateWithdrawlQr(GenerateWithdrawlQrProps props);
}
