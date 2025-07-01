import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/entities/beneficiary_entity.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/usecases/add_beneficiary_usecase.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/usecases/fetch_beneficiaries_usecase.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/usecases/remove_beneficiary_usecase.dart';

part 'beneficiary_event.dart';
part 'beneficiary_state.dart';

class BeneficiaryBloc extends Bloc<BeneficiaryEvent, BeneficiaryState> {
  final FetchBeneficiariesUseCase fetchBeneficiariesUseCase;
  final AddBeneficiaryUseCase addBeneficiary;
  final GetAuthUserUseCase getAuthUserUseCase;
  final RemoveBeneficiaryUseCase removeBeneficiaryUseCase;

  BeneficiaryBloc({
    required this.fetchBeneficiariesUseCase,
    required this.addBeneficiary,
    required this.getAuthUserUseCase,
    required this.removeBeneficiaryUseCase,
  }) : super(BeneficiaryInitial()) {
    on<FetchBeneficiaries>(_onFetchBeneficiaries);
    on<CreateBeneficiary>(_onCreateBeneficiary);
    on<DeleteBeneficiary>(_onDeleteBeneficiary);
  }

  Future<UserEntity?> _getAuthenticatedUser(
    Emitter<BeneficiaryState> emit,
  ) async {
    final authUser = await getAuthUserUseCase(NoParams());
    return authUser.fold((failure) {
      emit(BeneficiaryError('Failed to load user information'));
      return null;
    }, (success) => success.user);
  }

  Future<void> _onFetchBeneficiaries(
    FetchBeneficiaries event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(BeneficiaryLoading());

    final user = await _getAuthenticatedUser(emit);
    if (user == null) return;

    final dataState = await fetchBeneficiariesUseCase.call(
      FetchBeneficiariesProps(
        email: user.loginEmail,
        userId: user.userId,
        rolePermissionId: user.roleId,
        personId: user.personId,
        employeeCode: user.employeeCode,
        mobileNumber: user.regMobile,
      ),
    );

    dataState.fold(
      (failure) => emit(BeneficiaryError(failure.message)),
      (beneficiaries) => emit(BeneficiaryLoaded(beneficiaries)),
    );
  }

  Future<void> _onCreateBeneficiary(
    CreateBeneficiary event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(BeneficiaryLoading());

    final user = await _getAuthenticatedUser(emit);
    if (user == null) return;

    final result = await addBeneficiary.call(
      AddBeneficiaryProps(
        email: user.loginEmail,
        userId: user.userId,
        rolePermissionId: user.roleId,
        personId: user.personId,
        employeeCode: user.employeeCode,
        mobileNumber: user.regMobile,
        beneficiaryName: event.beneficiaryName,
        beneficiaryAccountNumber: event.accountNumber,
      ),
    );

    result.fold(
      (failure) => emit(BeneficiaryError(failure.message)),
      (_) => add(FetchBeneficiaries()), // Re-fetch updated list
    );
  }

  Future<void> _onDeleteBeneficiary(
    DeleteBeneficiary event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(BeneficiaryLoading());

    final user = await _getAuthenticatedUser(emit);
    if (user == null) return;

    final result = await removeBeneficiaryUseCase.call(
      RemoveBeneficiaryProps(
        email: user.loginEmail,
        userId: user.userId,
        rolePermissionId: user.roleId,
        personId: user.personId,
        employeeCode: user.employeeCode,
        mobileNumber: user.regMobile,
        beneficiaryAccountNumber: event.accountNumber,
      ),
    );

    result.fold(
      (failure) => emit(BeneficiaryError(failure.message)),
      (_) => add(FetchBeneficiaries()), // Re-fetch updated list
    );
  }
}
