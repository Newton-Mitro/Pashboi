import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/entities/collection_aggregate.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/repositories/collection_ledger_repository.dart';

class FetchCollectionLedgersProps extends BaseRequestProps {
  final String searchText;
  final String moduleCode;

  const FetchCollectionLedgersProps({
    required this.searchText,
    required this.moduleCode,
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class FetchCollectionLedgersUseCase
    extends UseCase<CollectionAggregate, FetchCollectionLedgersProps> {
  final CollectionLedgerRepository collectionLedgerRepository;

  FetchCollectionLedgersUseCase({required this.collectionLedgerRepository});

  @override
  ResultFuture<CollectionAggregate> call(
    FetchCollectionLedgersProps props,
  ) async {
    return collectionLedgerRepository.fetchCollectionLedgers(props);
  }
}
