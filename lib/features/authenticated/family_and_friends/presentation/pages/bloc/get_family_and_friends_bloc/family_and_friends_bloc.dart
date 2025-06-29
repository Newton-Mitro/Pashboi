import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/entities/family_and_friend_entity.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/usecases/get_family_and_friends_usecase.dart';

part 'family_and_friends_event.dart';
part 'family_and_friends_state.dart';

class FamilyAndFriendsBloc
    extends Bloc<FamilyAndFriendsEvent, FamilyAndFriendsState> {
  final GetFamilyAndFriendsUseCase getFamilyAndFriendsUseCase;
  final GetAuthUserUseCase getAuthUserUseCase;

  FamilyAndFriendsBloc({
    required this.getFamilyAndFriendsUseCase,
    required this.getAuthUserUseCase,
  }) : super(FamilyAndFriendsInitial()) {
    on<LoadFamilyAndFriends>((event, emit) async {
      emit(FamilyAndFriendsLoading());

      try {
        final authUser = await getAuthUserUseCase.call(NoParams());
        UserEntity? user;

        authUser.fold(
          (left) {
            emit(FamilyAndFriendsError('Failed to load user information'));
          },
          (right) {
            user = right.user;
          },
        );

        if (user == null) {
          emit(FamilyAndFriendsError('User not found'));
          return;
        }

        final dataState = await getFamilyAndFriendsUseCase.call(
          GetFamilyAndFriendsProps(
            email: user!.loginEmail,
            userId: user!.userId,
            rolePermissionId: '',
            personId: user!.personId,
            employeeCode: user!.employeeCode,
            mobileNumber: user!.regMobile,
            includeSelf: false,
          ),
        );

        dataState.fold(
          (failure) {
            emit(FamilyAndFriendsError(failure.message));
          },
          (familyAndFriends) {
            emit(FamilyAndFriendsLoadingSuccess(familyAndFriends));
          },
        );
      } catch (e) {
        emit(FamilyAndFriendsError('Failed to load debit card'));
      }
    });
  }
}
