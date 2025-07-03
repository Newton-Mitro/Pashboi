import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/deposit_account_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/fetch_operating_accounts_usecase.dart';

part 'fetch_operating_accounts_event.dart';
part 'fetch_operating_accounts_state.dart';

class FetchOperatingAccountsBloc
    extends Bloc<FetchOperatingAccountsEvent, FetchOperatingAccountsState> {
  final GetAuthUserUseCase getAuthUserUseCase;
  final FetchOperatingAccountsUseCase fetchOperatingAccountUseCase;
  FetchOperatingAccountsBloc({
    required this.getAuthUserUseCase,
    required this.fetchOperatingAccountUseCase,
  }) : super(FetchOperatingAccountsInitial()) {
    on<FetchOperatingAccountsEvent>((event, emit) async {
      emit(FetchOperatingAccountsLoading());

      try {
        final authUser = await getAuthUserUseCase.call(NoParams());
        UserEntity? user;

        authUser.fold(
          (left) {
            emit(
              FetchOperatingAccountsError('Failed to load user information'),
            );
          },
          (right) {
            user = right.user;
          },
        );

        if (user == null) {
          emit(FetchOperatingAccountsError('User not found'));
          return;
        }

        final dataState = await fetchOperatingAccountUseCase.call(
          FetchOperatingAccountsProps(
            email: user!.loginEmail,
            userId: user!.userId,
            rolePermissionId: user!.roleId,
            personId: user!.personId,
            employeeCode: user!.employeeCode,
            mobileNumber: user!.regMobile,
            dependentPersonId: event.dependentPersonId,
          ),
        );

        dataState.fold(
          (failure) {
            emit(FetchOperatingAccountsError(failure.message));
          },
          (myAccounts) {
            emit(FetchOperatingAccountsLoaded(myAccounts));
          },
        );
      } catch (e) {
        emit(FetchOperatingAccountsError('Failed to load debit card'));
      }
    });
  }
}
