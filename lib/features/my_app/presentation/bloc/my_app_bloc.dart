import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/services/app_status/app_status_service.dart';
import 'package:pashboi/shared/widgets/language_selector/services/locale_service.dart';

part 'my_app_event.dart';
part 'my_app_state.dart';

class MyAppBloc extends Bloc<MyAppEvent, MyAppState> {
  final LocaleService localeService;
  final AppStatusService appStatusService;
  MyAppBloc(this.localeService, this.appStatusService) : super(MyAppInitial()) {
    on<LoadAppStatusEvent>(_loadAppStatus);
  }

  Future<void> _loadAppStatus(
    LoadAppStatusEvent event,
    Emitter<MyAppState> emit,
  ) async {
    final locale = await localeService.getLocale();
    // emit();
  }
}
