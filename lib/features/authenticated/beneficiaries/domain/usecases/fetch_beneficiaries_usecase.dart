import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/entities/beneficiary_entity.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/repositories/beneficiary_repository.dart';

class FetchBeneficiariesProps extends BaseRequestProps {
  const FetchBeneficiariesProps({
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class FetchBeneficiariesUseCase
    extends UseCase<List<BeneficiaryEntity>, FetchBeneficiariesProps> {
  final BeneficiaryRepository beneficiaryRepository;

  FetchBeneficiariesUseCase({required this.beneficiaryRepository});

  @override
  ResultFuture<List<BeneficiaryEntity>> call(
    FetchBeneficiariesProps props,
  ) async {
    return beneficiaryRepository.fetchBeneficiaries(props);
  }
}
