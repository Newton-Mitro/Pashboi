import 'package:pashboi/features/authenticated/deposit/domain/entities/bkash_payment_entity.dart';

class BkashPaymentModel extends BkashPaymentEntity {
  BkashPaymentModel({
    required super.statusCode,
    required super.statusMessage,
    required super.paymentId,
    required super.bkashUrl,
    required super.callbackUrl,
    required super.successCallbackUrl,
    required super.failureCallbackUrl,
    required super.cancelledCallbackUrl,
    required super.amount,
    required super.intent,
    required super.currency,
    required super.paymentCreateTime,
    required super.transactionStatus,
    required super.merchantInvoiceNumber,
  });

  factory BkashPaymentModel.fromJson(Map<String, dynamic> json) {
    return BkashPaymentModel(
      statusCode: json['statusCode'] ?? '',
      statusMessage: json['statusMessage'] ?? '',
      paymentId: json['paymentID'] ?? '',
      bkashUrl: json['bkashURL'] ?? '',
      callbackUrl: json['callbackURL'] ?? '',
      successCallbackUrl: json['successCallbackURL'] ?? '',
      failureCallbackUrl: json['failureCallbackURL'] ?? '',
      cancelledCallbackUrl: json['cancelledCallbackURL'] ?? '',
      amount: json['amount'] ?? '',
      intent: json['intent'] ?? '',
      currency: json['currency'] ?? '',
      paymentCreateTime: json['paymentCreateTime'] ?? '',
      transactionStatus: json['transactionStatus'] ?? '',
      merchantInvoiceNumber: json['merchantInvoiceNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'statusMessage': statusMessage,
      'paymentID': paymentId,
      'bkashURL': bkashUrl,
      'callbackURL': callbackUrl,
      'successCallbackURL': successCallbackUrl,
      'failureCallbackURL': failureCallbackUrl,
      'cancelledCallbackURL': cancelledCallbackUrl,
      'amount': amount,
      'intent': intent,
      'currency': currency,
      'paymentCreateTime': paymentCreateTime,
      'transactionStatus': transactionStatus,
      'merchantInvoiceNumber': merchantInvoiceNumber,
    };
  }
}
