import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/usecases/add_beneficiary_usecase.dart';

part 'add_beneficiary_event.dart';
part 'add_beneficiary_state.dart';

class AddBeneficiaryBloc
    extends Bloc<AddBeneficiaryEvent, AddBeneficiaryState> {
  final GetAuthUserUseCase getAuthUserUseCase;
  final AddBeneficiaryUseCase addBeneficiaryUseCase;

  AddBeneficiaryBloc({
    required this.getAuthUserUseCase,
    required this.addBeneficiaryUseCase,
  }) : super(AddBeneficiaryInitial()) {
    on<AddBeneficiarySubmit>(_onSubmitAddBeneficiary);
  }

  Future<UserEntity?> _getAuthenticatedUser(
    Emitter<AddBeneficiaryState> emit,
  ) async {
    final authUser = await getAuthUserUseCase(NoParams());
    return authUser.fold((failure) {
      emit(const AddBeneficiaryFailure('Failed to load user information'));
      return null;
    }, (success) => success.user);
  }

  Future<void> _onSubmitAddBeneficiary(
    AddBeneficiarySubmit event,
    Emitter<AddBeneficiaryState> emit,
  ) async {
    final errors = <String, String>{};

    if (event.beneficiaryName.trim().isEmpty) {
      errors['beneficiaryName'] = 'Please enter beneficiary name';
    }

    if (event.accountNumber.trim().isEmpty) {
      errors['accountNumber'] = 'Please enter account number';
    }

    if (errors.isNotEmpty) {
      emit(AddBeneficiaryValidationError(errors));
      return;
    }

    emit(const AddBeneficiaryLoading());

    try {
      final user = await _getAuthenticatedUser(emit);
      if (user == null) return;

      final result = await addBeneficiaryUseCase.call(
        AddBeneficiaryProps(
          email: user.loginEmail,
          userId: user.userId,
          rolePermissionId: user.roleId,
          personId: user.personId,
          employeeCode: user.employeeCode,
          mobileNumber: user.regMobile,
          beneficiaryAccountNumber: event.accountNumber,
          beneficiaryName: event.beneficiaryName,
        ),
      );

      result.fold(
        (failure) => emit(AddBeneficiaryFailure(failure.message)),
        (_) => emit(const AddBeneficiarySuccess()),
      );
    } catch (e) {
      emit(AddBeneficiaryFailure(e.toString()));
    }
  }
}
