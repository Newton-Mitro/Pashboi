import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/entities/debit_card_entity.dart';
import 'package:pashboi/features/authenticated/cards/domain/usecases/get_my_card_usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/usecases/issue_debit_card_usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/usecases/lock_the_card_usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/usecases/re_issue_debit_card_usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/usecases/verify_card_pin_usecase.dart';
import 'package:pashboi/features/authenticated/user/domain/entities/user_entity.dart';

part 'debit_card_event.dart';
part 'debit_card_state.dart';

class DebitCardBloc extends Bloc<DebitCardEvent, DebitCardState> {
  final GetMyCardUseCase getMyCardUseCase;
  final IssueDebitCardUseCase issueDebitCardUseCase;
  final ReIssueDebitCardUsecase reIssueDebitCardUsecase;
  final LockTheCardUseCase lockTheCardUseCase;
  final VerifyCardPinUseCase verifyCardPinUseCase;
  final GetAuthUserUseCase getAuthUserUseCase;
  DebitCardBloc({
    required this.getMyCardUseCase,
    required this.issueDebitCardUseCase,
    required this.reIssueDebitCardUsecase,
    required this.lockTheCardUseCase,
    required this.verifyCardPinUseCase,
    required this.getAuthUserUseCase,
  }) : super(DebitCardInitial()) {
    on<DebitCardLoad>(_onLoad);
    on<DebitCardIssue>(_onIssue);
    on<DebitCardReIssue>(_onReIssue);
    on<DebitCardBlock>(_onBlock);
    on<DebitCardPinVerify>(_onPinVerify);
  }

  Future<void> _onLoad(
    DebitCardLoad event,
    Emitter<DebitCardState> emit,
  ) async {
    emit(DebitCardLoading());
    try {
      final authUser = await getAuthUserUseCase.call(NoParams());
      UserEntity? user;

      authUser.fold(
        (left) {
          emit(DebitCardError('Failed to load user information'));
        },
        (right) {
          user = right.user;
        },
      );

      if (user == null) {
        emit(DebitCardError('User not found'));
        return;
      }

      final dataState = await getMyCardUseCase.call(
        GetMyCardUseCaseProps(
          email: user!.loginEmail,
          userId: user!.userId,
          rolePermissionId: ' 56208',
          personId: user!.personId,
          employeeCode: user!.employeeCode,
          mobileNumber: user!.regMobile,
        ),
      );

      dataState.fold(
        (failure) {
          emit(DebitCardError(failure.message));
        },
        (debitCard) {
          emit(DebitCardLoadingSuccess(debitCard));
        },
      );
    } catch (e) {
      emit(DebitCardError('Failed to load debit card'));
    }
  }

  Future<void> _onIssue(
    DebitCardIssue event,
    Emitter<DebitCardState> emit,
  ) async {
    emit(DebitCardRequestProcessing());
    try {
      emit(DebitCardRequestSuccess('Card issued successfully'));
    } catch (e) {
      emit(DebitCardError('Card issue failed'));
    }
  }

  Future<void> _onReIssue(
    DebitCardReIssue event,
    Emitter<DebitCardState> emit,
  ) async {
    emit(DebitCardRequestProcessing());
    try {
      emit(DebitCardRequestSuccess('Card reissued successfully'));
    } catch (e) {
      emit(DebitCardError('Card reissue failed'));
    }
  }

  Future<void> _onBlock(
    DebitCardBlock event,
    Emitter<DebitCardState> emit,
  ) async {
    emit(DebitCardRequestProcessing());
    try {
      emit(DebitCardRequestSuccess('Card blocked successfully'));
    } catch (e) {
      emit(DebitCardError('Failed to block card'));
    }
  }

  Future<void> _onPinVerify(
    DebitCardPinVerify event,
    Emitter<DebitCardState> emit,
  ) async {
    emit(DebitCardRequestProcessing());
    try {
      emit(DebitCardRequestSuccess('PIN verified'));
    } catch (e) {
      emit(DebitCardError('PIN verification failed'));
    }
  }
}
