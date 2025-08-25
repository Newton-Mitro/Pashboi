import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/entities/leave_application_entites.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/usecase/get_leave_approval_usecase.dart';

part 'leave_approval_event.dart';
part 'leave_approval_state.dart';

class LeaveApprovalBloc extends Bloc<LeaveApprovalEvent, LeaveApprovalState> {
  final GetAuthUserUseCase getAuthUserUseCase;
  final GetLeaveApprovalUseCase getLeaveApprovalUseCase;

  LeaveApprovalBloc({
    required this.getAuthUserUseCase,
    required this.getLeaveApprovalUseCase,
  }) : super(LeaveApprovalInitial()) {
    on<LeaveApprovalEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
