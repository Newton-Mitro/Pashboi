import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/features/authenticated/cards/domain/entities/debit_card_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/saving_account_entity.dart';

part 'debit_card_event.dart';
part 'debit_card_state.dart';

class DebitCardBloc extends Bloc<DebitCardEvent, DebitCardState> {
  DebitCardBloc() : super(DebitCardInitial()) {
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
      final card = DebitCardEntity(
        id: 1,
        cardsAccounts: [
          SavingAccountEntity(
            id: 1,
            number: '',
            type: '',
            typeCode: '',
            accountName: '',
            balance: 100,
            withdrawableBalance: 50,
            ledgerId: 1,
            interestReate: 3,
            accountFor: '',
            status: '',
            defaultAccount: true,
            nominees: [],
          ),
        ],
        isActive: false,
        nameOnCard: '',
        cardNumber: '',
        type: '',
        expiryDate: '',
        isVirtual: false,
        isBlock: false,
        stageCode: '',
        stageName: '',
      ); // mock example
      emit(DebitCardLoadingSuccess(card));
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
