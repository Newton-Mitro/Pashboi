import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/data/data_sources/remote_datasource.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/entities/collection_aggregate.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/repositories/collection_ledger_repository.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/usecases/fetch_collection_ledgers_usecase.dart';

class CollectionLedgerRepositoryImpl implements CollectionLedgerRepository {
  final CollectionLedgerRemoteDataSource collectionLedgerRemoteDataSource;
  final NetworkInfo networkInfo;

  CollectionLedgerRepositoryImpl({
    required this.collectionLedgerRemoteDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<CollectionAggregate> fetchCollectionLedgers(
    FetchCollectionLedgersProps props,
  ) async {
    try {
      final result = await collectionLedgerRemoteDataSource
          .fetchCollectionLedgers(props);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
