import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/agm_counter/domain/entities/agm_counter_entity.dart';
import 'package:pashboi/features/authenticated/agm_counter/domain/repositories/agm_counter_repository.dart';
import 'package:pashboi/features/authenticated/sureties/domain/entities/surety_entity.dart';
import 'package:pashboi/features/authenticated/sureties/domain/repositories/surety_repository.dart';

class FetchAGMCounterInfoProps extends BaseRequestProps {
  final String accountNo;

  const FetchAGMCounterInfoProps({
    required this.accountNo,
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class FetchAGMCounterInfoUseCase
    extends UseCase<AGMCounterEntity, FetchAGMCounterInfoProps> {
  final AGMCounterRepository agmCounterRepository;

  FetchAGMCounterInfoUseCase({required this.agmCounterRepository});

  @override
  ResultFuture<AGMCounterEntity> call(FetchAGMCounterInfoProps props) async {
    return agmCounterRepository.fetchAGMCounterInfo(props);
  }
}
