import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/entities/collection_aggregate.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/usecases/fetch_collection_ledgers_usecase.dart';

abstract class CollectionLedgerRepository {
  ResultFuture<CollectionAggregate> fetchCollectionLedgers(
    FetchCollectionLedgersProps props,
  );
}
