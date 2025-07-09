import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/features/public/pages/domain/usecases/fetch_page_usecase.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  final PageUseCase pageUseCase;

  PageBloc({required this.pageUseCase}) : super(PageInitial()) {
    on<FetchPageEvent>((event, emit) async {
      emit(PageLoading());

      final dataState = await pageUseCase.call(event.pageProps);

      dataState.fold(
        (failure) {
          emit(PageError(error: failure.message));
        },
        (pageData) {
          emit(PageSuccess(pageData: pageData));
        },
      );
    });
  }
}
