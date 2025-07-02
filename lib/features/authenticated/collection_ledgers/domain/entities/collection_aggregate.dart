import 'package:pashboi/features/authenticated/collection_ledgers/domain/entities/collection_ledger_entity.dart';
import 'package:pashboi/features/authenticated/profile/domain/entities/person_entity.dart';

class CollectionAggregate {
  final List<CollectionLedgerEntity> ledgers;
  final PersonEntity accountHolderInfo;

  const CollectionAggregate({
    required this.ledgers,
    required this.accountHolderInfo,
  });
}
