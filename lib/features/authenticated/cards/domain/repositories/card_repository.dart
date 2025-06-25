import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/cards/domain/entities/debit_card_entity.dart';
import 'package:pashboi/features/authenticated/user/domain/entities/user_entity.dart';

abstract class CardRepository {
  ResultFuture<String> issueDebitCard(
    UserEntity user,
    String cardTypeCode,
    bool withCard,
  );
  ResultFuture<String> reIssueDebitCard(
    UserEntity user,
    String cardNumber,
    String cardTypeCode,
    bool virtualCard,
    String nameOnCard,
  );
  ResultFuture<DebitCardEntity> getMyCard(UserEntity user);
  ResultFuture<String> lockTheCard(
    UserEntity user,
    String cardNumber,
    String accountNumber,
    String nameOnCard,
  );
  ResultFuture<Object> verifyCardPIN(
    UserEntity user,
    String cardNumber,
    String nameOnCare,
    String cardPIN,
  );
}
