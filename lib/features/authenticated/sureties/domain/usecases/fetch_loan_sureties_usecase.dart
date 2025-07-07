import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/sureties/domain/entities/surety_entity.dart';
import 'package:pashboi/features/authenticated/sureties/domain/repositories/surety_repository.dart';

class FetchLoanSuretiesProps extends BaseRequestProps {
  final String loanNumber;

  const FetchLoanSuretiesProps({
    required this.loanNumber,
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class FetchLoanSuretiesUseCase
    extends UseCase<List<SuretyEntity>, FetchLoanSuretiesProps> {
  final SuretyRepository suretyRepository;

  FetchLoanSuretiesUseCase({required this.suretyRepository});

  @override
  ResultFuture<List<SuretyEntity>> call(FetchLoanSuretiesProps props) async {
    return suretyRepository.fetchLoanSureties(props);
  }
}
