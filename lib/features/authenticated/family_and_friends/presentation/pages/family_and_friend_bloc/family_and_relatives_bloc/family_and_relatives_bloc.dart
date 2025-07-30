import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/entities/family_and_friend_entity.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/usecases/add_family_and_friend_usecase.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/usecases/get_family_and_friends_usecase.dart';

part 'family_and_relatives_event.dart';
part 'family_and_relatives_state.dart';

class FamilyAndRelativesBloc
    extends Bloc<FamilyAndRelativesEvent, FamilyAndRelativesState> {
  final GetFamilyAndFriendsUseCase getFamilyAndFriendsUseCase;
  final AddFamilyAndFriendUsecase addFamilyAndFriendUseCase;
  final GetAuthUserUseCase getAuthUserUseCase;

  FamilyAndRelativesBloc({
    required this.getFamilyAndFriendsUseCase,
    required this.addFamilyAndFriendUseCase,
    required this.getAuthUserUseCase,
  }) : super(const FamilyAndRelativesState()) {
    on<FetchFamilyAndRelatives>(_onFetchFamilyAndFriends);
    on<AddFamilyAndRelative>(_onAddFamilyAndFriend);
  }

  Future<UserEntity?> _getAuthenticatedUser(
    Emitter<FamilyAndRelativesState> emit,
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
    FetchFamilyAndRelatives event,
    Emitter<FamilyAndRelativesState> emit,
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
    AddFamilyAndRelative event,
    Emitter<FamilyAndRelativesState> emit,
  ) async {
    final relationTypeCode = event.relationTypeCode;
    final childPersonId = event.childPersonId;

    final Map<String, String> errors = {};

    if (event.searchAccountNumber.isEmpty) {
      errors['searchAccountNumber'] = 'Please enter search account number';
    }

    if (relationTypeCode.isEmpty) {
      errors['relationTypeCode'] = 'Please enter relationship';
    }

    if (childPersonId == 0) {
      errors['memberName'] = "Please search with a valid account number";
    }

    if (errors.isNotEmpty) {
      emit(state.copyWith(errors: errors));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null, errors: null));

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
        childPersonId: childPersonId,
        relationTypeCode: relationTypeCode,
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
            userPersonId: event.childPersonId,
            familyMemberId: event.childPersonId,
            relationName: '',
            familyMemberName: '',
            familyMemberAge: 0,
            familyMemberGender: '',
            requestStatus: '',
          ),
        );

        emit(state.copyWith(isLoading: false, familyAndFriends: updatedList));
      },
    );
  }
}
