import 'package:pashboi/core/resources/response_state.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/user/domain/entities/user_entity.dart';
import 'package:pashboi/features/user/domain/repositories/user_profile_repository.dart';

final class SearchUsersParams {
  final int userId;
  final String searchText;
  final int startRecord;
  final int pageSize;

  SearchUsersParams({
    required this.userId,
    required this.searchText,
    required this.startRecord,
    required this.pageSize,
  });
}

class SearchUsersUseCase
    extends UseCase<DataState<List<UserEntity>>, SearchUsersParams> {
  final UserRepository userRepository;

  SearchUsersUseCase({required this.userRepository});

  @override
  Future<DataState<List<UserEntity>>> call({SearchUsersParams? params}) {
    return userRepository.searchUsers(
      params?.userId ?? 0,
      params?.searchText ?? '',
      params?.startRecord ?? 0,
      params?.pageSize ?? 10,
    );
  }
}
