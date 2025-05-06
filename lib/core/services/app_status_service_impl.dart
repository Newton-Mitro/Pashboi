import 'package:pashboi/core/services/app_status_service.dart';

class AppStatusServiceImpl implements AppStatusService {
  @override
  Future<bool> isUnderConstruction() async {
    // Call your real API here.
    await Future.delayed(const Duration(milliseconds: 500));
    return false; // example
  }
}
