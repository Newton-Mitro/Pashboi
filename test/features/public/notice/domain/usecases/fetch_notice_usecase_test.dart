import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/public/notice/domain/enities/notice_entity.dart';
import 'package:pashboi/features/public/notice/domain/repositories/notice_repository.dart';
import 'package:pashboi/features/public/notice/domain/usecases/fetch_notice_usecase.dart';

class MockNoticeRepository extends Mock implements NoticeRepository {}

void main() {
  late NoticeUseCase useCase;
  late MockNoticeRepository mockNoticeRepository;

  setUp(() {
    mockNoticeRepository = MockNoticeRepository();
    useCase = NoticeUseCase(noticeRepository: mockNoticeRepository);
  });

  final noticeData = NoticeEntity(
    id: "01jy1k4sfytxshv2gqkj97fxc3",
    title: "Job Circular of Dance Teacher for Nadda",
    slug: "job-circular-of-dance-teacher-for-nadda",
    order: 99,
    shortDescription: "<p>Job Circular of Dance Teacher for Nadda<\/p>",
    description: "<p>Job Circular of Dance Teacher for Nadda<\/p>",
    attachmentUrl: "https:\/\/www.cccul.com\/attachments\/1750252807.jpg",
    attachmentPath: "attachments",
    attachmentName: "1750252807.jpg",
    attachmentMime: "image\/jpeg",
    publishStatus: "Published",
    createdAt: "2025-06-18T13:20:07.000000Z",
    updatedAt: "2025-06-18T13:20:17.000000Z",
  );

  test("notice useCase Test successfully pass ", () async {
    when(
      () => mockNoticeRepository.findNotice(),
    ).thenAnswer((_) async => Right([noticeData]));

    final result = await useCase(NoParams());

    expect(result.isRight(), true);
    expect(result.getOrElse(() => []), [noticeData]);
    verify(() => mockNoticeRepository.findNotice()).called(1);
    verifyNoMoreInteractions(mockNoticeRepository);
  });

  // Add tests here
}
