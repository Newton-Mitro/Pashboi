import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/repositories/beneficiary_repository.dart';

class RemoveBeneficiaryProps extends BaseRequestProps {
  final String beneficiaryAccountNumber;

  const RemoveBeneficiaryProps({
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
    required this.beneficiaryAccountNumber,
  });
}

class RemoveBeneficiaryUseCase extends UseCase<String, RemoveBeneficiaryProps> {
  final BeneficiaryRepository beneficiaryRepository;

  RemoveBeneficiaryUseCase({required this.beneficiaryRepository});

  @override
  ResultFuture<String> call(RemoveBeneficiaryProps props) async {
    return beneficiaryRepository.removeBeneficiary(props);
  }
}
