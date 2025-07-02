import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/entities/beneficiary_entity.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/usecases/add_beneficiary_usecase.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/usecases/fetch_beneficiaries_usecase.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/usecases/remove_beneficiary_usecase.dart';

abstract class BeneficiaryRepository {
  ResultFuture<List<BeneficiaryEntity>> fetchBeneficiaries(
    FetchBeneficiariesProps props,
  );

  ResultFuture<String> addBeneficiary(AddBeneficiaryProps props);

  ResultFuture<String> removeBeneficiary(RemoveBeneficiaryProps props);
}
