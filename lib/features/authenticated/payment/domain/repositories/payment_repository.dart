import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/payment/domain/entities/service_entity.dart';
import 'package:pashboi/features/authenticated/payment/domain/usecases/fetch_payment_services_usecase.dart';
import 'package:pashboi/features/authenticated/payment/domain/usecases/submit_payment_usecase.dart';

abstract class PaymentRepository {
  ResultFuture<String> submitPayment(SubmitPaymentProps props);
  ResultFuture<List<ServiceEntity>> fetchPaymentServices(
    FetchPaymentServicesProps props,
  );
}
