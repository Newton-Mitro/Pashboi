import 'package:dartz/dartz.dart';
import 'package:pashboi/core/errors/failures.dart';
import 'package:pashboi/core/services/app_status/app_status_service.dart';
import 'package:pashboi/core/types/typedef.dart';

class AppStatusServiceImpl implements AppStatusService {
  @override
  ResultFuture<bool> isUnderConstruction() async {
    // Call your real API here.
    return Left(NetworkFailure(statusCode: -1));
    // await Future.delayed(const Duration(milliseconds: 500));
    // return false; // example
  }
}
