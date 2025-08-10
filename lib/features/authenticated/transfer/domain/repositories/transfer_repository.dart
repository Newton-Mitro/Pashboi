import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/transfer/domain/usecases/submit_fund_transfer_usecase.dart';

abstract class TransferRepository {
  ResultFuture<String> submitFundTransfer(SubmitFundTransferProps props);
}
