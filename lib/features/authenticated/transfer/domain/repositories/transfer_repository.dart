import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/transfer/domain/usecases/submit_fund_transfer_usecase.dart';
import 'package:pashboi/features/authenticated/transfer/domain/usecases/submit_transfer_bank_to_dc_usecase.dart';
import 'package:pashboi/features/authenticated/transfer/domain/usecases/submit_transfer_to_bkash_usecase.dart';

abstract class TransferRepository {
  ResultFuture<String> submitFundTransfer(SubmitFundTransferProps props);
  ResultFuture<String> submitTransferBankToDc(
    SubmitTransferBankToDcProps props,
  );
  ResultFuture<String> submitTransferToBkash(SubmitTransferToBkashProps props);
}
