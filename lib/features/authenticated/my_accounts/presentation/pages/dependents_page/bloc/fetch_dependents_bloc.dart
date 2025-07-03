import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/deposit_account_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/fetch_dependents_usecase.dart';

part 'fetch_dependents_event.dart';
part 'fetch_dependents_state.dart';

class FetchDependentsBloc
    extends Bloc<FetchDependentsEvent, FetchDependentsState> {
  final GetAuthUserUseCase getAuthUserUseCase;
  final FetchDependentsUseCase fetchDependentsUseCase;

  FetchDependentsBloc({
    required this.getAuthUserUseCase,
    required this.fetchDependentsUseCase,
  }) : super(FetchDependentsInitial()) {
    on<FetchDependentsEvent>((event, emit) async {
      emit(FetchDependentsLoading());

      try {
        final authUser = await getAuthUserUseCase.call(NoParams());
        UserEntity? user;

        authUser.fold(
          (left) {
            emit(FetchDependentsError('Failed to load user information'));
          },
          (right) {
            user = right.user;
          },
        );

        if (user == null) {
          emit(FetchDependentsError('User not found'));
          return;
        }

        final dataState = await fetchDependentsUseCase.call(
          FetchDependentsProps(
            email: user!.loginEmail,
            userId: user!.userId,
            rolePermissionId: user!.roleId,
            personId: user!.personId,
            employeeCode: user!.employeeCode,
            mobileNumber: user!.regMobile,
            dependentPersonId: -1,
          ),
        );

        dataState.fold(
          (failure) {
            emit(FetchDependentsError(failure.message));
          },
          (myAccounts) {
            emit(FetchDependentsLoaded(myAccounts));
          },
        );
      } catch (e) {
        emit(FetchDependentsError('Failed to load debit card'));
      }
    });
  }
}
