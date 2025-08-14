import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/entities/search_employee_entity.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/repositories/search_employee_repository.dart';

class SearchEmployee extends BaseRequestProps {
  final String searchText;

  const SearchEmployee({
    required this.searchText,
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class SearchEmployeeUseCase
    extends UseCase<List<SearchEmployeeEntity>, SearchEmployee> {
  final SearchEmployeeRepository repositoryInterface;

  SearchEmployeeUseCase({required this.repositoryInterface});

  @override
  ResultFuture<List<SearchEmployeeEntity>> call(SearchEmployee props) async {
    return repositoryInterface.getSearchEmployee(props);
  }
}
