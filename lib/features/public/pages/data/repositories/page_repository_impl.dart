import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/public/pages/data/data_sources/local_datasource.dart';
import 'package:pashboi/features/public/pages/data/data_sources/remote_datasource.dart';
import 'package:pashboi/features/public/pages/domain/enities/page_entity.dart';
import 'package:pashboi/features/public/pages/domain/repositories/page_repository.dart';
import 'package:pashboi/features/public/pages/domain/usecases/fetch_page_usecase.dart';

class PageRepositoryImpl implements PageRepository {
  final PageRemoteDataSource pageRemoteDataSource;
  final PageLocalDataSource pageLocalDataSource;
  final NetworkInfo networkInfo;

  PageRepositoryImpl({
    required this.pageRemoteDataSource,
    required this.networkInfo,
    required this.pageLocalDataSource,
  });

  @override
  ResultFuture<PageEntity> findPageByPageSlug(PageProps props) async {
    try {
      if (!await networkInfo.isConnected) {
        final localPages = await pageLocalDataSource.fetchPage(props.pageSlug);
        if (localPages == null)
          throw Exception('No local page found for slug: ${props.pageSlug}');

        return Right(localPages);
      }
      final result = await pageRemoteDataSource.fetchPageDataByPageSlug(props);
      await pageLocalDataSource.storePage(result, props.pageSlug);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
