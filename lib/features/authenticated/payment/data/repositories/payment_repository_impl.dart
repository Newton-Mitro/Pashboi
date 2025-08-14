import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/payment/data/datasources/payment_remote_datasource.dart';
import 'package:pashboi/features/authenticated/payment/domain/entities/service_entity.dart';
import 'package:pashboi/features/authenticated/payment/domain/repositories/payment_repository.dart';
import 'package:pashboi/features/authenticated/payment/domain/usecases/fetch_payment_services_usecase.dart';
import 'package:pashboi/features/authenticated/payment/domain/usecases/submit_payment_usecase.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource paymentRemoteDataSource;
  final NetworkInfo networkInfo;

  PaymentRepositoryImpl({
    required this.paymentRemoteDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<List<ServiceEntity>> fetchPaymentServices(
    FetchPaymentServicesProps props,
  ) async {
    try {
      final result = await paymentRemoteDataSource.fetchPaymentServices(props);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<String> submitPayment(SubmitPaymentProps props) async {
    try {
      final result = await paymentRemoteDataSource.submitPayment(props);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
