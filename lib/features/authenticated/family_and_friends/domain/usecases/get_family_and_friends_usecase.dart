import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/entities/family_and_friend_entity.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/repositories/family_and_friend_repository.dart';

class GetFamilyAndFriendsProps extends BaseRequestProps {
  final bool includeSelf;
  const GetFamilyAndFriendsProps({
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
    required this.includeSelf,
  });
}

class GetFamilyAndFriendsUseCase
    extends UseCase<List<FamilyAndFriendEntity>, GetFamilyAndFriendsProps> {
  final FamilyAndFriendRepository familyAndFriendRepository;

  GetFamilyAndFriendsUseCase({required this.familyAndFriendRepository});

  @override
  ResultFuture<List<FamilyAndFriendEntity>> call(
    GetFamilyAndFriendsProps params,
  ) async {
    return familyAndFriendRepository.getFamilyAndFriends(params);
  }
}
