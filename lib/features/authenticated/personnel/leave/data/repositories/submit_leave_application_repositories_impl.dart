import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/personnel/leave/data/datasource/submit_leave_application_remote_data_source.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/repositories/submit_leave_application_repository.dart';

class SubmitLeaveApplicationRepositoriesImpl
    implements SubmitLeaveApplicationRepository {
  final SubmitLeaveApplicationRemoteDataSource
  submitLeaveApplicationRemoteDataSource;
  final NetworkInfo networkInfo;

  SubmitLeaveApplicationRepositoriesImpl({
    required this.submitLeaveApplicationRemoteDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<String> submitLeaveApplication(params) async {
    try {
      final result = await submitLeaveApplicationRemoteDataSource
          .submitLeaveApplication(params);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
