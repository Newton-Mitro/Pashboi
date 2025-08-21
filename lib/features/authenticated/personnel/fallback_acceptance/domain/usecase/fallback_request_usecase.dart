import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/personnel/fallback_acceptance/domain/entities/fallback_leave_application_entites.dart';
import 'package:pashboi/features/authenticated/personnel/fallback_acceptance/domain/repositories/fallback_request_repository.dart';

class FallbackRequestUseCase extends BaseRequestProps {
  const FallbackRequestUseCase({
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class FallbackRequestUseCaseUseCase
    extends
        UseCase<
          List<FallbackLeaveApplicationEntities>,
          FallbackRequestUseCase
        > {
  final FallbackRequestRepository fallbackRequestRepository;

  FallbackRequestUseCaseUseCase({required this.fallbackRequestRepository});

  @override
  ResultFuture<List<FallbackLeaveApplicationEntities>> call(
    FallbackRequestUseCase props,
  ) async {
    return fallbackRequestRepository.getFallbackRequest(props);
  }
}
