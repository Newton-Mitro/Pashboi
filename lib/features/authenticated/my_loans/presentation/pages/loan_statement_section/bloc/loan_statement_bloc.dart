import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/entities/loan_transaction_entity.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/usecases/fetch_loan_statement_usecase.dart';

part 'loan_statement_event.dart';
part 'loan_statement_state.dart';

class LoanStatementBloc extends Bloc<LoanStatementEvent, LoanStatementState> {
  final FetchLoanStatementUseCase fetchLoanStatementUseCase;
  final GetAuthUserUseCase getAuthUserUseCase;

  LoanStatementBloc({
    required this.fetchLoanStatementUseCase,
    required this.getAuthUserUseCase,
  }) : super(LoanStatementInitial()) {
    on<FetchLoanStatementEvent>((event, emit) async {
      emit(LoanStatementLoading());

      try {
        final authUser = await getAuthUserUseCase.call(NoParams());
        UserEntity? user;

        authUser.fold(
          (left) {
            emit(LoanStatementError('Failed to load user information'));
          },
          (right) {
            user = right.user;
          },
        );

        if (user == null) {
          emit(LoanStatementError('User not found'));
          return;
        }

        final dataState = await fetchLoanStatementUseCase.call(
          FetchLoanStatementProps(
            email: user!.loginEmail,
            userId: user!.userId,
            rolePermissionId: user!.roleId,
            personId: user!.personId,
            employeeCode: user!.employeeCode,
            mobileNumber: user!.regMobile,
            loanNumber: event.loanNumber,
          ),
        );

        dataState.fold(
          (failure) {
            emit(LoanStatementError(failure.message));
          },
          (transactions) {
            emit(LoanStatementSuccess(transactions));
          },
        );
      } catch (e) {
        emit(LoanStatementError('Failed to load debit card'));
      }
    });
  }
}
