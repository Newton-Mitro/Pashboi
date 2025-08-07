import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/fetch_bkash_service_charge_usecase.dart';

part 'bkash_service_charge_event.dart';
part 'bkash_service_charge_state.dart';

class BkashServiceChargeBloc
    extends Bloc<BkashServiceChargeEvent, BkashServiceChargeState> {
  final GetAuthUserUseCase getAuthUserUseCase;
  final FetchBkashServiceChargeUseCase fetchBkashServiceChargeUseCase;

  BkashServiceChargeBloc({
    required this.getAuthUserUseCase,
    required this.fetchBkashServiceChargeUseCase,
  }) : super(BkashServiceChargeInitial()) {
    on<FetchBkashServiceChargeEvent>(_onFetchBkashServiceCharge);
  }

  Future<void> _onFetchBkashServiceCharge(
    FetchBkashServiceChargeEvent event,
    Emitter<BkashServiceChargeState> emit,
  ) async {
    emit(BkashServiceChargeLoading());

    try {
      final authUserResult = await getAuthUserUseCase.call(NoParams());

      if (authUserResult.isLeft()) {
        emit(BkashServiceChargeError('Failed to load user information'));
        return;
      }

      final user = authUserResult.getOrElse(() => throw Exception()).user;

      final accountResult = await fetchBkashServiceChargeUseCase.call(
        FetchBkashServiceChargeProps(
          email: user.loginEmail,
          userId: user.userId,
          rolePermissionId: user.roleId,
          personId: user.personId,
          employeeCode: user.employeeCode,
          mobileNumber: user.regMobile,
          amount: event.totalAmount,
        ),
      );

      accountResult.fold(
        (failure) => emit(BkashServiceChargeError(failure.message)),
        (serviceCharge) =>
            emit(BkashServiceChargeLoaded(serviceCharge: serviceCharge)),
      );
    } catch (_) {
      emit(BkashServiceChargeError('Failed to load service charge'));
    }
  }
}
