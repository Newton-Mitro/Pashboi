import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/deposit_account_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/get_my_accounts_usecase.dart';

part 'my_account_event.dart';
part 'my_account_state.dart';

class MyAccountBloc extends Bloc<MyAccountEvent, MyAccountState> {
  final GetMyAccountsUseCase getMyAccountsUseCase;
  final GetAuthUserUseCase getAuthUserUseCase;

  MyAccountBloc({
    required this.getMyAccountsUseCase,
    required this.getAuthUserUseCase,
  }) : super(MyAccountInitial()) {
    on<FetchMyAccountEvent>((event, emit) async {
      emit(MyAccountLoading());

      try {
        final authUser = await getAuthUserUseCase.call(NoParams());
        UserEntity? user;

        authUser.fold(
          (left) {
            emit(MyAccountError('Failed to load user information'));
          },
          (right) {
            user = right.user;
          },
        );

        if (user == null) {
          emit(MyAccountError('User not found'));
          return;
        }

        final dataState = await getMyAccountsUseCase.call(
          GetMyAccountsProps(
            email: user!.loginEmail,
            userId: user!.userId,
            rolePermissionId: "6,1,1210",
            personId: user!.personId,
            employeeCode: user!.employeeCode,
            mobileNumber: user!.regMobile,
            accountHolderPersonId:
                event.accountHolderPersonId == 0
                    ? user!.personId
                    : event.accountHolderPersonId,
          ),
        );

        dataState.fold(
          (failure) {
            emit(MyAccountError(failure.message));
          },
          (myAccounts) {
            emit(MyAccountSuccess(myAccounts));
          },
        );
      } catch (e) {
        emit(MyAccountError('Failed to load debit card'));
      }
    });
  }
}
