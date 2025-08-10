import 'dart:async';
import 'dart:math';

import 'package:pashboi/features/authenticated/deposit/data/datasources/remote.datasource.dart';
import 'package:pashboi/features/authenticated/deposit/domain/entities/bkash_payment_entity.dart';
import 'package:pashboi/features/authenticated/deposit/domain/entities/voucher_entity.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/fetch_bkash_service_charge_usecase.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/fetch_scheduled_deposits_usecase.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/submit_deposit_from_bkash_usecase.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/submit_deposit_later_usecase.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/submit_deposit_now_usecase.dart';

class MockDepositRemoteDataSource implements DepositRemoteDataSource {
  final _random = Random();

  @override
  Future<String> submitDepositNow(SubmitDepositNowProps props) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return "MOCK_DEPOSIT_NOW_${_random.nextInt(9999)}";
  }

  @override
  Future<List<DepositRequestEntity>> fetchScheduledDeposits(
    FetchScheduledDepositsProps props,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      DepositRequestEntity(
        depositDate: DateTime.now().add(const Duration(days: 35)),
        status: "Pending",
        requestdBy: 'John Doe',
        requestDate: DateTime.now(),
        transactionType: 'DepositRequest',
        transactionMethod: 'Account',
        transactions: [],
      ),
      DepositRequestEntity(
        depositDate: DateTime.now().add(const Duration(days: 62)),
        status: "Pending",
        requestdBy: 'John Doe',
        requestDate: DateTime.now(),
        transactionType: 'DepositRequest',
        transactionMethod: 'Account',
        transactions: [],
      ),
    ];
  }

  @override
  Future<String> submitDepositLater(SubmitDepositLaterProps props) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return "MOCK_DEPOSIT_LATER_${_random.nextInt(9999)}";
  }

  @override
  Future<BkashPaymentEntity> submitDepositFromBkash(
    SubmitDepositFromBkashProps props,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return BkashPaymentEntity(
      statusCode: '0000',
      statusMessage: 'Successful',
      paymentId: 'TR0011ON1565154754797',
      bkashUrl:
          'https://payment.bkash.com/?paymentId=TR00116H21MdQ1754825196690&hash=3InfI0lt1o*SeUfUK.um*jBlu942Z!I7KBCMEtXhSKx6hsefJnby*5W9LY(h3QYUe_43yby)s-yre3_SY*5VPTiIUGuxIkpidOu01754825196690&mode=0011&apiVersion=v1.2.0-beta/',
      callbackUrl: '',
      successCallbackUrl:
          'http://172.16.200.15:9981/Home/bKashPaymentResponse?paymentID=TR0011ON1565154754797&status=success',
      failureCallbackUrl:
          'http://172.16.200.15:9981/Home/bKashPaymentResponse?paymentID=TR0011ON1565154754797&status=failure',
      cancelledCallbackUrl:
          'http://172.16.200.15:9981/Home/bKashPaymentResponse?paymentID=TR0011ON1565154754797&status=cancel',
      amount: '500',
      intent: 'sale',
      currency: 'BDT',
      paymentCreateTime: '2019-08-07T11:12:34:978 GMT+0600',
      transactionStatus: 'Initiated',
      merchantInvoiceNumber: 'Inv0124',
    );
  }

  @override
  Future<double> fetchBkashServiceCharge(
    FetchBkashServiceChargeProps props,
  ) async {
    await Future.delayed(const Duration(milliseconds: 200));
    // Fake service charge: 1.85% of the amount
    return (props.amount * 0.0185);
  }
}
