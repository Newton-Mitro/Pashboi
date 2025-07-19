import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pashboi/core/errors/failures.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/features/public/notice/data/data_sources/local_datasource.dart';
import 'package:pashboi/features/public/notice/data/data_sources/remote_notice_datasource.dart';
import 'package:pashboi/features/public/notice/data/models/notice_model.dart';
import 'package:pashboi/features/public/notice/data/repositories/notice_repository_impl.dart';
import 'package:pashboi/features/public/notice/domain/enities/notice_entity.dart';

// ✅ Fix: Create proper mocks
class MockNoticeRemoteDataSource extends Mock
    implements NoticeRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockNoticeLocalDataSource extends Mock implements NoticeLocalDataSource {}

void main() {
  late MockNoticeRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MockNoticeLocalDataSource mockLocalDataSource;
  late NoticeRepositoryImpl repository;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockNoticeRemoteDataSource();
    mockLocalDataSource = MockNoticeLocalDataSource();

    repository = NoticeRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
      localDataSource: mockLocalDataSource,
    );
  });

  final responseData = [
    {
      "id": "01jy1k4sfytxshv2gqkj97fxc3",
      "title": "Job Circular of Dance Teacher for Nadda",
      "slug": "job-circular-of-dance-teacher-for-nadda",
      "order": 99,
      "short_description": "<p>Job Circular of Dance Teacher for Nadda</p>",
      "description": "<p>Job Circular of Dance Teacher for Nadda</p>",
      "attachment_url": "https://www.cccul.com/attachments/1750252807.jpg",
      "attachment_path": "attachments",
      "attachment_name": "1750252807.jpg",
      "attachment_mime": "image/jpeg",
      "publish_status": "Published",
      "created_at": "2025-06-18T13:20:07.000000Z",
      "updated_at": "2025-06-18T13:20:17.000000Z",
    },
  ];

  final noticeModelList =
      responseData.map((json) => NoticeModel.fromJson(json)).toList();

  group('NoticeRepositoryImpl', () {
    test("should check if the device is online", () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => mockRemoteDataSource.findNotice(),
      ).thenAnswer((_) async => noticeModelList);
      when(
        () => mockLocalDataSource.StoreNotice(any()),
      ).thenAnswer((_) async => Future.value());

      await repository.findNotice();

      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    test("should return data from remote if connected", () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => mockRemoteDataSource.findNotice(),
      ).thenAnswer((_) async => noticeModelList);
      when(
        () => mockLocalDataSource.StoreNotice(any()),
      ).thenAnswer((_) async => Future.value());

      final result = await repository.findNotice();

      verify(() => mockRemoteDataSource.findNotice()).called(1);
      verify(() => mockLocalDataSource.StoreNotice(noticeModelList)).called(1);
      expect(result, Right<Failure, List<NoticeEntity>>(noticeModelList));
    });

    test("should return local data if offline", () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(
        () => mockLocalDataSource.fetchNoticeByCategoryId(),
      ).thenAnswer((_) async => noticeModelList);

      final result = await repository.findNotice();

      verify(() => mockLocalDataSource.fetchNoticeByCategoryId()).called(1);
      expect(result, Right<Failure, List<NoticeEntity>>(noticeModelList));
    });
  });
}
