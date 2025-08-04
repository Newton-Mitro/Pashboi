import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/personnel/leave/data/datasource/leave_type_data_source.dart';
import 'package:pashboi/features/authenticated/personnel/leave/data/model/leave_type_model.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/repositories/leave_type_repository.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/usecase/leave_type_usecase.dart';

class LeaveTypeRepositoryImpl implements LeaveTypeRepository {
  final LeaveTypeRemoteDataSource leaveTypeDataSource;
  final NetworkInfo networkInfo;

  LeaveTypeRepositoryImpl({
    required this.leaveTypeDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<List<LeaveTypeModel>> getLeaveType(LeaveTypeProps props) async {
    try {
      final result = await leaveTypeDataSource.fetchLeaveType(props);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
