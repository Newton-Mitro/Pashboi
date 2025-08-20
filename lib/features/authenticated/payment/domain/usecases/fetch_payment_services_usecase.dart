import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/payment/domain/entities/service_entity.dart';
import 'package:pashboi/features/authenticated/payment/domain/repositories/payment_repository.dart';

class FetchPaymentServicesProps extends BaseRequestProps {
  const FetchPaymentServicesProps({
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class FetchPaymentServicesUseCase
    extends UseCase<List<ServiceEntity>, FetchPaymentServicesProps> {
  final PaymentRepository paymentRepository;

  FetchPaymentServicesUseCase({required this.paymentRepository});

  @override
  ResultFuture<List<ServiceEntity>> call(
    FetchPaymentServicesProps props,
  ) async {
    return paymentRepository.fetchPaymentServices(props);
  }
}
