import 'package:flutter_test/flutter_test.dart';
import 'package:pashboi/features/public/notice/data/models/notice_model.dart';
import 'package:pashboi/features/public/notice/domain/enities/notice_entity.dart';

void main() {
  final noticeData = NoticeModel(
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

  test('Should be subclass of notice entity', () async {
    expect(noticeData, isA<NoticeEntity>());
  });
}
