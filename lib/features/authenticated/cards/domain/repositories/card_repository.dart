import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/cards/domain/entities/debit_card_entity.dart';
import 'package:pashboi/features/authenticated/cards/domain/usecases/get_my_card_usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/usecases/issue_debit_card_usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/usecases/lock_the_card_usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/usecases/re_issue_debit_card_usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/usecases/verify_card_pin_usecase.dart';

abstract class CardRepository {
  ResultFuture<String> issueDebitCard(
    IssueDebitCardUseCaseProps issueDebitCardUseCaseProps,
  );
  ResultFuture<String> reIssueDebitCard(
    ReIssueDebitCardUsecaseProps reIssueDebitCardUsecaseProps,
  );
  ResultFuture<DebitCardEntity> getMyCard(
    GetMyCardUseCaseProps getMyCardUseCaseProps,
  );
  ResultFuture<String> lockTheCard(
    LockTheCardUseCaseProps lockTheCardUseCaseProps,
  );
  ResultFuture<Object> verifyCardPIN(
    VerifyCardPinUseCaseProps verifyCardPinUseCaseProps,
  );
}
