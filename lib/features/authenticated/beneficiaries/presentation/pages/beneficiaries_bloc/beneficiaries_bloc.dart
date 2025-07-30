import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/entities/beneficiary_entity.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/usecases/add_beneficiary_usecase.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/usecases/fetch_beneficiaries_usecase.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/usecases/remove_beneficiary_usecase.dart';

part 'beneficiaries_event.dart';
part 'beneficiaries_state.dart';

class BeneficiariesBloc extends Bloc<BeneficiariesEvent, BeneficiariesState> {
  final FetchBeneficiariesUseCase fetchBeneficiariesUseCase;
  final AddBeneficiaryUseCase addBeneficiary;
  final GetAuthUserUseCase getAuthUserUseCase;
  final RemoveBeneficiaryUseCase removeBeneficiaryUseCase;

  BeneficiariesBloc({
    required this.fetchBeneficiariesUseCase,
    required this.addBeneficiary,
    required this.getAuthUserUseCase,
    required this.removeBeneficiaryUseCase,
  }) : super(const BeneficiariesState()) {
    on<FetchBeneficiaries>(_onFetchBeneficiaries);
    on<CreateBeneficiary>(_onCreateBeneficiary);
    on<DeleteBeneficiary>(_onDeleteBeneficiary);
  }

  Future<UserEntity?> _getAuthenticatedUser(
    Emitter<BeneficiariesState> emit,
  ) async {
    final authUser = await getAuthUserUseCase(NoParams());
    return authUser.fold((failure) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Failed to load user information',
        ),
      );
      return null;
    }, (success) => success.user);
  }

  Future<void> _onFetchBeneficiaries(
    FetchBeneficiaries event,
    Emitter<BeneficiariesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    final user = await _getAuthenticatedUser(emit);
    if (user == null) return;

    final result = await fetchBeneficiariesUseCase.call(
      FetchBeneficiariesProps(
        email: user.loginEmail,
        userId: user.userId,
        rolePermissionId: user.roleId,
        personId: user.personId,
        employeeCode: user.employeeCode,
        mobileNumber: user.regMobile,
      ),
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (beneficiaries) => emit(
        state.copyWith(
          isLoading: false,
          beneficiaries: beneficiaries,
          error: null,
        ),
      ),
    );
  }

  Future<void> _onCreateBeneficiary(
    CreateBeneficiary event,
    Emitter<BeneficiariesState> emit,
  ) async {
    final beneficiaryName = event.beneficiaryName;
    final accountNumber = event.accountNumber;

    final Map<String, String> errors = {};

    if (beneficiaryName.isEmpty) {
      errors['beneficiaryName'] = 'Please enter beneficiary name';
    }

    if (accountNumber.isEmpty) {
      errors['accountNumber'] = "Please enter search account number";
    }

    if (errors.isNotEmpty) {
      emit(state.copyWith(errors: errors));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));

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
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        final updatedList = List<BeneficiaryEntity>.from(state.beneficiaries)
          ..add(
            BeneficiaryEntity(
              id: state.beneficiaries.length + 1,
              name: event.beneficiaryName,
              accountNumber: event.accountNumber,
            ),
          );
        emit(
          state.copyWith(
            isLoading: false,
            beneficiaries: updatedList,
            error: null,
          ),
        );
      },
    );
  }

  Future<void> _onDeleteBeneficiary(
    DeleteBeneficiary event,
    Emitter<BeneficiariesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

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
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        final updatedList =
            state.beneficiaries
                .where((b) => b.accountNumber != event.accountNumber)
                .toList();
        emit(
          state.copyWith(
            isLoading: false,
            beneficiaries: updatedList,
            error: null,
          ),
        );
      },
    );
  }
}
