import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/family_and_friends/data/datasources/remote.datasource.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/entities/family_and_friend_entity.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/repositories/family_and_friend_repository.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/usecases/add_family_and_friend_usecase.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/usecases/get_family_and_friends_usecase.dart';

class FamilyAndFriendRepositoryImpl implements FamilyAndFriendRepository {
  final FamilyAndFriendRemoteDataSource familyAndFriendRemoteDataSource;
  final NetworkInfo networkInfo;

  FamilyAndFriendRepositoryImpl({
    required this.familyAndFriendRemoteDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<List<FamilyAndFriendEntity>> getFamilyAndFriends(
    GetFamilyAndFriendsProps params,
  ) async {
    try {
      final result = await familyAndFriendRemoteDataSource.getFamilyAndFriends(
        params,
      );
      final familyAndFriends =
          result.map((e) => e as FamilyAndFriendEntity).toList();

      return Right(familyAndFriends);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<String> addFamilyAndFriend(
    AddFamilyAndFriendProps params,
  ) async {
    try {
      final result = await familyAndFriendRemoteDataSource.addFamilyAndFriend(
        params,
      );
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
