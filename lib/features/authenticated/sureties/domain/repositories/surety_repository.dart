import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/sureties/domain/entities/surety_entity.dart';
import 'package:pashboi/features/authenticated/sureties/domain/usecases/fetch_given_sureties_usecase.dart';
import 'package:pashboi/features/authenticated/sureties/domain/usecases/fetch_loan_sureties_usecase.dart';

abstract class SuretyRepository {
  ResultFuture<List<SuretyEntity>> fetchGivenSureties(
    FetchGivenSuretiesProps props,
  );
  ResultFuture<List<SuretyEntity>> fetchLoanSureties(
    FetchLoanSuretiesProps props,
  );
}
