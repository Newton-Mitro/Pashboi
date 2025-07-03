import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/entities/collection_aggregate.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/usecases/fetch_collection_ledgers_usecase.dart';

part 'collection_ledger_event.dart';
part 'collection_ledger_state.dart';

class CollectionLedgerBloc
    extends Bloc<CollectionLedgerEvent, CollectionLedgerState> {
  final FetchCollectionLedgersUseCase fetchCollectionLedgersUseCase;
  final GetAuthUserUseCase getAuthUserUseCase;

  CollectionLedgerBloc({
    required this.fetchCollectionLedgersUseCase,
    required this.getAuthUserUseCase,
  }) : super(CollectionLedgerInitial()) {
    on<FetchCollectionLedgersEvent>((event, emit) async {
      emit(CollectionLedgerLoading());

      try {
        final authUser = await getAuthUserUseCase.call(NoParams());
        UserEntity? user;

        authUser.fold(
          (left) {
            emit(CollectionLedgerError('Failed to load user information'));
          },
          (right) {
            user = right.user;
          },
        );

        if (user == null) {
          emit(CollectionLedgerError('User not found'));
          return;
        }

        final dataState = await fetchCollectionLedgersUseCase.call(
          FetchCollectionLedgersProps(
            email: user!.loginEmail,
            userId: user!.userId,
            rolePermissionId: user!.roleId,
            personId: user!.personId,
            employeeCode: user!.employeeCode,
            mobileNumber: user!.regMobile,
            searchText: event.searchText,
            moduleCode: event.moduleCode,
          ),
        );

        dataState.fold(
          (failure) {
            emit(CollectionLedgerError(failure.message));
          },
          (collectionLedgers) {
            emit(CollectionLedgerLoaded(collectionLedgers));
          },
        );
      } catch (e) {
        emit(CollectionLedgerError('Failed to load collection ledgers'));
      }
    });
  }
}
