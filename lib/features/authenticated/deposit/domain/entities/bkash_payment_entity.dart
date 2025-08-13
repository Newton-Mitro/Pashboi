import 'package:pashboi/core/entities/entity.dart';

class BkashPaymentEntity extends Entity<String> {
  final String statusCode;
  final String statusMessage;
  final String paymentId;
  final String bkashUrl;
  final String callbackUrl;
  final String successCallbackUrl;
  final String failureCallbackUrl;
  final String cancelledCallbackUrl;
  final String amount;
  final String intent;
  final String currency;
  final String paymentCreateTime;
  final String transactionStatus;
  final String merchantInvoiceNumber;

  BkashPaymentEntity({
    required this.statusCode,
    required this.statusMessage,
    required this.paymentId,
    required this.bkashUrl,
    required this.callbackUrl,
    required this.successCallbackUrl,
    required this.failureCallbackUrl,
    required this.cancelledCallbackUrl,
    required this.amount,
    required this.intent,
    required this.currency,
    required this.paymentCreateTime,
    required this.transactionStatus,
    required this.merchantInvoiceNumber,
  });
}
