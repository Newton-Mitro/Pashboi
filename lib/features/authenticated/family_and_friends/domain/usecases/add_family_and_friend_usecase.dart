import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/repositories/family_and_friend_repository.dart';

class AddFamilyAndFriendProps extends BaseRequestProps {
  final int childPersonId;
  final String relationTypeCode;

  const AddFamilyAndFriendProps({
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
    required this.childPersonId,
    required this.relationTypeCode,
  });
}

class AddFamilyAndFriendUsecase
    extends UseCase<String, AddFamilyAndFriendProps> {
  final FamilyAndFriendRepository familyAndFriendRepository;

  AddFamilyAndFriendUsecase({required this.familyAndFriendRepository});

  @override
  ResultFuture<String> call(AddFamilyAndFriendProps params) async {
    return familyAndFriendRepository.addFamilyAndFriend(params);
  }
}
