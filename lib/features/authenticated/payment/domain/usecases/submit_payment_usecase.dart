import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/payment/domain/repositories/payment_repository.dart';

class SubmitPaymentProps extends BaseRequestProps {
  final String otherField;

  const SubmitPaymentProps({
    required this.otherField,
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class SubmitPaymentUseCase extends UseCase<String, SubmitPaymentProps> {
  final PaymentRepository paymentRepository;

  SubmitPaymentUseCase({required this.paymentRepository});

  @override
  ResultFuture<String> call(SubmitPaymentProps props) async {
    return paymentRepository.submitPayment(props);
  }
}
