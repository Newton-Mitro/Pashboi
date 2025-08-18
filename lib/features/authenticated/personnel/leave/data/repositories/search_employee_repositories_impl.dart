import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/personnel/leave/data/datasource/search_employee_data_source.dart';
import 'package:pashboi/features/authenticated/personnel/leave/data/model/search_employee_model.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/repositories/search_employee_repository.dart';

class SearchEmployeeRepositoriesImpl implements SearchEmployeeRepository {
  final SearchEmployeeDataSource datasourceVarName;
  final NetworkInfo networkInfo;

  SearchEmployeeRepositoriesImpl({
    required this.datasourceVarName,
    required this.networkInfo,
  });

  @override
  ResultFuture<List<SearchEmployeeModel>> getSearchEmployee(params) async {
    try {
      final result = await datasourceVarName.fetchEmployee(params);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
