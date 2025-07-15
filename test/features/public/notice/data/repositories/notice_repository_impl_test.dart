import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pashboi/core/errors/failures.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/services/network/product_api_service.dart';
import 'package:pashboi/features/public/notice/data/data_sources/remote_notice_datasource.dart';
import 'package:pashboi/features/public/notice/data/models/notice_model.dart';
import 'package:pashboi/features/public/notice/data/repositories/notice_repository_impl.dart';
import 'package:pashboi/features/public/notice/domain/enities/notice_entity.dart';

class MockProductApiService extends Mock implements ProductApiService {}

class MockNoticeRemoteDataSource extends Mock
    implements NoticeRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  // Declare variables here
  late MockNoticeRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late NoticeRepositoryImpl repository;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockNoticeRemoteDataSource();
    repository = NoticeRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
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

  final finalRes =
      responseData.map((json) => NoticeModel.fromJson(json)).toList();

  group('Device is online', () {
    test("should return data from remote data source if connected", () async {
      // Arrange
      when(
        () => mockRemoteDataSource.findNotice(),
      ).thenAnswer((_) async => finalRes);

      // Act
      final result = await repository.findNotice();

      // Assert
      verify(() => mockRemoteDataSource.findNotice()).called(1);

      expect(result, Right<Failure, List<NoticeEntity>>(finalRes));
    });
  });
}
