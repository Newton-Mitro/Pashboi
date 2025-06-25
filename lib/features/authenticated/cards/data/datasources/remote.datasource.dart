import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/features/authenticated/cards/domain/entities/debit_card_entity.dart';
import 'package:pashboi/features/authenticated/cards/domain/usecases/get_my_card_usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/usecases/issue_debit_card_usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/usecases/lock_the_card_usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/usecases/re_issue_debit_card_usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/usecases/verify_card_pin_usecase.dart';

abstract class CardRemoteDataSource {
  Future<String> issueDebitCard(
    IssueDebitCardUseCaseProps issueDebitCardUseCaseProps,
  );

  Future<String> reIssueDebitCard(
    ReIssueDebitCardUsecaseProps reIssueDebitCardUsecaseProps,
  );

  Future<DebitCardEntity> getMyCard(
    GetMyCardUseCaseProps getMyCardUseCaseProps,
  );

  Future<String> lockTheCard(LockTheCardUseCaseProps lockTheCardUseCaseProps);

  Future<String> verifyCardPIN(
    VerifyCardPinUseCaseProps verifyCardPinUseCaseProps,
  );
}

class CardRemoteDataSourceImpl implements CardRemoteDataSource {
  final ApiService apiService;

  CardRemoteDataSourceImpl({required this.apiService});

  @override
  Future<String> issueDebitCard(
    IssueDebitCardUseCaseProps issueDebitCardUseCaseProps,
  ) async {
    try {
      final response = await apiService.post(
        ApiUrls.login,
        data: {
          "UserName": issueDebitCardUseCaseProps.email,
          "CardTypeCode": issueDebitCardUseCaseProps.cardTypeCode,
          "WithCard": issueDebitCardUseCaseProps.withCard,
          "MobileNumber": issueDebitCardUseCaseProps.mobileNumber,
          "RolePermission": issueDebitCardUseCaseProps.rolePermissionId,
          "ByUserId": issueDebitCardUseCaseProps.userId,
          "EmployeeCode": issueDebitCardUseCaseProps.employeeCode,
          "PersonId": issueDebitCardUseCaseProps.personId,
          "RequestFrom": "MobileApp",
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final dataString = response.data?['Data'];
        if (dataString == null) throw Exception('Invalid response format');

        return dataString;
      } else {
        throw Exception('Login failed with status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DebitCardEntity> getMyCard(
    GetMyCardUseCaseProps getMyCardUseCaseProps,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<String> lockTheCard(LockTheCardUseCaseProps lockTheCardUseCaseProps) {
    throw UnimplementedError();
  }

  @override
  Future<String> reIssueDebitCard(
    ReIssueDebitCardUsecaseProps reIssueDebitCardUsecaseProps,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<String> verifyCardPIN(
    VerifyCardPinUseCaseProps verifyCardPinUseCaseProps,
  ) {
    throw UnimplementedError();
  }
}
