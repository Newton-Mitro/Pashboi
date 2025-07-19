import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/public/notice/data/data_sources/local_datasource.dart';
import 'package:pashboi/features/public/notice/data/data_sources/remote_notice_datasource.dart';
import 'package:pashboi/features/public/notice/domain/enities/notice_entity.dart';
import 'package:pashboi/features/public/notice/domain/repositories/notice_repository.dart';

class NoticeRepositoryImpl implements NoticeRepository {
  final NoticeRemoteDataSource remoteDataSource;
  final NoticeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NoticeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  ResultFuture<List<NoticeEntity>> findNotice() async {
    try {
      if (!await networkInfo.isConnected) {
        final noticeResult = await localDataSource.fetchNoticeByCategoryId();
        return Right(noticeResult);
      }
      final result = await remoteDataSource.findNotice();
      await localDataSource.StoreNotice(result);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
