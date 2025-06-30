import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/profile/data/datasources/remote.datasource.dart';
import 'package:pashboi/features/authenticated/profile/domain/entities/person_entity.dart';
import 'package:pashboi/features/authenticated/profile/domain/repositories/profile_repository.dart';
import 'package:pashboi/features/authenticated/profile/domain/usecases/get_profile_usecase.dart';
import 'package:pashboi/features/authenticated/profile/domain/usecases/update_profile_image_usecase.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.profileRemoteDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<PersonEntity> getProfile(GetProfileProps props) async {
    try {
      final result = await profileRemoteDataSource.getProfile(props);
      return Right(result as PersonEntity);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<String> updateProfileImage(UpdateProfileImageProps props) async {
    try {
      final result = await profileRemoteDataSource.updateProfileImage(props);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
