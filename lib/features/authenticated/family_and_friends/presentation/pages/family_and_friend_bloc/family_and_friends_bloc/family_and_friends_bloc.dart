import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/entities/family_and_friend_entity.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/usecases/add_family_and_friend_usecase.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/usecases/get_family_and_friends_usecase.dart';

part 'family_and_friends_event.dart';
part 'family_and_friends_state.dart';

class FamilyAndFriendsBloc
    extends Bloc<FamilyAndFriendsEvent, FamilyAndFriendsState> {
  final GetFamilyAndFriendsUseCase getFamilyAndFriendsUseCase;
  final AddFamilyAndFriendUsecase addFamilyAndFriendUseCase;
  final GetAuthUserUseCase getAuthUserUseCase;

  FamilyAndFriendsBloc({
    required this.getFamilyAndFriendsUseCase,
    required this.addFamilyAndFriendUseCase,
    required this.getAuthUserUseCase,
  }) : super(const FamilyAndFriendsState()) {
    on<FetchFamilyAndFriends>(_onFetchFamilyAndFriends);
    on<AddFamilyAndFriend>(_onAddFamilyAndFriend);
  }

  Future<UserEntity?> _getAuthenticatedUser(
    Emitter<FamilyAndFriendsState> emit,
  ) async {
    final authUser = await getAuthUserUseCase.call(NoParams());
    return authUser.fold((failure) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Failed to load user information',
        ),
      );
      return null;
    }, (success) => success.user);
  }

  Future<void> _onFetchFamilyAndFriends(
    FetchFamilyAndFriends event,
    Emitter<FamilyAndFriendsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    final user = await _getAuthenticatedUser(emit);
    if (user == null) return;

    final result = await getFamilyAndFriendsUseCase.call(
      GetFamilyAndFriendsProps(
        email: user.loginEmail,
        userId: user.userId,
        rolePermissionId: '',
        personId: user.personId,
        employeeCode: user.employeeCode,
        mobileNumber: user.regMobile,
        includeSelf: false,
      ),
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (familyAndFriends) => emit(
        state.copyWith(isLoading: false, familyAndFriends: familyAndFriends),
      ),
    );
  }

  Future<void> _onAddFamilyAndFriend(
    AddFamilyAndFriend event,
    Emitter<FamilyAndFriendsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    final user = await _getAuthenticatedUser(emit);
    if (user == null) return;

    final result = await addFamilyAndFriendUseCase.call(
      AddFamilyAndFriendProps(
        email: user.loginEmail,
        userId: user.userId,
        rolePermissionId: user.roleId,
        personId: user.personId,
        employeeCode: user.employeeCode,
        mobileNumber: user.regMobile,
        childPersonId: event.childPersonId,
        relationTypeCode: event.relationTypeCode,
      ),
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        final updatedList = List<FamilyAndFriendEntity>.from(
          state.familyAndFriends,
        )..add(
          FamilyAndFriendEntity(
            id: Random().nextInt(1000000),
            relationName: event.relationship,
            userPersonId: event.childPersonId,
            familyMemberId: event.childPersonId,
            familyMemberName: event.memberName,
            familyMemberAge: 1,
            familyMemberGender: event.gender,
            requestStatus: 'Pending For Approval',
          ),
        );

        emit(state.copyWith(isLoading: false, familyAndFriends: updatedList));
      },
    );
  }
}
