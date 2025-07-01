import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/sureties/domain/entities/surety_entity.dart';
import 'package:pashboi/features/authenticated/sureties/domain/repositories/surety_repository.dart';

class FetchGivenSuretiesProps extends BaseRequestProps {
  const FetchGivenSuretiesProps({
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class FetchGivenSuretiesUseCase
    extends UseCase<List<SuretyEntity>, FetchGivenSuretiesProps> {
  final SuretyRepository suretyRepository;

  FetchGivenSuretiesUseCase({required this.suretyRepository});

  @override
  ResultFuture<List<SuretyEntity>> call(FetchGivenSuretiesProps props) async {
    return suretyRepository.fetchGivenSureties(props);
  }
}
