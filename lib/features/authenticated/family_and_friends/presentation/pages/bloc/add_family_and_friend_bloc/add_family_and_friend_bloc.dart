import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/usecases/add_family_and_friend_usecase.dart';

part 'add_family_and_friend_event.dart';
part 'add_family_and_friend_state.dart';

class AddFamilyAndFriendBloc
    extends Bloc<AddFamilyAndFriendEvent, AddFamilyAndFriendState> {
  final AddFamilyAndFriendUsecase addFamilyAndFriendUseCase;
  final GetAuthUserUseCase getAuthUserUseCase;
  AddFamilyAndFriendBloc({
    required this.addFamilyAndFriendUseCase,
    required this.getAuthUserUseCase,
  }) : super(AddFamilyAndFriendInitial()) {
    on<AddFamilyAndFriendEvent>((event, emit) async {
      emit(FamilyAndFriendsRequestProcessing());
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

        final dataState = await addFamilyAndFriendUseCase.call(
          AddFamilyAndFriendProps(
            email: user!.loginEmail,
            userId: user!.userId,
            rolePermissionId: '',
            personId: user!.personId,
            employeeCode: user!.employeeCode,
            mobileNumber: user!.regMobile,
            childPersonId: event.childPersonId,
            relationTypeCode: event.relationTypeCode,
          ),
        );

        dataState.fold(
          (failure) {
            emit(FamilyAndFriendsError(failure.message));
          },
          (debitCard) {
            emit(FamilyAndFriendsRequestSuccess(debitCard));
          },
        );
      } catch (e) {
        emit(FamilyAndFriendsError('Failed to load debit card'));
      }
    });
  }
}
