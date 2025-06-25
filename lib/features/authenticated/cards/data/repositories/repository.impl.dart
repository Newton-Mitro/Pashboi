import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/cards/data/datasources/remote.datasource.dart';
import 'package:pashboi/features/authenticated/cards/domain/entities/debit_card_entity.dart';
import 'package:pashboi/features/authenticated/cards/domain/repositories/card_repository.dart';
import 'package:pashboi/features/authenticated/cards/domain/usecases/get_my_card_usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/usecases/issue_debit_card_usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/usecases/lock_the_card_usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/usecases/re_issue_debit_card_usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/usecases/verify_card_pin_usecase.dart';
import 'package:pashboi/features/authenticated/user/domain/entities/user_entity.dart';

class CardRepositoryImpl implements CardRepository {
  final CardRemoteDataSource cardRemoteDataSource;
  final NetworkInfo networkInfo;

  CardRepositoryImpl({
    required this.cardRemoteDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<DebitCardEntity> getMyCard(
    GetMyCardUseCaseProps getMyCardUseCaseProps,
  ) async {
    try {
      final result = await cardRemoteDataSource.getMyCard(
        getMyCardUseCaseProps,
      );
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<String> issueDebitCard(
    IssueDebitCardUseCaseProps issueDebitCardUseCaseProps,
  ) {
    // TODO: implement issueDebitCard
    throw UnimplementedError();
  }

  @override
  ResultFuture<String> lockTheCard(
    LockTheCardUseCaseProps lockTheCardUseCaseProps,
  ) {
    // TODO: implement lockTheCard
    throw UnimplementedError();
  }

  @override
  ResultFuture<String> reIssueDebitCard(
    ReIssueDebitCardUsecaseProps reIssueDebitCardUsecaseProps,
  ) {
    // TODO: implement reIssueDebitCard
    throw UnimplementedError();
  }

  @override
  ResultFuture<Object> verifyCardPIN(
    VerifyCardPinUseCaseProps verifyCardPinUseCaseProps,
  ) {
    // TODO: implement verifyCardPIN
    throw UnimplementedError();
  }
}
