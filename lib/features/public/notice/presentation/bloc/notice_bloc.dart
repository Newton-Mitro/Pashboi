import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/public/notice/domain/enities/notice_entity.dart';
import 'package:pashboi/features/public/notice/domain/usecases/fetch_notice_usecase.dart';

part 'notice_event.dart';
part 'notice_state.dart';

class NoticeBloc extends Bloc<NoticeEvent, NoticeState> {
  final NoticeUseCase noticeUseCase;

  NoticeBloc({required this.noticeUseCase}) : super(NoticeInitial()) {
    on<NoticeEvent>((event, emit) async {
      emit(NoticeLoading());

      final dataState = await noticeUseCase.call(NoParams());
      dataState.fold(
        (failure) {
          emit(NoticeError(error: failure.message));
        },
        (notices) {
          emit(NoticeSuccess(notices: notices));
        },
      );
    });
  }
}
