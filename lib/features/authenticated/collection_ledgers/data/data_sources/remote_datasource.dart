import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/errors/exceptions.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/utils/json_util.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/data/models/collection_ledger_model.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/entities/collection_aggregate.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/entities/collection_ledger_entity.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/usecases/fetch_collection_ledgers_usecase.dart';
import 'package:pashboi/features/authenticated/profile/data/models/person_model.dart';

abstract class CollectionLedgerRemoteDataSource {
  Future<CollectionAggregate> fetchCollectionLedgers(
    FetchCollectionLedgersProps props,
  );
}

class CollectionLedgerRemoteDataSourceImpl
    implements CollectionLedgerRemoteDataSource {
  final ApiService apiService;

  CollectionLedgerRemoteDataSourceImpl({required this.apiService});

  @override
  Future<CollectionAggregate> fetchCollectionLedgers(
    FetchCollectionLedgersProps props,
  ) async {
    try {
      final response = await apiService.post(
        ApiUrls.getCollectionAccounts,
        data: {
          "UserName": props.email,
          "SearchText": props.searchText,
          "ModuleCode": props.moduleCode,
          "MobileNumber": props.mobileNumber,
          "RolePermission": props.rolePermissionId,
          "ByUserId": props.userId,
          "EmployeeCode": props.employeeCode,
          "PersonId": props.personId,
          "RequestFrom": "MobileApp",
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final dataString = response.data?['Data'];
        final errorMessage = response.data?['Message'];
        final statusMessage = response.data?['Status'];
        if (dataString == null || dataString.isNotEmpty) {
          if (statusMessage != null && statusMessage == "failed") {
            throw ServerException(message: errorMessage);
          } else {
            final jsonResponse = JsonUtil.decodeModel(dataString);

            final collectionLedgers = jsonResponse['AccountInfoList'];

            final mappedLedgersData =
                collectionLedgers
                    .map<CollectionLedgerEntity>(
                      (item) => CollectionLedgerModel.fromJson(item),
                    )
                    .toList();

            final accountHolderInfo = jsonResponse['AccountHolderInfo'];

            final mappedAccountHolderInfo = PersonModel.fromJson(
              accountHolderInfo.first,
            );

            final collectionAggregate = CollectionAggregate(
              ledgers: mappedLedgersData,
              accountHolderInfo: mappedAccountHolderInfo,
            );

            return collectionAggregate;
          }
        }
        throw ServerException(message: "Server Error");
      } else {
        throw ServerException(message: "Server Error");
      }
    } catch (e) {
      rethrow;
    }
  }
}
