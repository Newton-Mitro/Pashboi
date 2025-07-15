import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/openable_account_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/fetch_openable_accounts_usecase.dart';

part 'openable_account_event.dart';
part 'openable_account_state.dart';

class OpenableAccountBloc
    extends Bloc<OpenableAccountEvent, OpenableAccountState> {
  final FetchOpenableAccountsUseCase fetchOpenableAccountsUseCase;
  final GetAuthUserUseCase getAuthUserUseCase;

  OpenableAccountBloc({
    required this.fetchOpenableAccountsUseCase,
    required this.getAuthUserUseCase,
  }) : super(OpenableAccountInitial()) {
    on<FetchOpenableAccountsEvent>(_onFetchOpenableAccounts);
  }

  Future<void> _onFetchOpenableAccounts(
    FetchOpenableAccountsEvent event,
    Emitter<OpenableAccountState> emit,
  ) async {
    emit(OpenableAccountLoading());

    try {
      final authUserResult = await getAuthUserUseCase.call(NoParams());

      if (authUserResult.isLeft()) {
        emit(OpenableAccountError('Failed to load user information'));
        return;
      }

      final user = authUserResult.getOrElse(() => throw Exception()).user;

      final accountsResult = await fetchOpenableAccountsUseCase.call(
        FetchOpenableAccountsProps(
          email: user.loginEmail,
          userId: user.userId,
          rolePermissionId: user.roleId,
          personId: user.personId,
          employeeCode: user.employeeCode,
          mobileNumber: user.regMobile,
        ),
      );

      accountsResult.fold(
        (failure) => emit(OpenableAccountError(failure.message)),
        (accounts) => emit(OpenableAccountSuccess(accounts)),
      );
    } catch (_) {
      emit(OpenableAccountError('Failed to load debit card'));
    }
  }
}
