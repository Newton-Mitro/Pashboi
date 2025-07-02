import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/repositories/beneficiary_repository.dart';

class AddBeneficiaryProps extends BaseRequestProps {
  final String beneficiaryName;
  final String beneficiaryAccountNumber;

  const AddBeneficiaryProps({
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
    required this.beneficiaryName,
    required this.beneficiaryAccountNumber,
  });
}

class AddBeneficiaryUseCase extends UseCase<String, AddBeneficiaryProps> {
  final BeneficiaryRepository beneficiaryRepository;

  AddBeneficiaryUseCase({required this.beneficiaryRepository});

  @override
  ResultFuture<String> call(AddBeneficiaryProps props) async {
    return beneficiaryRepository.addBeneficiary(props);
  }
}
