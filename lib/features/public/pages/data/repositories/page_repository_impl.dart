import 'package:dartz/dartz.dart';
import 'package:pashboi/core/errors/failures.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/public/pages/data/data_sources/remote_datasource.dart';
import 'package:pashboi/features/public/pages/domain/enities/page_entity.dart';
import 'package:pashboi/features/public/pages/domain/repositories/page_repository.dart';
import 'package:pashboi/features/public/pages/domain/usecases/fetch_page_usecase.dart';

class PageRepositoryImpl implements PageRepository {
  final PageRemoteDataSource pageRemoteDataSource;
  final NetworkInfo networkInfo;

  PageRepositoryImpl({
    required this.pageRemoteDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<PageEntity> findPageByPageSlug(PageProps props) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(FailureMapper.fromException(NoInternetFailure()));
      }
      final result = await pageRemoteDataSource.fetchPageDataByPageSlug(props);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
